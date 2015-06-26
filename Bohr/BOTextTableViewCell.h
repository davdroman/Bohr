//
//  BOTextTableViewCell.h
//  Bohr
//
//  Created by David Román Aguirre on 5/6/15.
//  Copyright (c) 2015 David Roman. All rights reserved.
//

#import "BOTableViewCell.h"

typedef NS_ENUM(NSInteger, BOTextFieldInputError) {
	BOTextFieldInputTooShortError
};

@interface BOTextTableViewCell : BOTableViewCell <UITextFieldDelegate>

typedef void(^BOTextFieldInputErrorBlock)(BOTextTableViewCell *cell, BOTextFieldInputError error);

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic) IBInspectable NSInteger minimumTextLength;
@property (nonatomic, copy) BOTextFieldInputErrorBlock inputErrorBlock;

@end
