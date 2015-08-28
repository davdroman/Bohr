//
//  BOButtonTableViewCell.m
//  Bohr
//
//  Created by David Román Aguirre on 4/6/15.
//  Copyright (c) 2015 David Roman. All rights reserved.
//

#import "BOButtonTableViewCell.h"

#import "BOTableViewCell+Subclass.h"

@implementation BOButtonTableViewCell

- (void)setup {
	self.selectionStyle = UITableViewCellSelectionStyleDefault;
	self.textLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)wasSelectedFromViewController:(BOTableViewController *)viewController {
	if (self.actionBlock) self.actionBlock();
}

@end
