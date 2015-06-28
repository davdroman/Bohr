//
//  BOSetting.h
//  BOSettings
//
//  Created by David Román Aguirre on 31/5/15.
//  Copyright (c) 2015 David Roman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BOSetting : NSObject

/// The NSUserDefaults key for the cell.
@property (nonatomic, readonly) NSString *key;

/// The NSUserDefaults value assigned for the key defined on the cell.
@property (nonatomic, assign) id value;

/// Instantiates a new BOSetting object with a key.
+ (instancetype)settingWithKey:(NSString *)key;

@end
