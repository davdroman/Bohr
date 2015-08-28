//
//  BOTableViewCell.h
//  Bohr
//
//  Created by David Román Aguirre on 31/5/15.
//  Copyright (c) 2015 David Roman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MZAppearance.h"

@interface BOTableViewCell : UITableViewCell

/// The NSUserDefaults key associated with the cell.
@property (nonatomic) NSString *key;

/// The main text color for the cell.
@property (nonatomic) UIColor *mainColor UI_APPEARANCE_SELECTOR;

/// The main text font for the cell.
@property (nonatomic) UIFont *mainFont UI_APPEARANCE_SELECTOR;

/// The secondary or detail text color for the cell.
@property (nonatomic) UIColor *secondaryColor UI_APPEARANCE_SELECTOR;

/// The secondary or detail text font for the cell.
@property (nonatomic) UIFont *secondaryFont UI_APPEARANCE_SELECTOR;

/// The color for the selected state of the cell.
@property (nonatomic) UIColor *selectedColor UI_APPEARANCE_SELECTOR;

/// The default footer title for the cell.
@property (nonatomic) NSString *footerTitle;

+ (instancetype)cellWithTitle:(NSString *)title key:(NSString *)key handler:(void (^)(id cell))handler;

@end
