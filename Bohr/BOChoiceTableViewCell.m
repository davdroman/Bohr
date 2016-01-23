//
//  BOChoiceTableViewCell.m
//  Bohr
//
//  Created by David Román Aguirre on 4/6/15.
//  Copyright (c) 2015 David Roman. All rights reserved.
//

#import "BOChoiceTableViewCell.h"

#import "BOTableViewCell+Subclass.h"

@implementation BOChoiceTableViewCell

- (void)setup {
	self.selectionStyle = UITableViewCellSelectionStyleDefault;
}

- (NSString *)footerTitle {
	NSInteger currentOption = [self indexFromCurrentValue:[self.setting.value integerValue]];
	
	if (currentOption < self.footerTitles.count) {
		return self.footerTitles[currentOption];
	}
	
	return nil;
}

- (void)wasSelectedFromViewController:(BOTableViewController *)viewController {
	if (self.accessoryType != UITableViewCellAccessoryDisclosureIndicator) {
		NSInteger currentOption = [self indexFromCurrentValue:[self.setting.value integerValue]];
		
		if (currentOption < self.options.count-1) {
            self.setting.value = @([self valueForIndex:currentOption+1]);
		} else {
			self.setting.value = @0;
		}
	}
}

- (void)settingValueDidChange {
    self.detailTextLabel.text = self.options[[self indexFromCurrentValue:[self.setting.value integerValue]]];
}

- (NSInteger)valueForIndex:(NSInteger)index {
    if (self.optionValues) {
        return [self.optionValues[index] integerValue];
    } else {
        return index;
    }
}

- (NSInteger)indexFromCurrentValue:(NSInteger)value {
    NSInteger index = value;
    if (self.optionValues) {
        index = [self.optionValues indexOfObject:@(value)];
    }
    
    return index;
}

@end
