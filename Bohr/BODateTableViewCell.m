//
//  BODateTableViewCell.m
//  Bohr
//
//  Created by Amit Prabhu on 07/07/15.
//
//

#import "BODateTableViewCell.h"

#import "BOTableViewCell+Subclass.h"

@interface BODateTableViewCell ()

@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@end

@implementation BODateTableViewCell

- (void)setup {
    
    // Setup DatePicker
    self.datePicker = [UIDatePicker new];
    self.datePicker.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.datePicker];
    [self.datePicker setDatePickerMode:UIDatePickerModeDate];
    [self.datePicker addTarget:self action:@selector(onDatePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self.datePicker attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.datePicker.superview attribute:NSLayoutAttributeTopMargin multiplier:1 constant:0];
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self.datePicker attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.datePicker.superview attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self.datePicker attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.datePicker.superview attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.datePicker attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:216];
    
    self.datePicker.translatesAutoresizingMaskIntoConstraints = NO;
    [self.datePicker.superview addConstraints:@[topConstraint, leftConstraint, rightConstraint, heightConstraint]];
    
    // Date formatter settings
    self.dateFormatter = [NSDateFormatter new];
    self.dateFormatter.timeZone = [NSTimeZone systemTimeZone];
    [self.dateFormatter setDateFormat:@"dd MMM yyyy"];
    
}


- (CGFloat)expansionHeight {
    return self.datePicker.frame.size.height;
}

- (void)settingValueDidChange {
    self.detailTextLabel.text = [self.dateFormatter stringFromDate:self.datePicker.date];
}

-(void)onDatePickerValueChanged:(UIDatePicker *)datePicker
{
    self.detailTextLabel.text = [self.dateFormatter stringFromDate:datePicker.date];
}

@end

