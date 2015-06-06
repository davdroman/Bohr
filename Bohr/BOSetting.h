//
//  BOSetting.h
//  BOSettings
//
//  Created by David Román Aguirre on 31/5/15.
//  Copyright (c) 2015 David Roman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BOSetting : NSObject

@property (nonatomic, readonly) NSString *key;
@property (nonatomic, assign) id value;

+ (instancetype)settingWithDefaultValue:(id)defaultValue forKey:(NSString *)key;

@end
