//
//  BOTableViewController.m
//  Bohr
//
//  Created by David Román Aguirre on 31/5/15.
//  Copyright (c) 2015 David Roman. All rights reserved.
//

#import "BOTableViewController.h"

#import "BOTableViewController+Private.h"
#import "BOTableViewCell+Private.h"
#import "BOTableViewCell+Subclass.h"
#import "BOSetting+Private.h"

@interface BOTableViewController ()

@property (nonatomic) NSArray *sections;
@property (nonatomic) NSArray *footerViews;

@end

@implementation BOTableViewController

- (void)commonInit {
	self.sections = [NSArray new];
	
	self.tableView.estimatedRowHeight = 55;
	self.tableView.rowHeight = UITableViewAutomaticDimension;
	self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
	self.tableView.tableFooterView = [UIView new];
	
	UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self.tableView action:@selector(endEditing:)];
	tapGestureRecognizer.cancelsTouchesInView = NO;
	[self.tableView addGestureRecognizer:tapGestureRecognizer];
	
	[self setup];
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
	if (self = [super initWithStyle:style]) {
		[self commonInit];
	}
	
	return self;
}

- (instancetype)init {
	return [self initWithStyle:UITableViewStyleGrouped];
}

- (void)awakeFromNib {
	[self commonInit];
}

- (void)addSection:(BOTableViewSection *)section {
	self.sections = [self.sections arrayByAddingObject:section];
}

// Apple pls http://blog.supertop.co/post/80781694515/viewmightappear

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	NSIndexPath *selectedRowIndexPath = [self.tableView indexPathForSelectedRow];
	
	if (selectedRowIndexPath) {
		[self.tableView deselectRowAtIndexPath:selectedRowIndexPath animated:YES];
		
		[[self.navigationController transitionCoordinator] notifyWhenInteractionEndsUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext> context) {
			if ([context isCancelled]) {
				[self.tableView selectRowAtIndexPath:selectedRowIndexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
			}
		}];
	}
}

