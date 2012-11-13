//
//  UserLoginViewController.h
//  dbMusicDown
//
//  Created by Eric.C on 12-11-10.
//  Copyright (c) 2012年 Eric.C. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol LoginDelegate

@required -(void)loginWithUsrname:(NSString *)userName Password:(NSString *)password;

@end


@interface UserLoginViewController : NSViewController

@property (assign) IBOutlet NSTextField *usrAccountTextField;
@property (assign) IBOutlet NSSecureTextField *usrPasswordTextField;
@property (assign) IBOutlet NSButton *autoLoginCheckbox;
@property (nonatomic, assign) id<LoginDelegate> delegate;

- (IBAction)loginClicked:(NSButton *)sender;

@end
