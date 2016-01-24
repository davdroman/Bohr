//
//  BOChoiceTableViewCell.h
//  Bohr
//
//  Created by David Román Aguirre on 4/6/15.
//  Copyright (c) 2015 David Roman. All rights reserved.
//

#import "BOTableViewCell.h"

@interface BOChoiceTableViewCell : BOTableViewCell

/// An array defining all the options available for the cell.
@property (nonatomic) NSArray<NSString *> *options;

/// An optionnal array containing integer values of the options
/// Size of array must be the same as size of options array
@property (nonatomic) NSArray<NSNumber *> *optionValues;

/// An array defining all the footer titles for each option assigned to the cell.
@property (nonatomic) NSArray *footerTitles;

@end
