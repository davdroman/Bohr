//
//  BOTableViewSection.h
//  Bohr
//
//  Created by David Román Aguirre on 26/08/15.
//
//

#import <Foundation/Foundation.h>
#import "BOTableViewCell.h"
#import "MZAppearance.h"

@interface BOTableViewSection : NSObject <MZAppearance>

/// The header title of the section.
@property (nonatomic) NSString *headerTitle;

/// The header title color of the section.
@property (nonatomic) UIColor *headerTitleColor MZ_APPEARANCE_SELECTOR;

/// The header title font of the section.
@property (nonatomic) UIFont *headerTitleFont MZ_APPEARANCE_SELECTOR;

/// The footer title of the section.
@property (nonatomic) NSString *footerTitle;

/// The footer title color of the section.
@property (nonatomic) UIColor *footerTitleColor MZ_APPEARANCE_SELECTOR;

/// The footer title color of the section.
@property (nonatomic) UIFont *footerTitleFont MZ_APPEARANCE_SELECTOR;

/// The visible cells in the section.
@property (nonatomic, readonly) NSArray *cells;

/** Initializes a new BOTableViewSection object.
 *
 *	@param headerTitle The section header title.
 *	@param handler A block passed in order to set up anything in the section.
 **/
+ (instancetype)sectionWithHeaderTitle:(NSString *)headerTitle handler:(void (^)(BOTableViewSection *section))handler;

/// Adds a cell to the section.
- (void)addCell:(BOTableViewCell *)cell;

@end
