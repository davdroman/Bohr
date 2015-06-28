//
//  AppDelegate.m
//  BohrDemo
//
//  Created by David Román Aguirre on 31/5/15.
//

#import "AppDelegate.h"

#import <Bohr/Bohr.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	[self setupAppearance];
	[self setupDefaults];
	
	return YES;
}

- (void)setupAppearance {
	[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
	
	UIColor *blueColor = [UIColor colorWithRed:71/255.0 green:165/255.0 blue:254/255.0 alpha:1];
	[BOTableViewCell appearance].mainColor = [UIColor colorWithWhite:0.3 alpha:1];
	[BOTableViewCell appearance].secondaryColor = blueColor;
	[BOTableViewCell appearance].selectedColor = blueColor;
}

- (void)setupDefaults {
	[[NSUserDefaults standardUserDefaults] registerDefaults:@{
															  @"bool_1": @YES,
															  @"bool_2": @NO,
															  @"text": @"",
															  @"choice": @0,
															  @"choice_2": @2,
															  @"time": @300,
															  }];
}

@end
