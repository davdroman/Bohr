//
//  BONumberTableViewCell.h
//  Bohr
//
//  Created by David Román Aguirre on 01/09/15.
//
//

#import "BOTextTableViewCell.h"

@interface BONumberTableViewCell : BOTextTableViewCell

/// The maximum number of decimals shown in the text field.
@property (nonatomic) NSInteger numberOfDecimals;

@end
