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

- (NSArray *)footerViews {
	if (!_footerViews) {
		_footerViews = [NSArray new];
		
		for (NSInteger i = 0; i < [self.tableView numberOfSections]; i++) {
			NSString *footerTitle = [self tableView:self.tableView titleForFooterInSection:i];
			
			if (footerTitle) {
				UITableViewHeaderFooterView *footerView = [UITableViewHeaderFooterView new];
				_footerViews = [_footerViews arrayByAddingObject:footerView];
			} else {
				_footerViews = [_footerViews arrayByAddingObject:[NSNull null]];
			}
		}
	}
	
	return _footerViews;
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	[self.tableView beginUpdates];
	[self.tableView endUpdates];
	
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

// Apple pls http://blog.supertop.co/post/80781694515/viewmightappear

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

- (void)reloadTableView {
	[UIView performWithoutAnimation:^{
		[self updateFooters];
		[self.tableView beginUpdates];
		[self.tableView endUpdates];
	}];
}

- (void)updateFooters {
	for (NSInteger i = 0; i < [self.tableView numberOfSections]; i++) {
		NSString *footerTitle = [self tableView:self.tableView titleForFooterInSection:i];
		UITableViewHeaderFooterView *footerView = self.footerViews[i];
		if (![footerView isEqual:[NSNull null]]) {
			footerView.textLabel.text = footerTitle;
			[footerView sizeToFit];
		}
	}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	BOTableViewCell *cell = (BOTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
	if ([cell respondsToSelector:@selector(wasSelectedFromViewController:)]) [cell wasSelectedFromViewController:self];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
	UITableViewHeaderFooterView *footerView = self.footerViews[section];
	
	if (![footerView isEqual:[NSNull null]]) {
		footerView.textLabel.text = [self tableView:tableView titleForFooterInSection:section];
		return footerView;
	}
	
	return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
	NSString *footerTitle = [super tableView:self.tableView titleForFooterInSection:section];
	if (!footerTitle) footerTitle = @"";
	
	NSInteger numberOfRows = [super tableView:self.tableView numberOfRowsInSection:section];
	BOTableViewCell *lastCell = (BOTableViewCell *)[super tableView:self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:numberOfRows-1 inSection:section]];
	if ([lastCell isKindOfClass:[BOTableViewCell class]] && [lastCell footerTitle]) footerTitle = [lastCell footerTitle];
	
	for (NSInteger i = 0; i < numberOfRows; i++) {
		BOTableViewCell *cell = (BOTableViewCell *)[super tableView:self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:section]];
		
		if ([lastCell isKindOfClass:[BOTableViewCell class]] && cell.accessoryType == UITableViewCellAccessoryCheckmark) {
			footerTitle = [cell footerTitle];
		}
	}
	
	return footerTitle;
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
	UITableViewHeaderFooterView *footer = (UITableViewHeaderFooterView *)view;
	
	if (self.footerTitlesColor) footer.textLabel.textColor = self.footerTitlesColor;
	if (self.footerTitlesFont) footer.textLabel.font = self.footerTitlesFont;
}

#pragma mark Subclassing

- (void)setup {}

@end
