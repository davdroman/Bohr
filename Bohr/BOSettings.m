//
//  BOSettings.m
//  Bohr
//
//  Created by Kevin Wolkober on 1/31/16.
//
//

#import "BOSettings.h"

@interface BOSettings ()

@end

@implementation BOSettings

+ (instancetype)sharedSettings
{
    static BOSettings *__sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedInstance = [[self alloc] init];
    });

    return __sharedInstance;
}

- (NSUserDefaults *)userDefaults
{
    if (!_userDefaults) {
        _userDefaults = [NSUserDefaults standardUserDefaults];
    }

    return _userDefaults;
}

@end
