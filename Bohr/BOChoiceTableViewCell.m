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
	NSInteger currentOption = [self.setting.value integerValue];
	
	if (currentOption < self.footerTitles.count) {
		return self.footerTitles[currentOption];
	}
	
	return nil;
}

- (void)wasSelectedFromViewController:(BOTableViewController *)viewController {
	if (self.accessoryType != UITableViewCellAccessoryDisclosureIndicator) {
		NSInteger currentOption = [self.setting.value integerValue];
		
		if (currentOption < self.options.count-1) {
			self.setting.value = @(currentOption+1);
		} else {
			self.setting.value = @0;
		}
	}
}

- (void)settingValueDidChange {
	self.detailTextLabel.text = self.options[[self.setting.value integerValue]];
}

@end
