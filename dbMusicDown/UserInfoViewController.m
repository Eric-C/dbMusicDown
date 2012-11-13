//
//  UserInfoViewController.m
//  dbMusicDown
//
//  Created by Eric.C on 12-11-10.
//  Copyright (c) 2012年 Eric.C. All rights reserved.
//

#import "UserInfoViewController.h"
#import "dbLikelistFetch.h"

@interface UserInfoViewController ()

@end

@implementation UserInfoViewController
@synthesize userAccountTextField = _userAccountTextField;
@synthesize userNicknameTextField = _userNicknameTextField;
@synthesize delegate = _delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (IBAction)logoutClicked:(NSButton *)sender {
    [_delegate loginOutUsrname:[dbLikelistFetch sharedInstance].loginInfo.email];
}

- (void) refreshUserInfo{
    _userAccountTextField.stringValue = [dbLikelistFetch sharedInstance].loginInfo.email;
    _userNicknameTextField.stringValue = [dbLikelistFetch sharedInstance].loginInfo.user_name;
}
@end
