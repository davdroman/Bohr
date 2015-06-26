//
//  TableViewController.h
//  BohrDemo
//
//  Created by David Román Aguirre on 31/5/15.
//

#import <Bohr/Bohr.h>

@interface TableViewController : BOTableViewController

@property (weak, nonatomic) IBOutlet BOTextTableViewCell *textCell;
@property (weak, nonatomic) IBOutlet BOChoiceTableViewCell *choiceCell;
@property (weak, nonatomic) IBOutlet BOChoiceTableViewCell *choiceDisclosureCell;
@property (weak, nonatomic) IBOutlet BOButtonTableViewCell *buttonCell;

@end

