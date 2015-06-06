//
//  BODisclosureTableViewCell.h
//  Bohr
//
//  Created by David Román Aguirre on 4/6/15.
//  Copyright (c) 2015 David Roman. All rights reserved.
//

#import "BOTableViewCell.h"

@interface BODisclosureTableViewCell : BOTableViewCell

+ (instancetype)cellWithTitle:(NSString *)title destinationViewController:(UIViewController *)destinationViewController;

@end
