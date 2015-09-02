//
//  BOTextTableViewCell.h
//  Bohr
//
//  Created by David Román Aguirre on 5/6/15.
//  Copyright (c) 2015 David Roman. All rights reserved.
//

#import "BOTableViewCell.h"

/// Defines an error ocurred after trying to input some new value to the cell text field.
typedef NS_ENUM(NSInteger, BOTextFieldInputError) {
	BOTextFieldInputNoError,
	BOTextFieldInputTooShortError,
	BOTextFieldInputNotNumericError,
};

@interface BOTextTableViewCell : BOTableViewCell <UITextFieldDelegate>

/**
 * Block type defining an input error that has ocurred in the cell text field.
 *
 * @param cell the cell affected by the input error.
 * @param error the received input error.
 */
typedef void(^BOTextFieldInputErrorBlock)(BOTextTableViewCell *cell, BOTextFieldInputError error);

/// The text field on the cell.
@property (nonatomic) UITextField *textField;

/// The minimum amount of non-blank characters necessary for the text field.
@property (nonatomic) NSInteger minimumTextLength;

/// A block defining an input error that has ocurred in the cell text field.
@property (nonatomic, copy) BOTextFieldInputErrorBlock inputErrorBlock;

@end
