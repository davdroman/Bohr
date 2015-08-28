//
//  BOTableViewSection.m
//  Bohr
//
//  Created by David Román Aguirre on 26/08/15.
//
//

#import "BOTableViewSection.h"

@interface BOTableViewSection ()

@property (nonatomic) NSArray *cells;

@end

@implementation BOTableViewSection

+ (instancetype)appearance {
	return [MZAppearance appearanceForClass:[self class]];
}

- (instancetype)init {
	if (self = [super init]) {
		self.cells = [NSArray new];
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
	self.cells = [self.cells arrayByAddingObject:cell];
}

@end
