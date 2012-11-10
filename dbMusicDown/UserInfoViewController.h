//
//  UserInfoViewController.h
//  dbMusicDown
//
//  Created by Eric.C on 12-11-10.
//  Copyright (c) 2012年 Eric.C. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface UserInfoViewController : NSViewController

@property (assign) IBOutlet NSTextField *userAccountTextField;
@property (assign) IBOutlet NSTextField *userNicknameTextField;

- (IBAction)logoutClicked:(NSButton *)sender;
- (void) refreshUserInfo;
@end
