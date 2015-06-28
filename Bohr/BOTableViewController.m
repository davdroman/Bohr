//
//  BOTableViewController.m
//  Bohr
//
//  Created by David Román Aguirre on 31/5/15.
//  Copyright (c) 2015 David Roman. All rights reserved.
//

#import "BOTableViewController.h"

#import "BOTableViewController+Private.h"
#import "BOTableViewCell+Subclass.h"
#import "BOSetting+Private.h"

@interface BOTableViewController ()

@property (nonatomic, strong) NSArray *footerViews;

@end

@implementation BOTableViewController

- (void)awakeFromNib {
	[self loadView];
	UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tableViewReceivedTap)];
	tapGestureRecognizer.cancelsTouchesInView = NO;
	[self.tableView addGestureRecognizer:tapGestureRecognizer];
	self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
	self.tableView.tableFooterView = [UIView new];
	[self setup];
}

- (void)tableViewReceivedTap {
	[self.tableView endEditing:YES];
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

#pragma mark Headers & cells

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
	UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
	
	if (self.headerTitlesColor) header.textLabel.textColor = self.headerTitlesColor;
	if (self.headerTitlesFont) header.textLabel.font = self.headerTitlesFont;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat rowHeight = MAX(self.tableView.rowHeight, [super tableView:tableView heightForRowAtIndexPath:indexPath]);
    
    BOTableViewCell *cell = (BOTableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    if ([cell isKindOfClass:[BOTableViewCell class]]) {
        return rowHeight + ([indexPath isEqual:self.expansionIndexPath] ? [cell expansionHeight] : 0);
    }
    
    return rowHeight;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(BOTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell isKindOfClass:[BOTableViewCell class]]) {
		cell.indexPath = indexPath;
		
		if (cell.layoutMargins.top == 8) {
			CGFloat cellHeight = [self tableView:tableView heightForRowAtIndexPath:indexPath];
			cell.layoutMargins = UIEdgeInsetsMake(cellHeight, cell.layoutMargins.left, cell.layoutMargins.bottom, cell.layoutMargins.right);
		}
		
		if (cell.setting && !cell.setting.valueDidChangeBlock) {
			__unsafe_unretained typeof(cell) _cell = cell;
			__unsafe_unretained typeof(self) _self = self;
			cell.setting.valueDidChangeBlock = ^{
				[_cell settingValueDidChange];
				[_self reloadTableView];
			};
			
			[UIView performWithoutAnimation:^{
				[cell settingValueDidChange];
			}];
		}
		
		[cell updateAppearance];
	}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	BOTableViewCell *cell = (BOTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
	
	if (cell.expansionHeight > 0) {
		self.expansionIndexPath = ![cell.indexPath isEqual:self.expansionIndexPath] ? cell.indexPath : nil;
		
		[self.tableView deselectRowAtIndexPath:cell.indexPath animated:NO];
		[self.tableView beginUpdates];
		[self.tableView endUpdates];
		[self.tableView scrollToRowAtIndexPath:cell.indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
	} else {
		if (cell.accessoryType != UITableViewCellAccessoryDisclosureIndicator) {
			[self.tableView deselectRowAtIndexPath:cell.indexPath animated:YES];
		}
	}
	
	if ([cell respondsToSelector:@selector(wasSelectedFromViewController:)]) [cell wasSelectedFromViewController:self];
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

- (void)reloadTableView {
	[UIView performWithoutAnimation:^{
		[self.tableView beginUpdates];
		[self.tableView endUpdates];
	}];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
	UITableViewHeaderFooterView *footerView = self.footerViews[section];
	footerView.textLabel.text = [self tableView:tableView titleForFooterInSection:section];
	
	return [super tableView:tableView heightForFooterInSection:section];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
	// First, we get the super value, and if it's nil we set it to an empty string (this is the lowest priority for dynamic footers).
	NSString *footerTitle = [super tableView:self.tableView titleForFooterInSection:section];
	if (!footerTitle) footerTitle = @"";
	
	// Next, we try to find an existing footer in the last cell of the section (this is the medium priority for dynamic footers).
	NSInteger numberOfRows = [super tableView:self.tableView numberOfRowsInSection:section];
	BOTableViewCell *lastCell = (BOTableViewCell *)[super tableView:self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:numberOfRows-1 inSection:section]];
	if ([lastCell isKindOfClass:[BOTableViewCell class]] && [lastCell footerTitle]) footerTitle = [lastCell footerTitle];
	
	// Finally, we try to find an existing footer in any cell that has a checkmark accessory on it (this is the top priority for dynamic footers).
	for (NSInteger i = 0; i < numberOfRows; i++) {
		BOTableViewCell *cell = (BOTableViewCell *)[super tableView:self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:section]];
		
		if ([lastCell isKindOfClass:[BOTableViewCell class]] && cell.accessoryType == UITableViewCellAccessoryCheckmark) {
			footerTitle = [cell footerTitle];
		}
	}
	
	return footerTitle;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
	UITableViewHeaderFooterView *footerView = self.footerViews[section];
	return footerView;
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
	UITableViewHeaderFooterView *footer = (UITableViewHeaderFooterView *)view;
	
	if (self.footerTitlesColor) footer.textLabel.textColor = self.footerTitlesColor;
	if (self.footerTitlesFont) footer.textLabel.font = self.footerTitlesFont;
}

#pragma mark Subclassing

- (void)setup {}

@end
