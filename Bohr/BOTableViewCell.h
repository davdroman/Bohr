//
//  BOTableViewCell.h
//  Bohr
//
//  Created by David Román Aguirre on 31/5/15.
//  Copyright (c) 2015 David Roman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BOTableViewCell : UITableViewCell

@property (nonatomic, strong) IBInspectable NSString *key;

@property (nonatomic, strong) IBInspectable UIColor *mainColor;
@property (nonatomic, strong) UIFont *mainFont; // Apple pls rdar://19973159

@property (nonatomic, strong) IBInspectable UIColor *secondaryColor;
@property (nonatomic, strong) UIFont *secondaryFont;

@property (nonatomic, strong) IBInspectable UIColor *selectedColor;

@end
