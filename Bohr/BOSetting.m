//
//  BOSetting.m
//  BOSettings
//
//  Created by David Román Aguirre on 31/5/15.
//  Copyright (c) 2015 David Roman. All rights reserved.
//

#import "BOSetting+Private.h"

@implementation BOSetting

+ (instancetype)settingWithKey:(NSString *)key {
	return [[self alloc] initWithKey:key];
}

- (instancetype)initWithKey:(NSString *)key {
	if (self = [super init]) {
		_key = key;
		[[NSUserDefaults standardUserDefaults] addObserver:self forKeyPath:self.key options:NSKeyValueObservingOptionNew context:nil];
	}
	
	return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	self.value = change[@"new"];
	if (self.valueDidChangeBlock) self.valueDidChangeBlock();
}

- (id)value {
	return [[NSUserDefaults standardUserDefaults] objectForKey:self.key];
}

- (void)setValue:(id)value {
	if (self.value != value) {
		[[NSUserDefaults standardUserDefaults] setObject:value forKey:self.key];
	}
}

- (void)dealloc {
	[[NSUserDefaults standardUserDefaults] removeObserver:self forKeyPath:self.key];
}

@end
