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

@implementation RootController

@synthesize model;

- (id)initWithStyle:(UITableViewStyle)style {
  self = [super initWithStyle:UITableViewStyleGrouped];
  if (self) {
    self.title = @"Settings";

    NSMutableArray* contents =
    [NSMutableArray arrayWithObjects:
     [NITitleCellObject objectWithTitle:@"Airplane Mode" image:[UIImage imageNamed:@"Settings-Air"]],
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

@end
