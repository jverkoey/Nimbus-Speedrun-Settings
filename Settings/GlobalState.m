//
//  GlobalState.m
//  Settings
//
//  Created by Jeffrey Verkoeyen on 12-06-06.
//  Copyright (c) 2012 Memento. All rights reserved.
//

#import "GlobalState.h"

@implementation GlobalState

@synthesize wifi;

+ (GlobalState *)sharedInstance {
  static GlobalState *sSingleton;
  @synchronized(self) {
    if (nil == sSingleton) {
      sSingleton = [[self alloc] init];
    }
    return sSingleton;
  }
}

@end
