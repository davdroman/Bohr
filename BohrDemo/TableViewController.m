//
//  TableViewController.m
//  BohrDemo
//
//  Created by David Román Aguirre on 31/5/15.
//

#import "TableViewController.h"

@implementation TableViewController

- (void)setup {
	self.textCell.textField.placeholder = @"Placeholder";
	self.textCell.inputErrorBlock = [self textFieldInputErrorBlock];
	self.choiceCell.options = @[@"Option 1", @"Option 2", @"Option 3"];
	self.choiceDisclosureCell.options = @[@"Option 1", @"Option 2", @"Option 3", @"Option 4"];
	[self.buttonCell setTarget:self action:@selector(showButtonAlert)];
	self.buttonCell.defaultFooterTitle = @"Static footer set programatically";
}

- (void)presentAlertControllerWithTitle:(NSString *)title message:(NSString *)message {
	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
	[alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
		[alertController dismissViewControllerAnimated:YES completion:nil];
	}]];
	[self presentViewController:alertController animated:YES completion:nil];
}

- (BOTextFieldInputErrorBlock)textFieldInputErrorBlock {
	__unsafe_unretained typeof(self) weakSelf = self;
	
	return ^(BOTextTableViewCell *cell, BOTextFieldInputError error) {
		[weakSelf presentAlertControllerWithTitle:@"Error" message:@"The text is too short"];
	};
}

- (void)showButtonAlert {
	[self presentAlertControllerWithTitle:@"Button tapped!" message:nil];
}

@end
