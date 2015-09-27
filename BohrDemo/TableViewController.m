//
//  TableViewController.m
//  BohrDemo
//
//  Created by David Román Aguirre on 31/5/15.
//

#import "TableViewController.h"
#import "OptionsTableViewController.h"

@implementation TableViewController

- (void)setup {
	
	self.title = @"Bohr";
	
	[self addSection:[BOTableViewSection sectionWithHeaderTitle:@"Section 1" handler:^(BOTableViewSection *section) {
		
		[section addCell:[BOSwitchTableViewCell cellWithTitle:@"Switch 1" key:@"bool_1" handler:nil]];
		
		[section addCell:[BOSwitchTableViewCell cellWithTitle:@"Switch 2" key:@"bool_2" handler:^(BOSwitchTableViewCell *cell) {
			cell.visibilityKey = @"bool_1";
			cell.visibilityBlock = ^BOOL(id settingValue) {
				return [settingValue boolValue];
			};
			cell.onFooterTitle = @"Switch setting 2 is on";
			cell.offFooterTitle = @"Switch setting 2 is off";
		}]];
	}]];
	
	__unsafe_unretained typeof(self) weakSelf = self;
	[self addSection:[BOTableViewSection sectionWithHeaderTitle:@"Section 2" handler:^(BOTableViewSection *section) {
		
		[section addCell:[BOTextTableViewCell cellWithTitle:@"Text" key:@"text" handler:^(BOTextTableViewCell *cell) {
			cell.textField.placeholder = @"Enter text";
			cell.inputErrorBlock = ^(BOTextTableViewCell *cell, BOTextFieldInputError error) {
				[weakSelf showInputErrorAlert:error];
			};
		}]];
		 
		[section addCell:[BONumberTableViewCell cellWithTitle:@"Number" key:@"number" handler:^(BONumberTableViewCell *cell) {
			cell.textField.placeholder = @"Enter number";
			cell.numberOfDecimals = 3;
			cell.inputErrorBlock = ^(BOTextTableViewCell *cell, BOTextFieldInputError error) {
				[weakSelf showInputErrorAlert:error];
			};
		}]];
		
		[section addCell:[BODateTableViewCell cellWithTitle:@"Date" key:@"date" handler:nil]];
		
		[section addCell:[BOTimeTableViewCell cellWithTitle:@"Time" key:@"time" handler:^(BOTimeTableViewCell *cell) {
			cell.datePicker.minuteInterval = 5;
		}]];
		
		[section addCell:[BOChoiceTableViewCell cellWithTitle:@"Choice" key:@"choice_1" handler:^(BOChoiceTableViewCell *cell) {
			cell.options = @[@"Option 1", @"Option 2", @"Option 3"];
			cell.footerTitles = @[@"Option 1", @"Option 2", @"Option 3"];
		}]];
		
		[section addCell:[BOChoiceTableViewCell cellWithTitle:@"Choice disclosure" key:@"choice_2" handler:^(BOChoiceTableViewCell *cell) {
			cell.options = @[@"Option 1", @"Option 2", @"Option 3", @"Option 4"];
			cell.destinationViewController = [OptionsTableViewController new];
		}]];
	}]];
	
	[self addSection:[BOTableViewSection sectionWithHeaderTitle:@"Section 3" handler:^(BOTableViewSection *section) {
		
		[section addCell:[BOButtonTableViewCell cellWithTitle:@"Button" key:nil handler:^(BOButtonTableViewCell *cell) {
			cell.actionBlock = ^{
				[weakSelf showTappedButtonAlert];
			};
		}]];
		
		section.footerTitle = @"Static footer title";
	}]];
}

- (void)presentAlertControllerWithTitle:(NSString *)title message:(NSString *)message {
	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
	[alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
		[alertController dismissViewControllerAnimated:YES completion:nil];
	}]];
	
	[self presentViewController:alertController animated:YES completion:nil];
}

- (void)showInputErrorAlert:(BOTextFieldInputError)error {
	NSString *message;
	
	switch (error) {
		case BOTextFieldInputTooShortError:
			message = @"The text is too short";
			break;
			
		case BOTextFieldInputNotNumericError:
			message = @"Please input a valid number";
			break;
		
		default:
			break;
	}
	
	if (message) {
		[self presentAlertControllerWithTitle:@"Error" message:message];
	}
}

- (void)showTappedButtonAlert {
	[self presentAlertControllerWithTitle:@"Button tapped!" message:nil];
}

@end
