//
//  BOButtonTableViewCell.m
//  Bohr
//
//  Created by David Román Aguirre on 4/6/15.
//  Copyright (c) 2015 David Roman. All rights reserved.
//

#import "BOButtonTableViewCell.h"

#import "BOTableViewCell+Subclass.h"

@interface BOButtonTableViewCell ()

@property (nonatomic, copy) void(^didTriggerBlock)(void);

@end

@implementation BOButtonTableViewCell

+ (instancetype)cellWithTitle:(NSString *)title didTriggerBlock:(void (^)(void))didTriggerBlock {
	BOButtonTableViewCell *cell = [super cellWithTitle:title setting:nil];
	cell.didTriggerBlock = didTriggerBlock;
	return cell;
}

- (void)setup {
	self.selectionStyle = UITableViewCellSelectionStyleDefault;
	self.textLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)wasSelectedFromViewController:(BOTableViewController *)viewController {
	[super wasSelectedFromViewController:viewController];
	if (self.didTriggerBlock) self.didTriggerBlock();
}

@end
