//
//  BOTableViewSection.h
//  Bohr
//
//  Created by David Román Aguirre on 1/6/15.
//  Copyright (c) 2015 David Roman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BOTableViewSection : UITableViewCell

@property (nonatomic, strong) NSString *headerTitle;
@property (nonatomic, strong) UIColor *mainColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIFont *mainFont UI_APPEARANCE_SELECTOR;

@property (nonatomic, readonly) NSArray *cells;

@property (nonatomic, strong) NSString *footerTitle;
@property (nonatomic, strong) UIColor *secondaryColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIFont *secondaryFont UI_APPEARANCE_SELECTOR;

+ (instancetype)sectionWithTitle:(NSString *)title;

- (void)addCells:(NSArray *)cells;

@end
