//
//  BOSwitchTableViewCell.h
//  Bohr
//
//  Created by David Román Aguirre on 4/6/15.
//  Copyright (c) 2015 David Roman. All rights reserved.
//

#import "BOTableViewCell.h"

@interface BOSwitchTableViewCell : BOTableViewCell

@property (nonatomic, strong) UISwitch *toggleSwitch;

@property (nonatomic, strong) IBInspectable NSString *onFooterTitle;
@property (nonatomic, strong) IBInspectable NSString *offFooterTitle;

@end
