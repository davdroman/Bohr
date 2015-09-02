//
//  BOTextTableViewCell+Subclass.h
//  Bohr
//
//  Created by David Román Aguirre on 02/09/15.
//
//

#import <Bohr/Bohr.h>

@interface BOTextTableViewCell (Subclass)

/**
 *	Validation method implemented by a BOTextTableViewCell class in order to check for possible errors in its input.
 *	@param filteredInput The input string with whitespace and new line characters trimmed.
 *	@return Some BOTextFieldInputError, or BOTextFieldInputNoError if there's no error with input.
 */
- (BOTextFieldInputError)validateTextFieldInput:(NSString *)input;

/**
 *	Conversion method implemented by a BOTextTableViewCell class in order to make any necessary transformations to the input before assigning it as a setting value.
 *	@param input The input string.
 *	@return Some object resulting from the transformation of the input.
 */
- (id)settingValueForInput:(NSString *)input;

@end
