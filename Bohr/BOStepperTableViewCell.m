//
//  BOStepperTableViewCell.m
//  Bohr
//
//  Created by Gulam Moledina on 1/12/16.
//
//

#import "BOStepperTableViewCell.h"
#import "BOTableViewCell+Subclass.h"

@implementation BOStepperTableViewCell

- (void)setup {
    _stepper = [UIStepper new];
    [self.stepper addTarget:self action:@selector(stepperValueDidChange) forControlEvents:UIControlEventValueChanged];
    self.accessoryView = self.stepper;
}

- (void)updateAppearance {
    self.stepper.tintColor = self.secondaryColor;
}

- (NSString *)footerTitle {
    return [NSString stringWithFormat:@"%.f", [self.setting.value doubleValue]];
}

- (void)stepperValueDidChange {
    self.setting.value = @(self.stepper.value);
}

- (void)settingValueDidChange {
    [self.stepper setValue:[self.setting.value doubleValue]];
}

@end
