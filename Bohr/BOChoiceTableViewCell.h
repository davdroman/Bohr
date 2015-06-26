//
//  BOChoiceTableViewCell.h
//  Bohr
//
//  Created by David Román Aguirre on 4/6/15.
//  Copyright (c) 2015 David Roman. All rights reserved.
//

#import "BOTableViewCell.h"

@interface BOChoiceTableViewCell : BOTableViewCell

@property (nonatomic, strong) NSArray *options;

@property (nonatomic, strong) IBInspectable NSArray *footerTitles;

@end
