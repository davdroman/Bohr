//
//  BOTimeTableViewCell.m
//  Bohr
//
//  Created by David Román Aguirre on 4/6/15.
//  Copyright (c) 2015 David Roman. All rights reserved.
//

#import "BOTimeTableViewCell.h"

#import "BOTableViewCell+Subclass.h"

@interface BOTimeTableViewCell ()

@property (nonatomic, strong) UIPickerView *timePickerView;

@end

@implementation BOTimeTableViewCell

- (void)setup {
	self.timePickerView = [UIPickerView new];
	self.timePickerView.backgroundColor = [UIColor clearColor];
	self.timePickerView.dataSource = self;
	self.timePickerView.delegate = self;
	[self.contentView addSubview:self.timePickerView];
	
	NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self.timePickerView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.timePickerView.superview attribute:NSLayoutAttributeTopMargin multiplier:1 constant:0];
	NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self.timePickerView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.timePickerView.superview attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
	NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self.timePickerView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.timePickerView.superview attribute:NSLayoutAttributeRight multiplier:1 constant:0];
	NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.timePickerView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:216];
	
	self.timePickerView.translatesAutoresizingMaskIntoConstraints = NO;
	[self.timePickerView.superview addConstraints:@[topConstraint, leftConstraint, rightConstraint, heightConstraint]];
}

- (void)updateAppearance {
	[self.timePickerView reloadAllComponents];
}

- (CGFloat)expansionHeight {
	return self.timePickerView.frame.size.height;
}

#pragma mark UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	switch (component) {
		case 0:
			return 24;
		case 1:
			return 60/self.minuteInterval;
	}
	
	return 0;
}

#pragma mark UIPickerViewDelegate

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
	return 65;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
	NSString *title;
	
	switch (component) {
		case 0:
			title = [NSString stringWithFormat:@"%@%li", row < 10 ? @"0" : @"", (long)row];
			break;
			
		case 1:
			title = [NSString stringWithFormat:@"%@%li", row*self.minuteInterval < 10 ? @"0" : @"", (long)(row*self.minuteInterval)];
			break;
	}
	
	UILabel *label = (UILabel *)view;
	
	if (!label) {
		label = [UILabel new];
		label.textAlignment = NSTextAlignmentCenter;
		
		if (self.mainColor) {
			label.textColor = self.mainColor;
		}
		
		UIFont *font = self.secondaryFont ? self.secondaryFont : [UIFont systemFontOfSize:[UIFont systemFontSize]];
		
		CGSize size = [title sizeWithAttributes:@{NSFontAttributeName: font}];
		
		// For current font point size, calculate points per pixel
		CGFloat pointsPerPixel = font.pointSize/size.height;
		
		// Scale up point size for the height of the label
		CGFloat desiredPointSize = 28*pointsPerPixel;
		
		label.font = [font fontWithSize:desiredPointSize];
	}
	
	label.text = title;
	
	return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	self.setting.value = @([self timeIntervalForTimePickerView]);
}

- (NSInteger)timeIntervalForTimePickerView {
	return 60*[self hoursForTimePickerView]+[self minutesForTimePickerView];
}

- (NSInteger)hoursForTimePickerView {
	return [self.timePickerView selectedRowInComponent:0];
}

- (NSInteger)minutesForTimePickerView {
	return [self.timePickerView selectedRowInComponent:1]*self.minuteInterval;
}

- (void)settingValueDidChange {
	self.detailTextLabel.text = [self timeStringForSettingValue];
	
	[self.timePickerView selectRow:[self hoursForSettingValue] inComponent:0 animated:YES];
	[self.timePickerView selectRow:[self minutesForSettingValue]/self.minuteInterval inComponent:1 animated:YES];
}

- (NSString *)timeStringForSettingValue {
	NSInteger hours = [self hoursForSettingValue];
	NSInteger minutes = [self minutesForSettingValue];
	
	NSString *hoursString = [[NSString alloc] initWithFormat:@"%@%li", hours < 10 ? @"0" : @"", (long)hours];
	NSString *minutesString = [[NSString alloc] initWithFormat:@"%@%li", minutes < 10 ? @"0" : @"", (long)minutes];
	
	NSString *timeString = [[NSString alloc] initWithFormat:@"%@:%@", hoursString, minutesString];
	
	return timeString;
}

- (NSInteger)hoursForSettingValue {
	return floorf([self.setting.value integerValue]/60);
}

- (NSInteger)minutesForSettingValue {
	return (NSInteger)[self.setting.value integerValue] % 60;
}

@end
