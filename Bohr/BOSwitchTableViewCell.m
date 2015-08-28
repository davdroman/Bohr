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
	self.accessoryView = self.toggleSwitch;
}

- (void)updateAppearance {
	self.toggleSwitch.onTintColor = self.secondaryColor;
}

- (NSString *)footerTitle {
	return [self.setting.value boolValue] ? self.onFooterTitle : self.offFooterTitle;
}

- (void)toggleSwitchValueDidChange {
	self.setting.value = @(self.toggleSwitch.on);
}

- (void)settingValueDidChange {
	[self.toggleSwitch setOn:[self.setting.value boolValue] animated:[UIView areAnimationsEnabled]];
}

@end
