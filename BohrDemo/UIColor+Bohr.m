//
//  UIColor+Bohr.m
//  Bohr
//
//  Created by David Román Aguirre on 26/08/15.
//
//

#import "UIColor+Bohr.h"

@implementation UIColor (Bohr)

+ (UIColor *)bo_lightGrayColor {
	return [UIColor colorWithWhite:0.6 alpha:1];
}

+ (UIColor *)bo_grayColor {
	return [UIColor colorWithWhite:0.5 alpha:1];
}

+ (UIColor *)bo_darkGrayColor {
	return [UIColor colorWithWhite:0.3 alpha:1];
}

+ (UIColor *)bo_blueColor {
	return [UIColor colorWithRed:71/255.0 green:165/255.0 blue:254/255.0 alpha:1];
}

@end
