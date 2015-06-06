//
//  BOTextTableViewCell.h
//  Bohr
//
//  Created by David Román Aguirre on 5/6/15.
//  Copyright (c) 2015 David Roman. All rights reserved.
//

#import "BOTableViewCell.h"

typedef NS_ENUM(NSInteger, BOTextFieldInputError) {
	BOTextFieldInputEmptyError,
	BOTextFieldInputTooShortError
};

@class BOTextTableViewCell;
typedef void(^BOTextFieldInputErrorBlock)(BOTextTableViewCell *cell, BOTextFieldInputError error);

@interface BOTextTableViewCell : BOTableViewCell <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic) NSInteger minimumTextLength;
@property (nonatomic, copy) BOTextFieldInputErrorBlock textFieldInputFailedBlock;

+ (instancetype)cellWithTitle:(NSString *)title setting:(BOSetting *)setting placeholder:(NSString *)placeholder minimumTextLength:(NSInteger)minimumTextLength textFieldInputFailedBlock:(BOTextFieldInputErrorBlock)textFieldInputFailedBlock;

@end
