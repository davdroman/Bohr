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
	self.dateFormatter.dateFormat = [self dateFormat];
}

- (CGFloat)expansionHeight {
	return 216;
}

- (void)setDateFormat:(NSString *)dateFormat {
	if (dateFormat.length > 0) {
		self.dateFormatter.dateFormat = dateFormat;
	}
}

- (NSString *)dateFormat {
	if (self.dateFormatter.dateFormat.length == 0) {
		return [NSDateFormatter dateFormatFromTemplate:@"dd/MM/YYYY" options:kNilOptions locale:[NSLocale currentLocale]];
	}
	
	return self.dateFormatter.dateFormat;
}

- (void)settingValueDidChange {
	self.detailTextLabel.text = [self.dateFormatter stringFromDate:self.setting.value];
	self.datePicker.date = self.setting.value;
}

- (void)datePickerValueDidChange {
	self.setting.value = self.datePicker.date;
}

@end
