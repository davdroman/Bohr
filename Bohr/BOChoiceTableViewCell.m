//
//  BOChoiceTableViewCell.m
//  Bohr
//
//  Created by David Román Aguirre on 4/6/15.
//  Copyright (c) 2015 David Roman. All rights reserved.
//

#import "BOChoiceTableViewCell.h"

#import "BOTableViewCell+Subclass.h"

@interface BOChoiceTableViewCell ()

@property (nonatomic, strong) NSArray *options;

@end

@implementation BOChoiceTableViewCell

+ (instancetype)cellWithTitle:(NSString *)title setting:(BOSetting *)setting options:(NSArray *)options {
	BOChoiceTableViewCell *cell = [super cellWithTitle:title setting:setting];
	cell.options = options;
	return cell;
}

- (void)setup {
	self.selectionStyle = UITableViewCellSelectionStyleDefault;
}

- (void)wasSelectedFromViewController:(BOTableViewController *)viewController {
	[super wasSelectedFromViewController:viewController];
	
	NSInteger currentOption = [self.setting.value integerValue];
	
	if (currentOption < self.options.count-1) {
		self.setting.value = @(currentOption+1);
	} else {
		self.setting.value = @0;
	}
}

- (void)settingValueDidChange {
	self.detailTextLabel.text = self.options[[self.setting.value integerValue]];
}

@end
