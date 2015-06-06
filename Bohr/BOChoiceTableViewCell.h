//
//  BOChoiceTableViewCell.h
//  Bohr
//
//  Created by David Román Aguirre on 4/6/15.
//  Copyright (c) 2015 David Roman. All rights reserved.
//

#import "BOTableViewCell.h"

@interface BOChoiceTableViewCell : BOTableViewCell

+ (instancetype)cellWithTitle:(NSString *)title setting:(BOSetting *)setting options:(NSArray *)options;

@end
