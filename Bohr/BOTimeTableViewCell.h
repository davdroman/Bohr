//
//  BOTimeTableViewCell.h
//  Bohr
//
//  Created by David Román Aguirre on 4/6/15.
//  Copyright (c) 2015 David Roman. All rights reserved.
//

#import "BOTableViewCell.h"

@interface BOTimeTableViewCell : BOTableViewCell <UIPickerViewDataSource, UIPickerViewDelegate>

/// The minute interval showed on the time picker view.
@property (nonatomic) IBInspectable NSInteger minuteInterval;

@end
