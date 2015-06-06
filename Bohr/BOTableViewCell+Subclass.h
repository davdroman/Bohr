//
//  BOTableViewCell+Subclass.h
//  Bohr
//
//  Created by David Román Aguirre on 31/5/15.
//  Copyright (c) 2015 David Roman. All rights reserved.
//

#import "BOTableViewCell.h"

#import "BOTableViewController.h"

@interface BOTableViewCell ()

@property (nonatomic) CGFloat expansionHeight;

- (void)setup;
- (void)updateAppearance;
- (void)wasSelectedFromViewController:(BOTableViewController *)viewController;
- (void)settingValueDidChange;

@end
