//
//  RootController.m
//  Settings
//
//  Created by Jeffrey Verkoeyen on 12-06-06.
//  Copyright (c) 2012 Memento. All rights reserved.
//

#import "RootController.h"

@interface RootController ()
@property (nonatomic, readwrite, retain) NITableViewModel* model;
@end

typedef enum {
  AirplaneModeSwitch,
} FormIds;

@implementation RootController

@synthesize model;

- (id)initWithStyle:(UITableViewStyle)style {
  self = [super initWithStyle:UITableViewStyleGrouped];
  if (self) {
    self.title = @"Settings";

    // K, we need to show a switch cell here.
    NSMutableArray* contents =
    [NSMutableArray arrayWithObjects:
     [NISwitchFormElement switchElementWithID:AirplaneModeSwitch
                                    labelText:@"Airplane Mode"
                                        value:YES
                              didChangeTarget:self
                            didChangeSelector:@selector(didChangeAirplaneMode:)],
     nil];
    // NICellFactory here allows us to take advantage of the pre-built bindings between
    // Nimbus cells. This way we don't have to create our own factory until we absolutely need to.
    self.model = [[NITableViewModel alloc] initWithSectionedArray:contents delegate:(id)[NICellFactory class]];
  }
  return self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return NIIsSupportedOrientation(interfaceOrientation);
}

- (void)loadView {
  [super loadView];

  self.tableView.dataSource = self.model;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
  id object = [self.model objectAtIndexPath:indexPath];
  if ([object isKindOfClass:[NIFormElement class]]) {
    NIFormElement* formElement = object;
    if (AirplaneModeSwitch == formElement.elementID) {
      cell.imageView.image = [UIImage imageNamed:@"Settings-Air"];
    }
  }
}

#pragma mark - Form Elements

- (void)didChangeAirplaneMode:(UISwitch *)element {
  NSLog(@"%d", element.on);
}

@end
