//
//  BOPickerTableViewCell.h
//  TeadsSDKShowcase
//
//  Created by Nikolaï Roycourt on 10/09/2015.
//  Copyright (c) 2015 Nikolaï Roycourt. All rights reserved.
//

#import "BOTableViewCell.h"

@interface BOPickerTableViewCell : BOTableViewCell <UIPickerViewDataSource, UIPickerViewDelegate>

/// An array defining all the options available for the cell.
@property (nonatomic) NSArray *options;

@end
