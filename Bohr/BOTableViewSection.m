//
//  BOTableViewSection.m
//  Bohr
//
//  Created by David Román Aguirre on 1/6/15.
//  Copyright (c) 2015 David Roman. All rights reserved.
//

#import "BOTableViewSection.h"

@interface BOTableViewSection ()

@property (nonatomic, readwrite) NSArray *cells;

@end

@implementation BOTableViewSection

+ (instancetype)sectionWithTitle:(NSString *)title {
	return [[self alloc] initWithTitle:title];
}

- (instancetype)initWithTitle:(NSString *)title {
	if (self = [super init]) {
		self.headerTitle = title;
		self.cells = [NSArray new];
	}
	
	return self;
}

- (void)addCells:(NSArray *)cells {
	self.cells = [self.cells arrayByAddingObjectsFromArray:cells];
}

@end
