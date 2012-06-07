//
//  RootController.m
//  Settings
//
//  Created by Jeffrey Verkoeyen on 12-06-06.
//  Copyright (c) 2012 Memento. All rights reserved.
//

#import "RootController.h"

#import "WifiViewController.h"

@interface RootController ()
@property (nonatomic, readwrite, retain) NITableViewModel* model;

// This actions object will handle the display of cells, as well as dealing with the user
// interactions themselves.
@property (nonatomic, readwrite, retain) NITableViewActions* actions;
@end

typedef enum {
  AirplaneModeSwitch,
} FormIds;

@implementation RootController

@synthesize model;
@synthesize actions;

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

    NISubtitleCellObject* wifi = [NISubtitleCellObject objectWithTitle:@"Wi-Fi"
                                  subtitle:@"Off"];
    wifi.cellStyle = UITableViewCellStyleValue1;
    [contents addObject:wifi];
    NISubtitleCellObject* personalHotspot = [NISubtitleCellObject objectWithTitle:@"Personal Hotspot"
                                                                         subtitle:@"Off"];
    personalHotspot.cellStyle = UITableViewCellStyleValue1;
    [contents addObject:personalHotspot];
    NITitleCellObject* notifications = [NITitleCellObject objectWithTitle:@"Notifications"
                                                                    image:[UIImage imageNamed:@"notifications_icon"]];
    [contents addObject:notifications];
    NISubtitleCellObject* locationServices = [NISubtitleCellObject objectWithTitle:@"Location Services"
                                                                         subtitle:@"Off"
                                                                             image:[UIImage imageNamed:@"Location"]];
    locationServices.cellStyle = UITableViewCellStyleValue1;
    [contents addObject:locationServices];

    // Group divider
    [contents addObject:@""];
    
    NITitleCellObject* sounds = [NITitleCellObject objectWithTitle:@"Sounds"
                                                                    image:[UIImage imageNamed:@"Settings-Sound"]];
    [contents addObject:sounds];
    NITitleCellObject* brightness = [NITitleCellObject objectWithTitle:@"Brightness"
                                                             image:[UIImage imageNamed:@"Settings-Display"]];
    [contents addObject:brightness];
    NITitleCellObject* wallpaper = [NITitleCellObject objectWithTitle:@"Wallpaper"];
    [contents addObject:wallpaper];
    
    // Group divider
    [contents addObject:@""];
    
    NITitleCellObject* general = [NITitleCellObject objectWithTitle:@"General"
                                                             image:[UIImage imageNamed:@"Settings"]];
    [contents addObject:general];

    self.actions = [[NITableViewActions alloc] initWithController:self];
    [self.actions attachNavigationAction:NIPushControllerAction([WifiViewController class])
                                toObject:wifi];

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

  // Insert the actions object in the delegate chain.
  self.tableView.delegate = [self.actions forwardingTo:self];
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
