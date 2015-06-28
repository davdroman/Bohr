//
//  BOTableViewController.h
//  Bohr
//
//  Created by David Román Aguirre on 31/5/15.
//  Copyright (c) 2015 David Roman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BOTableViewController : UITableViewController

/// The text color for all the headers in the table view.
@property (nonatomic, strong) IBInspectable UIColor *headerTitlesColor;

/// The text font for all the headers in the table view.
@property (nonatomic, strong) UIFont *headerTitlesFont;

/// The text color for all the footers in the table view.
@property (nonatomic, strong) IBInspectable UIColor *footerTitlesColor;

/// The text font for all the footers in the table view.
@property (nonatomic, strong) UIFont *footerTitlesFont;

/// The setup method for the controller.
- (void)setup;

@end
