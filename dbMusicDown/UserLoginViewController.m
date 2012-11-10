//
//  UserLoginViewController.m
//  dbMusicDown
//
//  Created by Eric.C on 12-11-10.
//  Copyright (c) 2012年 Eric.C. All rights reserved.
//

#import "UserLoginViewController.h"

@interface UserLoginViewController ()

@end

@implementation UserLoginViewController
@synthesize usrAccountTextField = _usrAccountTextField;
@synthesize usrPasswordTextField = _usrPasswordTextField;
@synthesize delegate = _delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (IBAction)loginClicked:(NSButton *)sender {
    [_delegate loginWithUsrname:_usrAccountTextField.stringValue
                       Password:_usrPasswordTextField.stringValue];
}
@end
