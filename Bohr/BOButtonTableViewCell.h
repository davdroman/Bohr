//
//  BOButtonTableViewCell.h
//  Bohr
//
//  Created by David Román Aguirre on 4/6/15.
//  Copyright (c) 2015 David Roman. All rights reserved.
//

#import "BOTableViewCell.h"

@interface BOButtonTableViewCell : BOTableViewCell

/// The target of the cell action.
@property (nonatomic) id target;

/// The action defined by the cell, triggered when it's tapped.
@property (nonatomic) SEL action;

/// Sets both the target and action for the cell to be performed.
- (void)setTarget:(id)target action:(SEL)action;

@end
