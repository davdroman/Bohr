//
//  BOTextTableViewCell.m
//  Bohr
//
//  Created by David Román Aguirre on 5/6/15.
//  Copyright (c) 2015 David Roman. All rights reserved.
//

#import "BOTextTableViewCell.h"

#import "BOTableViewCell+Subclass.h"

@implementation BOTextTableViewCell

+ (instancetype)cellWithTitle:(NSString *)title setting:(BOSetting *)setting placeholder:(NSString *)placeholder minimumTextLength:(NSInteger)minimumTextLength textFieldInputFailedBlock:(BOTextFieldInputErrorBlock)textFieldInputFailedBlock {
	BOTextTableViewCell *cell = [super cellWithTitle:title setting:setting];
	cell.textField.placeholder = placeholder;
	cell.minimumTextLength = minimumTextLength;
	cell.textFieldInputFailedBlock = textFieldInputFailedBlock;
	return cell;
}

- (void)setup {
	self.textField = [UITextField new];
	self.textField.delegate = self;
	self.textField.textAlignment = NSTextAlignmentRight;
	self.textField.returnKeyType = UIReturnKeyDone;
	[self.textField setContentVerticalAlignment:UIControlContentVerticalAlignmentFill];
	[self.contentView addSubview:self.textField];
	
	NSLayoutConstraint *centerYConstraint = [NSLayoutConstraint constraintWithItem:self.textField attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.textField.superview attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
	NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self.textField attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.textLabel attribute:NSLayoutAttributeRight multiplier:1 constant:15];
	NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self.textField attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.textField.superview attribute:NSLayoutAttributeRightMargin multiplier:1 constant:0];
	
	self.textField.translatesAutoresizingMaskIntoConstraints = NO;
	[self.textField.superview addConstraints:@[centerYConstraint, leftConstraint, rightConstraint]];
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
	if (self.minimumTextLength > 0 && [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""].length == 0) {
		if (self.textFieldInputFailedBlock) self.textFieldInputFailedBlock(self, BOTextFieldInputEmptyError);
	} else if (textField.text.length < self.minimumTextLength) {
		if (self.textFieldInputFailedBlock) self.textFieldInputFailedBlock(self, BOTextFieldInputTooShortError);
	} else {
		self.setting.value = textField.text;
		[textField endEditing:YES];
	}
	
	return YES;
}

@end
