//
//  BOSwitchTableViewCell.h
//  Bohr
//
//  Created by David Román Aguirre on 4/6/15.
//  Copyright (c) 2015 David Roman. All rights reserved.
//

#import "BOTableViewCell.h"

@interface BOSwitchTableViewCell : BOTableViewCell

/// The switch on the cell.
@property (nonatomic, strong) UISwitch *toggleSwitch;

/// The footer title when the toggle switch is on.
@property (nonatomic, strong) IBInspectable NSString *onFooterTitle;

/// The footer title when the toggle switch is off.
@property (nonatomic, strong) IBInspectable NSString *offFooterTitle;

@end
