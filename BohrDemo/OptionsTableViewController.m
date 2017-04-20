//
//  OptionsTableViewController.m
//  Bohr
//
//  Created by David Román Aguirre on 28/08/15.
//
//

#import "OptionsTableViewController.h"

@implementation OptionsTableViewController

- (void)setup {
	[super setup];
	self.title = @"Choice options";
	
	[self addSection:[BOTableViewSection sectionWithHeaderTitle:nil handler:^(BOTableViewSection *section) {
		[section addCell:[BOOptionTableViewCell cellWithTitle:@"Some description for option 1" key:@"choice_2" handler:^(BOOptionTableViewCell *cell) {
			cell.footerTitle = @"Some footer for option 1";
		}]];
		
		[section addCell:[BOOptionTableViewCell cellWithTitle:@"Some description for option 2" key:@"choice_2" handler:^(BOOptionTableViewCell *cell) {
			cell.footerTitle = @"Some footer for option 2";
		}]];
		
		[section addCell:[BOOptionTableViewCell cellWithTitle:@"Some description for option 3" key:@"choice_2" handler:^(BOOptionTableViewCell *cell) {
			cell.footerTitle = @"Some footer for option 3";
		}]];
		
		[section addCell:[BOOptionTableViewCell cellWithTitle:@"Some description for option 4" key:@"choice_2" handler:^(BOOptionTableViewCell *cell) {
			cell.footerTitle = @"Some footer for option 4";
		}]];
	}]];
}

@end
