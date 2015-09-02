//
//  BOTextTableViewCell.m
//  Bohr
//
//  Created by David Román Aguirre on 5/6/15.
//  Copyright (c) 2015 David Roman. All rights reserved.
//

#import "BOTextTableViewCell.h"

#import "BOTableViewCell+Subclass.h"
#import "BOTextTableViewCell+Subclass.h"

@implementation BOTextTableViewCell

- (void)setup {
	self.textField = [UITextField new];
	self.textField.delegate = self;
	self.textField.textAlignment = NSTextAlignmentRight;
	self.textField.returnKeyType = UIReturnKeyDone;
	self.textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	self.textField.frame = CGRectMake(0, 0, 130, self.textField.intrinsicContentSize.height);
	self.accessoryView = self.textField;
}

- (void)updateAppearance {
	self.textField.textColor = self.secondaryColor;
	self.textField.tintColor = self.secondaryColor;
	
	if (self.secondaryFont) {
		self.textField.font = self.secondaryFont;
		self.textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.textField.placeholder attributes:@{NSFontAttributeName : self.secondaryFont}];
	}
}

- (void)settingValueDidChange {
	self.textField.text = self.setting.value;
}

#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField endEditing:YES];
	
	return YES;
}

- (NSString *)textFieldTrimmedText {
	return [self.textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
	BOTextFieldInputError error = [self validateTextFieldInput:[self textFieldTrimmedText]];
	
	if (error != BOTextFieldInputNoError) {
		[self resetTextFieldAndInvokeInputError:error];
	} else {
		self.setting.value = [self settingValueForInput:textField.text];
	}
}

- (BOTextFieldInputError)validateTextFieldInput:(NSString *)input {
	return input.length < self.minimumTextLength ? BOTextFieldInputTooShortError : BOTextFieldInputNoError;
}

- (void)resetTextFieldAndInvokeInputError:(BOTextFieldInputError)error {
	[self settingValueDidChange];
	if (self.inputErrorBlock) self.inputErrorBlock(self, error);
}

- (id)settingValueForInput:(NSString *)input {
	return [self textFieldTrimmedText];
}

@end
