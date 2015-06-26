//
//  BOTableViewController.h
//  Bohr
//
//  Created by David Román Aguirre on 31/5/15.
//  Copyright (c) 2015 David Roman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BOTableViewController : UITableViewController

@property (nonatomic, strong) IBInspectable UIColor *headerTitlesColor;
@property (nonatomic, strong) UIFont *headerTitlesFont;

@property (nonatomic, strong) IBInspectable UIColor *footerTitlesColor;
@property (nonatomic, strong) UIFont *footerTitlesFont;

- (void)setup;

@end