#pragma mark Headers & Cells

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)sectionIndex {
	BOTableViewSection *section = self.sections[sectionIndex];
	return section.headerTitle;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UITableViewHeaderFooterView *)headerView forSection:(NSInteger)sectionIndex {
	BOTableViewSection *section = self.sections[sectionIndex];
	if (section.headerTitleColor) headerView.textLabel.textColor = section.headerTitleColor;
	if (section.headerTitleFont) headerView.textLabel.font = section.headerTitleFont;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex {
	BOTableViewSection *section = self.sections[sectionIndex];
	return section.cells.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	BOTableViewSection *section = self.sections[indexPath.section];
	BOTableViewCell *cell = section.cells[indexPath.row];
	
	CGFloat cellHeight = MAX(self.tableView.estimatedRowHeight, [self heightForCell:cell]);
	cell.height = cellHeight;
	
	if ([self.expansionIndexPath isEqual:indexPath]) {
		cellHeight += [cell expansionHeight];
	}
	
	return cellHeight;
}

- (CGFloat)heightForCell:(BOTableViewCell *)cell {
	
	if ([cell expansionHeight] > 0) {
		UITableViewCell *cleanCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
		cleanCell.frame = CGRectMake(0, 0, cell.frame.size.width, 0);
		cleanCell.textLabel.numberOfLines = 0;
		cleanCell.textLabel.text = cell.textLabel.text;
		cleanCell.accessoryView = cell.accessoryView;
		cleanCell.accessoryType = cell.accessoryType;
		return [cleanCell systemLayoutSizeFittingSize:cleanCell.frame.size].height;
	}
	
	return [cell systemLayoutSizeFittingSize:cell.frame.size].height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	BOTableViewSection *section = self.sections[indexPath.section];
	BOTableViewCell *cell = section.cells[indexPath.row];
	cell.indexPath = indexPath;
	
	if (cell.setting && !cell.setting.valueDidChangeBlock) {
		__unsafe_unretained typeof(self) weakSelf = self;
		__unsafe_unretained typeof(cell) weakCell = cell;
		cell.setting.valueDidChangeBlock = ^{
			dispatch_async(dispatch_get_main_queue(), ^{
				[weakCell settingValueDidChange];
				[weakSelf reloadTableView];
			});
		};
		
		[UIView performWithoutAnimation:^{
			[cell settingValueDidChange];
		}];
	}
	
	return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(BOTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
	[cell _updateAppearance];
	[cell updateAppearance];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	BOTableViewCell *cell = (BOTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
	
	if ([cell expansionHeight] > 0) {
		self.expansionIndexPath = ![indexPath isEqual:self.expansionIndexPath] ? indexPath : nil;
		
		[self.tableView deselectRowAtIndexPath:indexPath animated:NO];
		[self.tableView beginUpdates];
		[self.tableView endUpdates];
		[self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
	} else if (cell.destinationViewController) {
		[self.navigationController pushViewController:cell.destinationViewController animated:YES];
	} else if ([cell respondsToSelector:@selector(wasSelectedFromViewController:)]) {
		[cell wasSelectedFromViewController:self];
	}
	
	if (cell.accessoryType != UITableViewCellAccessoryDisclosureIndicator) {
		[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
	}
}

#pragma mark Dynamic options

- (void)reloadTableView {
	
	NSMutableIndexSet *affectedIndexes = [NSMutableIndexSet new];
	
	for (NSInteger s = 0; s < self.sections.count; s++) {
		NSInteger numberOfRows = [self.tableView numberOfRowsInSection:s];
		
		if (numberOfRows != [self.sections[s] cells].count) {
			[affectedIndexes addIndex:s];
		} else {
			for (NSInteger r = 0; r < numberOfRows; r++) {
				UITableViewCell *lastCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:r inSection:s]];
				if ([self.tableView.visibleCells containsObject:lastCell] && ![[self.sections[s] cells] containsObject:lastCell]) {
					[affectedIndexes addIndex:s];
				}
			}
		}
	}
	
	if (affectedIndexes.count > 0) {
		[self.tableView beginUpdates];
		[self.tableView reloadSections:affectedIndexes withRowAnimation:UITableViewRowAnimationFade];
		[self.tableView endUpdates];
	}
	
	[UIView performWithoutAnimation:^{
		CGPoint previousContentOffset = self.tableView.contentOffset;
		[self.tableView beginUpdates];
		[self.tableView endUpdates];
		self.tableView.contentOffset = previousContentOffset;
	}];
}

#pragma mark Dynamic footers

- (NSArray *)footerViews {
	if (!_footerViews) {
		_footerViews = [NSArray new];
		
		for (NSInteger i = 0; i < [self.tableView numberOfSections]; i++) {
			UITableViewHeaderFooterView *footerView = [UITableViewHeaderFooterView new];
			_footerViews = [_footerViews arrayByAddingObject:footerView];
		}
	}
	
	return _footerViews;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
	UITableViewHeaderFooterView *footerView = self.footerViews[section];
	footerView.textLabel.text = [self tableView:tableView titleForFooterInSection:section];
	// Super hacky code for iOS 9 support.
	footerView.textLabel.numberOfLines = 0;
	CGPoint previousOrigin = footerView.textLabel.frame.origin;
	[footerView sizeToFit];
	footerView.textLabel.frame = CGRectMake(previousOrigin.x, previousOrigin.y, footerView.textLabel.frame.size.width, footerView.textLabel.frame.size.height);
	
	return footerView.intrinsicContentSize.height;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)sectionIndex {
	
	// First, we get the section value, and if it's nil we set it to an empty string (this is the lowest priority for dynamic footers).
	BOTableViewSection *section = self.sections[sectionIndex];
	NSString *footerTitle = section.footerTitle;
	
	// Next, we try to find an existing footer in the last cell of the section (this is the medium priority for dynamic footers).
	BOTableViewCell *lastCell = [section.cells lastObject];
	if ([lastCell footerTitle]) footerTitle = [lastCell footerTitle];
	
	// Finally, we try to find an existing footer in any cell that has a checkmark accessory on it (this is the top priority for dynamic footers).
	for (BOTableViewCell *cell in section.cells) {
		if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
			footerTitle = cell.footerTitle;
		}
	}
	
	return footerTitle ? footerTitle : @"";
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)sectionIndex {
	UITableViewHeaderFooterView *footerView = self.footerViews[sectionIndex];
	if (![[self tableView:tableView titleForFooterInSection:sectionIndex] isEqualToString:@""]) {
		return footerView;
	}
	return nil;
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UITableViewHeaderFooterView *)footerView forSection:(NSInteger)sectionIndex {
	BOTableViewSection *section = self.sections[sectionIndex];
	if (section.footerTitleColor) footerView.textLabel.textColor = section.footerTitleColor;
	if (section.footerTitleFont) footerView.textLabel.font = section.footerTitleFont;
}

#pragma mark Subclassing

- (void)setup {}

@end
