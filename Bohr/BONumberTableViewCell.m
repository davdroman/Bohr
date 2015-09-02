//
//  BONumberTableViewCell.m
//  Bohr
//
//  Created by David Román Aguirre on 01/09/15.
//
//

#import "BONumberTableViewCell.h"

#import "BOTableViewCell+Subclass.h"
#import "BOTextTableViewCell+Subclass.h"

@implementation NSNumber (String)

- (NSString *)stringWithDecimals:(NSInteger)decimals {
	NSNumberFormatter *formatter = [NSNumberFormatter new];
	formatter.locale = [NSLocale currentLocale];
	formatter.maximumFractionDigits = decimals;
	return [formatter stringFromNumber:self];
}

@end

@implementation NSString (Number)

- (BOOL)isNumeric {
	if (self.length > 0) {
		NSScanner *scanner = [NSScanner scannerWithString:self];
		scanner.locale = [NSLocale currentLocale];
		return [scanner scanDecimal:nil] && scanner.atEnd;
	}
	
	return YES;
}

- (NSNumber *)number {
	NSNumberFormatter *formatter = [NSNumberFormatter new];
	formatter.locale = [NSLocale currentLocale];
	return [formatter numberFromString:self];
}

@end

@implementation BONumberTableViewCell

- (void)setup {
	[super setup];
	
	self.textField.keyboardType = UIKeyboardTypeDecimalPad;
}

- (void)settingValueDidChange {
	self.textField.text = [self.setting.value stringWithDecimals:self.numberOfDecimals];
}

#pragma mark UITextFieldDelegate

- (BOTextFieldInputError)validateTextFieldInput:(NSString *)input {
	return ![input isNumeric] ? BOTextFieldInputNotNumericError : [super validateTextFieldInput:input];
}

- (id)settingValueForInput:(NSString *)input {
	return [input number];
}

@end
