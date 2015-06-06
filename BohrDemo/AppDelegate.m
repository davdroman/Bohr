//
//  AppDelegate.m
//  BohrDemo
//
//  Created by David Román Aguirre on 31/5/15.
//

#import "AppDelegate.h"

#import "MainViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	
	[self setupAppearance];
	
	self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
	self.window.backgroundColor = [UIColor whiteColor];
	MainViewController *mainViewController = [[MainViewController alloc] initWithStyle:UITableViewStyleGrouped];
	self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:mainViewController];
	[self.window makeKeyAndVisible];
	
	return YES;
}

- (void)setupAppearance {
	UIColor *blueColor = [UIColor colorWithRed:72/255.0 green:165/255.0 blue:254/255.0 alpha:1];
	
	[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
	[UINavigationBar appearance].translucent = NO;
	[UINavigationBar appearance].titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
	[UINavigationBar appearance].barTintColor = blueColor;
	[UINavigationBar appearance].tintColor = [UIColor whiteColor];
	
	[BOTableViewCell appearance].mainColor = [UIColor colorWithWhite:0.3 alpha:1];
	[BOTableViewCell appearance].secondaryColor = blueColor;
	[BOTableViewCell appearance].selectedColor = blueColor;
	[BOTableViewSection appearance].mainColor = [UIColor colorWithWhite:0.45 alpha:1];
	[BOTableViewSection appearance].secondaryColor = [UIColor colorWithWhite:0.7 alpha:1];
}

@end
