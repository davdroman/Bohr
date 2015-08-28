//
//  AppDelegate.m
//  BohrDemo
//
//  Created by David Román Aguirre on 31/5/15.
//

#import "AppDelegate.h"

#import "TableViewController.h"
#import "UIColor+Bohr.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	[self setupDefaults];
	[self setupAppearance];
	
	self.window = [UIWindow new];
	self.window.frame = [UIScreen mainScreen].bounds;
	self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[TableViewController new]];
	[self.window makeKeyAndVisible];
	
	return YES;
}

- (void)setupDefaults {
	[[NSUserDefaults standardUserDefaults] registerDefaults:@{
															  @"bool_1": @YES,
															  @"bool_2": @NO,
															  @"text": @"",
															  @"date": [NSDate new],
															  @"time": [NSDate new],
															  @"choice_1": @0,
															  @"choice_2": @2,
															  }];
}

- (void)setupAppearance {
	[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
	
	[UINavigationBar appearance].translucent = NO;
	[UINavigationBar appearance].barTintColor = [UIColor bo_blueColor];
	[UINavigationBar appearance].tintColor = [UIColor whiteColor];
	[UINavigationBar appearance].titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
	
	[UITableView appearance].backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
	
	[BOTableViewSection appearance].headerTitleColor = [UIColor bo_grayColor];
	[BOTableViewSection appearance].footerTitleColor = [UIColor bo_lightGrayColor];
	
	[BOTableViewCell appearance].mainColor = [UIColor bo_darkGrayColor];
	[BOTableViewCell appearance].secondaryColor = [UIColor bo_blueColor];
	[BOTableViewCell appearance].selectedColor = [UIColor bo_blueColor];
}

@end
