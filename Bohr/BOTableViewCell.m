//
//  BOTableViewCell.m
//  Bohr
//
//  Created by David Román Aguirre on 31/5/15.
//  Copyright (c) 2015 David Roman. All rights reserved.
//

#import "BOTableViewCell+Subclass.h"

#import "BOSetting+Private.h"
#import "BOTableViewController+Private.h"

@implementation BOTableViewCell

- (void)awakeFromNib {
	self.clipsToBounds = YES;
	self.selectionStyle = UITableViewCellSelectionStyleNone;
	self.detailTextLabel.text = nil;
	if (self.key) self.setting = [BOSetting settingWithKey:self.key];
	[self setup];
}

- (void)layoutSubviews {
	[super layoutSubviews];
	
	if (self.expansionHeight > 0 || self.contentView.subviews.count > 1) {
		CGFloat yOffset = (self.layoutMargins.top-self.frame.size.height)/2;
		
		self.textLabel.frame = CGRectMake(self.textLabel.frame.origin.x, self.textLabel.frame.origin.y+yOffset, self.textLabel.intrinsicContentSize.width, self.textLabel.frame.size.height);
		self.detailTextLabel.center = CGPointMake(self.detailTextLabel.center.x, self.detailTextLabel.center.y+yOffset);
	}
}

#pragma mark Customization

- (void)setMainColor:(UIColor *)mainColor {
	_mainColor = mainColor;
	self.textLabel.textColor = mainColor;
}

- (void)setMainFont:(UIFont *)mainFont {
	_mainFont = mainFont;
	self.textLabel.font = mainFont;
}

- (void)setSecondaryColor:(UIColor *)secondaryColor {
	_secondaryColor = secondaryColor;
	self.textLabel.highlightedTextColor = [UIColor whiteColor];
	self.detailTextLabel.textColor = secondaryColor;
	self.detailTextLabel.highlightedTextColor = [UIColor whiteColor];
	self.tintColor = secondaryColor;
}

- (void)setSecondaryFont:(UIFont *)secondaryFont {
	_secondaryFont = secondaryFont;
	self.detailTextLabel.font = secondaryFont;
}

- (void)setSelectedColor:(UIColor *)selectedColor {
	_selectedColor = selectedColor;
	self.selectedBackgroundView = [UIView new];
	self.selectedBackgroundView.backgroundColor = selectedColor;
}

#pragma mark Subclassing

- (void)setup {}
- (void)setupConstraints {}
- (void)updateAppearance {}
- (CGFloat)expansionHeight {return 0;}
- (NSString *)footerTitle {return self.defaultFooterTitle;}
- (void)wasSelectedFromViewController:(BOTableViewController *)viewController {}
- (void)settingValueDidChange {}

@end
