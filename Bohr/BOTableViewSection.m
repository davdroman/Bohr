//
//  BOTableViewSection.m
//  Bohr
//
//  Created by David Román Aguirre on 26/08/15.
//
//

#import "BOTableViewSection.h"

@interface BOTableViewSection ()

@property (nonatomic) NSArray *rawCells;
@property (nonatomic) NSArray *cells;

@end

@implementation BOTableViewSection

+ (instancetype)appearance {
	return [MZAppearance appearanceForClass:[self class]];
}

- (instancetype)init {
	if (self = [super init]) {
		self.rawCells = [NSArray new];
		// Workaround to UITableViewHeaderFooterView's default 0-sized font driving iOS 9 nuts (yeah, WTF Apple).
		self.footerTitleFont = [UIFont systemFontOfSize:13];
		// I mean, really, if you...
		// NSLog(@"%@", [UITableViewHeaderFooterView new].textLabel.font);
		// you get "font-size: 0.00pt".
		// Your documentation for fontWithName:size: says EXPLICITLY "this value must be greater than 0.0.".
		// Again, WTF Apple.
		[[[self class] appearance] applyInvocationTo:self];
	}
	
	return self;
}

- (instancetype)initWithHeaderTitle:(NSString *)headerTitle handler:(void (^)(BOTableViewSection *))handler {
	if (self = [self init]) {
		self.headerTitle = headerTitle;
		if (handler) handler(self);
	}
	
	return self;
}

+ (instancetype)sectionWithHeaderTitle:(NSString *)headerTitle handler:(void (^)(BOTableViewSection *))handler {
	return [[self alloc] initWithHeaderTitle:headerTitle handler:handler];
}

- (void)addCell:(BOTableViewCell *)cell {
	self.rawCells = [self.rawCells arrayByAddingObject:cell];
}

- (NSArray *)cells {
	return [self.rawCells filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(BOTableViewCell *cell, NSDictionary<NSString *,id> *bindings) {
		if (cell.visibilityKey.length > 0) {
			return cell.visibilityBlock([[NSUserDefaults standardUserDefaults] objectForKey:cell.visibilityKey]);
		}
		
		return YES;
	}]];
}

@end
