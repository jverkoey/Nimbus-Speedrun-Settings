//
//  WifiViewController.m
//  Settings
//
//  Created by Jeffrey Verkoeyen on 12-06-06.
//  Copyright (c) 2012 Memento. All rights reserved.
//

#import "WifiViewController.h"

@interface WifiViewController ()
@end

@implementation WifiViewController

- (id)initWithStyle:(UITableViewStyle)style {
  self = [super initWithStyle:UITableViewStyleGrouped];
  if (self) {
    self.title = @"Wi-Fi Networks";
  }
  return self;
}

@end
