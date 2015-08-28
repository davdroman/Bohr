//
//  BODateTableViewCell.h
//  Bohr
//
//  Created by David Román Aguirre on 28/08/15.
//
//

#import "BOTableViewCell.h"

@interface BODateTableViewCell : BOTableViewCell

@property (nonatomic, assign) NSString *dateFormat;
@property (nonatomic) UIDatePicker *datePicker;

@end
