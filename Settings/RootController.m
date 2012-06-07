//
//  RootController.m
//  Settings
//
//  Created by Jeffrey Verkoeyen on 12-06-06.
//  Copyright (c) 2012 Memento. All rights reserved.
//

#import "RootController.h"

@interface RootController ()
@end

@implementation RootController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    self.title = @"Settings";
  }
  return self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return NIIsSupportedOrientation(interfaceOrientation);
}

@end
