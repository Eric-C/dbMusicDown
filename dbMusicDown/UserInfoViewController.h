//
//  UserInfoViewController.h
//  dbMusicDown
//
//  Created by Eric.C on 12-11-10.
//  Copyright (c) 2012年 Eric.C. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol LogoutDelegate

@required -(void)loginOutUsrname:(NSString *)userName;
@required -(void)downloadAll;

@end

@interface UserInfoViewController : NSViewController

@property (assign) IBOutlet NSTextField *userAccountTextField;
@property (assign) IBOutlet NSTextField *userNicknameTextField;
@property (nonatomic, assign) id<LogoutDelegate> delegate;

- (IBAction)logoutClicked:(NSButton *)sender;
- (IBAction)downloadAllClicked:(NSButton *)sender;
- (void) refreshUserInfo;
@end
