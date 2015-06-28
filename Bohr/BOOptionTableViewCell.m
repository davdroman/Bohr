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

- (void)setup {
	self.selectionStyle = UITableViewCellSelectionStyleDefault;
}

- (void)wasSelectedFromViewController:(BOTableViewController *)viewController {
	NSInteger optionIndex = [viewController.tableView indexPathForCell:self].row;
	self.setting.value = @(optionIndex);
}

- (void)settingValueDidChange {
	NSInteger optionIndex = [self.setting.value integerValue];
	
    if (optionIndex == self.indexPath.row) {
        self.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        self.accessoryType = UITableViewCellAccessoryNone;
    }
}

@end
