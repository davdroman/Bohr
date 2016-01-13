//
//  BOOptionTableViewCell.m
//  Bohr
//
//  Created by David Román Aguirre on 21/6/15.
//  Copyright (c) 2015 David Roman. All rights reserved.
//

#import "BOOptionTableViewCell.h"

#import "BOTableViewCell+Subclass.h"

@implementation BOOptionTableViewCell

@synthesize value = _value;

- (void)setup {
    self.value = NSIntegerMin;
	self.selectionStyle = UITableViewCellSelectionStyleDefault;
}

- (void)setValue:(NSInteger)value {
    _value = value;
}

- (NSInteger)value {
    return _value != NSIntegerMin ? _value : self.indexPath.row;
}

- (void)wasSelectedFromViewController:(BOTableViewController *)viewController {
    self.setting.value = @(self.value);
}

- (void)settingValueDidChange {
    BOOL isSelected = [self.setting.value integerValue] == self.value;
	self.accessoryType = isSelected ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
}

@end
