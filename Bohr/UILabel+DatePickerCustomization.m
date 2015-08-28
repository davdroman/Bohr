//
//  UILabel+DatePickerCustomization.m
//  Bohr
//
//  Created by David Román Aguirre on 28/08/15.
//	Built from this amazing comment from StackOverflow http://stackoverflow.com/a/21084227/5278228
//

#import "UILabel+DatePickerCustomization.h"
#import <objc/runtime.h>

#import "BODateTableViewCell.h"

@implementation UILabel (DatePickerCustomization)

+ (void)load {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		[self swizzleInstanceSelector:@selector(setTextColor:) withSelector:@selector(bo_setTextColor:)];
		[self swizzleInstanceSelector:@selector(setFont:) withSelector:@selector(bo_setFont:)];
		[self swizzleInstanceSelector:@selector(willMoveToSuperview:) withSelector:@selector(bo_willMoveToSuperview:)];
	});
}

+ (void)swizzleInstanceSelector:(SEL)originalSelector withSelector:(SEL)newSelector {
	Method originalMethod = class_getInstanceMethod(self, originalSelector);
	Method newMethod = class_getInstanceMethod(self, newSelector);
	
	BOOL methodAdded = class_addMethod([self class], originalSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
	
	if (methodAdded) {
		class_replaceMethod([self class], newSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
	} else {
		method_exchangeImplementations(originalMethod, newMethod);
	}
}

- (BOOL)view:(UIView *)view hasSuperviewOfClass:(Class)class {
	if (view.superview) {
		if ([view.superview isKindOfClass:class]){
			return YES;
		}
		
		return [self view:view.superview hasSuperviewOfClass:class];
	}
	
	return NO;
}

- (BOOL)belongsToDatePicker {
	return [self view:self hasSuperviewOfClass:[UIDatePicker class]] || [self view:self hasSuperviewOfClass:NSClassFromString(@"UIDatePickerWeekMonthDayView")] || [self view:self hasSuperviewOfClass:NSClassFromString(@"UIDatePickerContentView")];
}

- (UIColor *)cellAppearanceMainColor {
	return [BODateTableViewCell appearance].mainColor ? [BODateTableViewCell appearance].mainColor : [BOTableViewCell appearance].mainColor;
}

- (UIFont *)cellAppearanceSecondaryFont {
	return [BODateTableViewCell appearance].secondaryFont ? [BODateTableViewCell appearance].secondaryFont : [BOTableViewCell appearance].secondaryFont;
}

// Forces the text colour & font for the UIDatePicker (if belongs to any).

- (void)bo_setTextColor:(UIColor *)textColor {
	textColor = [self belongsToDatePicker] ? [self cellAppearanceMainColor] : textColor;
	[self bo_setTextColor:textColor];
}

- (void)bo_setFont:(UIFont *)font {
	if ([self belongsToDatePicker]) {
		
		font = [self cellAppearanceSecondaryFont] ? [self cellAppearanceSecondaryFont] : font;
		
		CGSize size = [self.text sizeWithAttributes:@{NSFontAttributeName: font}];
		
		// For current font point size, calculate points per pixel
		CGFloat pointsPerPixel = font.pointSize/size.height;
		
		// Scale up point size for the height of the label
		CGFloat desiredPointSize = 27*pointsPerPixel;
		
		font = [font fontWithSize:desiredPointSize];
	}
	
	[self bo_setFont:font];
}

// Some of the UILabels haven't been added to a superview yet so listen for when they do.
// This is just preventive code. You never know how the API may change in the future.

- (void)bo_willMoveToSuperview:(UIView *)newSuperview {
	[self bo_setTextColor:self.textColor];
	[self bo_setFont:self.font];
	[self bo_willMoveToSuperview:newSuperview];
}

@end
