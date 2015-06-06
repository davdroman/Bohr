//
//  BODisclosureTableViewCell.m
//  Bohr
//
//  Created by David Román Aguirre on 4/6/15.
//  Copyright (c) 2015 David Roman. All rights reserved.
//

#import "BODisclosureTableViewCell.h"

#import "BOTableViewCell+Subclass.h"

@interface BODisclosureTableViewCell ()

@property (nonatomic, strong) UIViewController *destinationViewController;

@end

@implementation BODisclosureTableViewCell

+ (instancetype)cellWithTitle:(NSString *)title destinationViewController:(UIViewController *)destinationViewController {
	BODisclosureTableViewCell *cell = [super cellWithTitle:title setting:nil];
	cell.destinationViewController = destinationViewController;
	return cell;
}

- (void)setup {
	self.selectionStyle = UITableViewCellSelectionStyleDefault;
	self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

- (void)wasSelectedFromViewController:(BOTableViewController *)viewController {
	[super wasSelectedFromViewController:viewController];
	[viewController.navigationController pushViewController:self.destinationViewController animated:YES];
}

@end
