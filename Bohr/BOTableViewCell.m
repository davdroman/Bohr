//
//  BOTableViewCell.m
//  Bohr
//
//  Created by David Román Aguirre on 31/5/15.
//  Copyright (c) 2015 David Roman. All rights reserved.
//

#import "BOTableViewCell+Subclass.h"

#import "BOTableViewCell+Private.h"
#import "BOSetting+Private.h"
#import "BOTableViewController+Private.h"

@implementation BOTableViewCell

- (instancetype)initWithTitle:(NSString *)title key:(NSString *)key handler:(void (^)(id cell))handler {
	if (self = [self initWithStyle:(key ? UITableViewCellStyleValue1 : UITableViewCellStyleDefault) reuseIdentifier:nil]) {
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		[self setup];
		if (handler) handler(self);
		self.clipsToBounds = YES;
		self.textLabel.numberOfLines = 0;
		self.textLabel.text = title;
		self.textLabel.highlightedTextColor = [UIColor whiteColor];
		self.detailTextLabel.highlightedTextColor = [UIColor whiteColor];
		self.key = key;
		self.setting = [BOSetting settingWithKey:self.key];
	}
	
	return self;
}

- (void)setDestinationViewController:(UIViewController *)destinationViewController {
	if (_destinationViewController != destinationViewController) {
		_destinationViewController = destinationViewController;
		self.accessoryType = destinationViewController ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
	}
}

+ (instancetype)cellWithTitle:(NSString *)title key:(NSString *)key handler:(void (^)(id cell))handler {
	return [[self alloc] initWithTitle:title key:key handler:handler];
}

- (void)layoutSubviews {
	[super layoutSubviews];
	
	if (self.expansionHeight > 0) {
		CGFloat yOffset = (self.layoutMargins.top-self.frame.size.height)/2;
		
		self.textLabel.center = CGPointMake(self.textLabel.center.x, self.textLabel.center.y+yOffset);
		self.detailTextLabel.center = CGPointMake(self.detailTextLabel.center.x, self.detailTextLabel.center.y+yOffset);
	}
}

#pragma mark Customization

- (void)_updateAppearance {
	self.tintColor = self.secondaryColor;
	
	self.textLabel.textColor = self.mainColor;
	self.textLabel.font = self.mainFont;
	
	self.detailTextLabel.textColor = self.secondaryColor;
	self.detailTextLabel.font = self.secondaryFont;
	
	self.selectedBackgroundView = [UIView new];
	self.selectedBackgroundView.backgroundColor = self.selectedColor;
}

#pragma mark Subclassing

- (void)setup {}
- (void)setupConstraints {}
- (void)updateAppearance {}
- (CGFloat)expansionHeight {return 0;}
- (NSString *)footerTitle {return nil;}
- (void)wasSelectedFromViewController:(BOTableViewController *)viewController {}
- (void)settingValueDidChange {}

@end
