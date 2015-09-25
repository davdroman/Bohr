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

/// An optional destination view controller to push when the cell is pressed.
@property (nonatomic) UIViewController *destinationViewController;

/// An optional key in order to determine whether the cell should be visible or not depending on its value.
@property (nonatomic) NSString *visibilityKey;

/// A block determining whether the cell should be visible or not.
@property (nonatomic, copy) BOOL (^visibilityBlock)(id settingValue);

/** Initializes a new BOTableViewCell object.
 *
 *	@param title The cell title.
 *	@param key The NSUserDefaults key associated with the cell.
 *	@param handler A block passed in order to set up anything in the cell.
 **/
+ (instancetype)cellWithTitle:(NSString *)title key:(NSString *)key handler:(void (^)(id cell))handler;

@end
