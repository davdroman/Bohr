//
//  BOTableViewController.m
//  Bohr
//
//  Created by David Román Aguirre on 31/5/15.
//  Copyright (c) 2015 David Roman. All rights reserved.
//

#import "BOTableViewController+Private.h"

#import "BOTableViewSection.h"
#import "BOTableViewCell+Subclass.h"

@interface BOTableViewController ()

@property (nonatomic, strong) NSArray *sections;

@end

@implementation BOTableViewController

- (instancetype)initWithStyle:(UITableViewStyle)style {
	if (self = [super initWithStyle:style]) {
		self.sections = [NSArray new];
		self.tableView.rowHeight = 58;
		self.tableView.tableFooterView = [UIView new];
		
		[self setup];
	}
	
	return self;
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

- (BOTableViewCell *)cellForIndexPath:(NSIndexPath *)indexPath {
	return [self.sections[indexPath.section] cells][indexPath.row];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return self.sections.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return [self.sections[section] headerTitle];
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)sectionIndex {
	UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
	BOTableViewSection *section = self.sections[sectionIndex];
	[tableView addSubview:section]; // This hack is necessary in order for UIAppearance to work properly.
	
	if (section.mainColor) header.textLabel.textColor = section.mainColor;
	if (section.mainFont) header.textLabel.font = section.mainFont;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex {
	BOTableViewSection *section = self.sections[sectionIndex];
	
	return section.cells.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	BOTableViewCell *cell = [self cellForIndexPath:indexPath];
	return tableView.rowHeight + ([indexPath isEqual:self.expansionIndexPath] ? cell.expansionHeight : 0);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	BOTableViewCell *cell = [self cellForIndexPath:indexPath];
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	BOTableViewCell *cell = [self cellForIndexPath:indexPath];
	if ([cell respondsToSelector:@selector(wasSelectedFromViewController:)]) [cell wasSelectedFromViewController:self];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
	return [self.sections[section] footerTitle];
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)sectionIndex {
	UITableViewHeaderFooterView *footer = (UITableViewHeaderFooterView *)view;
	BOTableViewSection *section = self.sections[sectionIndex];
	[tableView addSubview:section];
	
	if (section.secondaryColor) footer.textLabel.textColor = section.secondaryColor;
	if (section.secondaryFont) footer.textLabel.font = section.secondaryFont;
}

#pragma mark Subclassing

- (void)setup {}

- (void)addSections:(NSArray *)sections {
	self.sections = [self.sections arrayByAddingObjectsFromArray:sections];
}

@end
