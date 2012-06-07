//
//  WifiViewController.m
//  Settings
//
//  Created by Jeffrey Verkoeyen on 12-06-06.
//  Copyright (c) 2012 Memento. All rights reserved.
//

#import "WifiViewController.h"

typedef enum {
  WifiToggleSwitch,
  AskToJoinSwitch,
} FormIds;

@interface WifiViewController ()
@property (nonatomic, readwrite, retain) NITableViewModel* model;
@property (nonatomic, readwrite, retain) NITableViewActions* actions;
@end

@implementation WifiViewController

@synthesize model;
@synthesize actions;

- (id)initWithStyle:(UITableViewStyle)style {
  self = [super initWithStyle:UITableViewStyleGrouped];
  if (self) {
    self.title = @"Wi-Fi Networks";
  }
  return self;
}

- (void)refreshModel {
  NSMutableArray* contents =
  [NSMutableArray arrayWithObjects:
   [NISwitchFormElement switchElementWithID:WifiToggleSwitch
                                  labelText:@"Wi-Fi"
                                      value:[GlobalState sharedInstance].wifi
                            didChangeTarget:self
                          didChangeSelector:@selector(didChangeWifi:)],
   nil];

  if (![GlobalState sharedInstance].wifi) {
    [contents addObjectsFromArray:
     [NSArray arrayWithObjects:
      [NITableViewModelFooter footerWithTitle:@"Location accuracy is improved when Wi-Fi is enabled."],
      nil]];
    self.tableView.delegate = self;

  } else {
    [contents addObjectsFromArray:
     [NSArray arrayWithObjects:
      @"Choose a Network...",
      nil]];
    id wifi = [NITitleCellObject objectWithTitle:@"Wi-Fi 1"];
    [contents addObject:wifi];
    [contents addObjectsFromArray:[NSArray arrayWithObjects:
      @"",
      [NISwitchFormElement switchElementWithID:AskToJoinSwitch
                                     labelText:@"Ask to Join Networks"
                                         value:NO
                               didChangeTarget:self
                             didChangeSelector:@selector(didChangeAsk:)],
      nil]];
    self.actions = [[NITableViewActions alloc] initWithController:self];
    [self.actions attachTapAction:^BOOL(id object, UIViewController *controller) {
      NSLog(@"Did tap wifi network...connect!");
      return YES; // Returning yes indicates that we want to deselect the cell immediately.
    } toObject:wifi];
    [self.actions attachDetailAction:^BOOL(id object, UIViewController *controller) {
      NSLog(@"Did tap detail button of wifi network. Show details!");
      return NO;
    } toObject:wifi];
    self.tableView.delegate = [self.actions forwardingTo:self];
  }

  self.model = [[NITableViewModel alloc] initWithSectionedArray:contents delegate:(id)[NICellFactory class]];
  self.tableView.dataSource = self.model;
}

- (void)loadView {
  [super loadView];

  [self refreshModel];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
  return NIIsSupportedOrientation(toInterfaceOrientation);
}

- (void)didChangeWifi:(UISwitch *)control {
  [GlobalState sharedInstance].wifi = control.on;

  [self refreshModel];
  // We'll figure out animations later.
  [self.tableView reloadData];
}

- (void)didChangeAsk:(UISwitch *)control {
  
}

@end
