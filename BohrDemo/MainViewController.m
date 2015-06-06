//
//  MainViewController.m
//  BohrDemo
//
//  Created by David Román Aguirre on 31/5/15.
//

#import "MainViewController.h"

#import "DetailViewController.h"

@interface MainViewController ()

@property (nonatomic, strong) DetailViewController *detailViewController;

@end

@implementation MainViewController

- (void)setup {
	
	self.title = @"Bohr";
	self.tableView.backgroundColor = [UIColor colorWithWhite:0.96 alpha:1];
	self.detailViewController = [[DetailViewController alloc] initWithStyle:UITableViewStyleGrouped];
	
	BOTableViewSection *section1 = [BOTableViewSection sectionWithTitle:@"Section 1"];
	[section1 addCells:@[
						 [BOSwitchTableViewCell cellWithTitle:@"Switch setting 1" setting:[BOSetting settingWithDefaultValue:@YES forKey:@"bool_1"]],
						 [BOSwitchTableViewCell cellWithTitle:@"Switch setting 2" setting:[BOSetting settingWithDefaultValue:@NO forKey:@"bool_2"]],
						 ]];
	
	BOTableViewSection *section2 = [BOTableViewSection sectionWithTitle:@"Section 2"];
	[section2 addCells:@[
						 [BOTextTableViewCell cellWithTitle:@"Text setting" setting:[BOSetting settingWithDefaultValue:@"" forKey:@"text"] placeholder:@"Placeholder" minimumTextLength:0 textFieldInputFailedBlock:[self textFieldInputFailedBlock]],
						 
						 [BOChoiceTableViewCell cellWithTitle:@"Choice setting" setting:[BOSetting settingWithDefaultValue:@1 forKey:@"option"] options:@[@"Option 1", @"Option 2", @"Option 3"]],
						 
						 [BOTimeTableViewCell cellWithTitle:@"Time setting" setting:[BOSetting settingWithDefaultValue:@300 forKey:@"time"] minuteInterval:5],
						 
						 [BODisclosureTableViewCell cellWithTitle:@"Disclosure cell" destinationViewController:self.detailViewController],
						 ]];
	
	BOTableViewSection *section3 = [BOTableViewSection sectionWithTitle:nil];
	section3.footerTitle = @"A footer title can be easily set too.";
	[section3 addCells:@[[BOButtonTableViewCell cellWithTitle:@"Button" didTriggerBlock:[self buttonDidTriggerBlock]]]];
	
	[self addSections:@[section1, section2, section3]];
	
}

- (void)presentAlertControllerWithTitle:(NSString *)title message:(NSString *)message {
	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
	[alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
		[alertController dismissViewControllerAnimated:YES completion:nil];
	}]];
	[self presentViewController:alertController animated:YES completion:nil];
}

- (BOTextFieldInputErrorBlock)textFieldInputFailedBlock {
	__unsafe_unretained typeof(self) weakSelf = self;
	
	return ^(BOTextTableViewCell *cell, BOTextFieldInputError error) {
		NSString *message = error == BOTextFieldInputEmptyError ? @"The text field can't be empty" : @"The text is too short";
		[weakSelf presentAlertControllerWithTitle:@"Error" message:message];
	};
}

- (void (^)(void))buttonDidTriggerBlock {
	__unsafe_unretained typeof(self) weakSelf = self;
	
	return ^{
		[weakSelf presentAlertControllerWithTitle:@"Button tapped!" message:nil];
	};
}

@end
