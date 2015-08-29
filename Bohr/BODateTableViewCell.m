//
//  BODateTableViewCell.m
//  Bohr
//
//  Created by David Román Aguirre on 28/08/15.
//
//

#import "BODateTableViewCell.h"

#import "BOTableViewCell+Subclass.h"
#import "UILabel+DatePickerCustomization.h"

@interface BODateTableViewCell ()

@property (nonatomic) NSDateFormatter *dateFormatter;

@end

@implementation BODateTableViewCell

- (void)setup {
	self.datePicker = [UIDatePicker new];
	self.datePicker.backgroundColor = [UIColor clearColor];
	self.datePicker.datePickerMode = UIDatePickerModeDate;
	[self.datePicker addTarget:self action:@selector(datePickerValueDidChange) forControlEvents:UIControlEventValueChanged];
	self.expansionView = self.datePicker;
	
	self.dateFormatter = [NSDateFormatter new];
	self.dateFormatter.dateFormat = [self defaultDateFormat];
}

- (CGFloat)expansionHeight {
	return 216;
}

- (void)setDateFormat:(NSString *)dateFormat {
	dateFormat = self.dateFormat.length == 0 ? [self defaultDateFormat] : dateFormat;
	self.dateFormatter.dateFormat = dateFormat;
}

- (NSString *)dateFormat {
	return self.dateFormatter.dateFormat;
}

- (NSString *)defaultDateFormat {
	return [NSDateFormatter dateFormatFromTemplate:@"dd/MM/YYYY" options:kNilOptions locale:[NSLocale currentLocale]];
}

- (void)settingValueDidChange {
	self.detailTextLabel.text = [self.dateFormatter stringFromDate:self.setting.value];
	self.datePicker.date = self.setting.value;
}

- (void)datePickerValueDidChange {
	self.setting.value = self.datePicker.date;
}

@end
