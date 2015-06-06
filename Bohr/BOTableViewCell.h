//
//  BOTableViewCell.h
//  Bohr
//
//  Created by David Román Aguirre on 31/5/15.
//  Copyright (c) 2015 David Roman. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BOSetting.h"

@interface BOTableViewCell : UITableViewCell

@property (nonatomic, strong) BOSetting *setting;

@property (nonatomic, strong) UIColor *mainColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIFont *mainFont UI_APPEARANCE_SELECTOR;

@property (nonatomic, strong) UIColor *secondaryColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIFont *secondaryFont UI_APPEARANCE_SELECTOR;

@property (nonatomic, strong) UIColor *selectedColor UI_APPEARANCE_SELECTOR;

+ (instancetype)cellWithTitle:(NSString *)title setting:(BOSetting *)setting;

@end
