//
//  BOSwitchTableViewCell.m
//  Bohr
//
//  Created by David Román Aguirre on 4/6/15.
//  Copyright (c) 2015 David Roman. All rights reserved.
//

#import "BOSwitchTableViewCell.h"

#import "BOTableViewCell+Subclass.h"

@implementation BOSwitchTableViewCell

- (void)setup {
	self.toggleSwitch = [UISwitch new];
	[self.toggleSwitch addTarget:self action:@selector(toggleSwitchValueDidChange) forControlEvents:UIControlEventValueChanged];
	[self.contentView addSubview:self.toggleSwitch];
	
	NSLayoutConstraint *centerYConstraint = [NSLayoutConstraint constraintWithItem:self.toggleSwitch attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.toggleSwitch.superview attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
	NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self.toggleSwitch attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.toggleSwitch.superview attribute:NSLayoutAttributeRightMargin multiplier:1 constant:0];
	
	self.toggleSwitch.translatesAutoresizingMaskIntoConstraints = NO;
	[self.toggleSwitch.superview addConstraints:@[centerYConstraint, rightConstraint]];
}

- (void)updateAppearance {
	self.toggleSwitch.onTintColor = self.secondaryColor;
}

- (NSString *)footerTitle {
	if (self.onFooterTitle || self.offFooterTitle) {
		return [self.setting.value boolValue] ? self.onFooterTitle : self.offFooterTitle;
	}
	
	return [super footerTitle];
}

- (void)toggleSwitchValueDidChange {
	self.setting.value = @(self.toggleSwitch.on);
}

- (void)settingValueDidChange {
	[self.toggleSwitch setOn:[self.setting.value boolValue] animated:[UIView areAnimationsEnabled]];
}

@end
