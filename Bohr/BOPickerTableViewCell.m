//
//  BOPickerTableViewCell.m
//  TeadsSDKShowcase
//
//  Created by Nikolaï Roycourt on 10/09/2015.
//  Copyright (c) 2015 Nikolaï Roycourt. All rights reserved.
//

#import "BOPickerTableViewCell.h"

#import "BOTableViewCell+Subclass.h"
#import "UILabel+DatePickerCustomization.h"

@interface BOPickerTableViewCell()

@property (nonatomic) UIPickerView *picker;

@end

@implementation BOPickerTableViewCell

- (void)setup {
    self.picker = [UIPickerView new];
    self.picker.backgroundColor = [UIColor clearColor];
    self.picker.dataSource = self;
    self.picker.delegate = self;
    
    self.expansionView = self.picker;
}

- (CGFloat)expansionHeight {
    return 130;
}

- (void)settingValueDidChange {
    self.detailTextLabel.text = self.options[[self.setting.value integerValue]];
    
    //We have only 1 component, so inComponent parameter is 0
    [self.picker selectRow:[self.setting.value integerValue] inComponent:0 animated:YES];
}

#pragma mark - pickerview datasource

// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.options.count;
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

#pragma mark - pickerview delegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    // Handle the selection
    self.setting.value = [NSNumber numberWithInteger:row];
}

// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.options[row];
}

@end
