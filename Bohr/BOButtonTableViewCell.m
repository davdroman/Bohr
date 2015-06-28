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

#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

- (void)wasSelectedFromViewController:(BOTableViewController *)viewController {
	if ([self.target respondsToSelector:self.action]) {
		[self.target performSelector:self.action];
	}
}

- (void)setTarget:(id)target action:(SEL)action {
	self.target = target;
	self.action = action;
}

@end
