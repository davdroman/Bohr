//
//  BOTableViewCell.m
//  Bohr
//
//  Created by David Román Aguirre on 31/5/15.
//  Copyright (c) 2015 David Roman. All rights reserved.
//

#import "BOTableViewCell+Subclass.h"

#import "BOTableViewController+Private.h"
#import "BOSetting+Private.h"

@interface BOTableViewCell ()

@property (nonatomic, assign) UITableView *tableView;

@end

@implementation BOTableViewCell

+ (instancetype)cellWithTitle:(NSString *)title setting:(BOSetting *)setting {
	return [[self alloc] initWithTitle:title setting:setting];
}

- (instancetype)initWithTitle:(NSString *)title setting:(BOSetting *)setting {
	if (self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil]) {
		self.clipsToBounds = YES;
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		
		self.textLabel.text = title;
		self.setting = setting;
		
		[self setup];
	}
	
	return self;
}

- (void)willMoveToWindow:(UIWindow *)newWindow {
	if (self.setting && !self.setting.valueDidChangeBlock) {
		__unsafe_unretained typeof(self) _self = self;
		self.setting.valueDidChangeBlock = ^{
			[_self settingValueDidChange];
		};
		self.setting.valueDidChangeBlock();
	}
}

- (void)layoutSubviews {
	[super layoutSubviews];
	
	self.textLabel.frame = CGRectMake(self.textLabel.frame.origin.x, 0, self.textLabel.frame.size.width, self.tableView.rowHeight);
	self.detailTextLabel.frame = CGRectMake(self.detailTextLabel.frame.origin.x, 0, self.detailTextLabel.frame.size.width, self.tableView.rowHeight);
}

- (UITableView *)tableView {
	return (UITableView *)self.superview.superview;
}

#pragma mark Customization

- (void)setMainColor:(UIColor *)mainColor {
	_mainColor = mainColor;
	self.textLabel.textColor = mainColor;
	[self updateAppearance];
}

- (void)setMainFont:(UIFont *)mainFont {
	_mainFont = mainFont;
	self.textLabel.font = mainFont;
	[self updateAppearance];
}

- (void)setSecondaryColor:(UIColor *)secondaryColor {
	_secondaryColor = secondaryColor;
	self.textLabel.highlightedTextColor = [UIColor whiteColor];
	self.detailTextLabel.textColor = secondaryColor;
	self.detailTextLabel.highlightedTextColor = [UIColor whiteColor];
	[self updateAppearance];
}

- (void)setSecondaryFont:(UIFont *)secondaryFont {
	_secondaryFont = secondaryFont;
	self.detailTextLabel.font = secondaryFont;
	[self updateAppearance];
}

- (void)setSelectedColor:(UIColor *)selectedColor {
	_selectedColor = selectedColor;
	
	self.selectedBackgroundView = [UIView new];
	self.selectedBackgroundView.backgroundColor = selectedColor;
}

- (void)removeFromSuperview {} // Disable cell reuse *completely*

#pragma mark Subclassing

- (void)setup {}
- (void)updateAppearance {}

- (void)wasSelectedFromViewController:(BOTableViewController *)viewController {
	NSIndexPath *indexPath = [viewController.tableView indexPathForCell:self];
	
	if (self.expansionHeight > 0) {
		viewController.expansionIndexPath = ![indexPath isEqual:viewController.expansionIndexPath] ? indexPath : nil;
		
		[viewController.tableView deselectRowAtIndexPath:indexPath animated:NO];
		[viewController.tableView beginUpdates];
		[viewController.tableView endUpdates];
		[viewController.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
	} else {
		if (self.accessoryType != UITableViewCellAccessoryDisclosureIndicator) {
			[viewController.tableView deselectRowAtIndexPath:indexPath animated:YES];
		}
	}
}

- (void)settingValueDidChange {}

@end
