//
//  BOTableViewCell+Subclass.h
//  Bohr
//
//  Created by David Román Aguirre on 31/5/15.
//  Copyright (c) 2015 David Roman. All rights reserved.
//

#import "BOTableViewCell.h"

#import "BOTableViewController.h"
#import "BOSetting.h"

@interface BOTableViewCell ()

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) BOSetting *setting;

- (void)setup;
- (void)updateAppearance;
- (CGFloat)expansionHeight;
- (NSString *)footerTitle;
- (void)wasSelectedFromViewController:(BOTableViewController *)viewController;
- (void)settingValueDidChange;

@end
