//
//  BOSettings.h
//  Bohr
//
//  Created by Kevin Wolkober on 1/31/16.
//
//

#import <Foundation/Foundation.h>

@interface BOSettings : NSObject

@property (nonatomic) NSUserDefaults *userDefaults;

+ (instancetype)sharedSettings;

@end
