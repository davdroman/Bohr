//
//  BOTimeTableViewCell.m
//  Bohr
//
//  Created by David Román Aguirre on 4/6/15.
//  Copyright (c) 2015 David Roman. All rights reserved.
//

#import "BOTimeTableViewCell.h"

#import "BOTableViewCell+Subclass.h"

@implementation BOTimeTableViewCell

- (void)setup {
	[super setup];
	
	self.dateFormat = [NSDateFormatter dateFormatFromTemplate:@"hh:mm" options:kNilOptions locale:[NSLocale currentLocale]];
	self.datePicker.datePickerMode = UIDatePickerModeTime;
}

@end
