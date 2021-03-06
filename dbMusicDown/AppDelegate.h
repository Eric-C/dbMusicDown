//
//  AppDelegate.h
//  dbMusicDown
//
//  Created by Eric.C on 12-11-5.
//  Copyright (c) 2012年 Eric.C. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "UserLoginViewController.h"
#import "UserInfoViewController.h"

@interface AppDelegate : NSObject <NSApplicationDelegate, LoginDelegate, LogoutDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSView *usrLoginAndInfoViewTarget;
@property (assign) IBOutlet NSView *tableViewTarget;
@property (assign) IBOutlet NSView *bannerViewTarget;

@end
