//
//  BOSetting+Private.h
//  Bohr
//
//  Created by David Román Aguirre on 4/6/15.
//  Copyright (c) 2015 David Roman. All rights reserved.
//

#import "BOSetting.h"

@interface BOSetting ()

typedef void(^BOSettingValueDidChangeBlock)(void);

@property (nonatomic, copy) BOSettingValueDidChangeBlock valueDidChangeBlock;

@end
