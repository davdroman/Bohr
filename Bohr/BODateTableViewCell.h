//
//  BODateTableViewCell.h
//  Bohr
//
//  Created by David Román Aguirre on 28/08/15.
//
//

#import "BOTableViewCell.h"

@interface BODateTableViewCell : BOTableViewCell

/// The date format used for the displayed text on the right side of the cell.
@property (nonatomic, assign) NSString *dateFormat;

/// The date picker used by the cell to manipulate its setting value.
@property (nonatomic) UIDatePicker *datePicker;

@end
