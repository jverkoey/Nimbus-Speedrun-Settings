//
//  AppDelegate.m
//  Settings
//
//  Created by Jeffrey Verkoeyen on 12-06-06.
//  Copyright (c) 2012 Memento. All rights reserved.
//

#import "AppDelegate.h"

#import "RootController.h"

@implementation AppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  self.window.backgroundColor = [UIColor whiteColor];

  RootController* rc = [[RootController alloc] init];
  UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:rc];
  self.window.rootViewController = navController;

  [self.window makeKeyAndVisible];
  return YES;
}

@end
