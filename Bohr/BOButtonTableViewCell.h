//
//  BOButtonTableViewCell.h
//  Bohr
//
//  Created by David Román Aguirre on 4/6/15.
//  Copyright (c) 2015 David Roman. All rights reserved.
//

#import "BOTableViewCell.h"

@interface BOButtonTableViewCell : BOTableViewCell

@property (nonatomic) id target;
@property (nonatomic) SEL action;

- (void)setTarget:(id)target action:(SEL)action;

@end
