//
//  GlobalState.h
//  Settings
//
//  Created by Jeffrey Verkoeyen on 12-06-06.
//  Copyright (c) 2012 Memento. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalState : NSObject
+ (GlobalState *)sharedInstance;
@property (nonatomic, readwrite, assign) BOOL wifi;
@end
