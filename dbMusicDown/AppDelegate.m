//
//  AppDelegate.m
//  dbMusicDown
//
//  Created by Eric.C on 12-11-5.
//  Copyright (c) 2012年 Eric.C. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "UserLoginViewController.h"
#import "UserInfoViewController.h"
#import "SongListViewController.h"
#import "DownloadViewController.h"
#import "dbLikelistFetch.h"

NSString *const kUserLoginView = @"UserLoginViewController";
NSString *const kUserInfoView = @"UserInfoViewController";
NSString *const kSongListView = @"SongListViewController";
NSString *const kDownloadView = @"DownloadViewController";

@interface AppDelegate ()

@property (nonatomic, retain) UserLoginViewController *loginViewController;
@property (nonatomic, retain) UserInfoViewController *usrInfoViewController;
@property (nonatomic, retain) SongListViewController *songListViewController;
@property (nonatomic, retain) DownloadViewController *downloadViewController;
@property (assign) Boolean isLogin;

@end

@implementation AppDelegate
@synthesize usrLoginAndInfoViewTarget = _usrLoginAndInfoViewTarget;
@synthesize tableViewTarget = _tableViewTarget;
@synthesize downloadViewTarget = _downloadViewTarget;
@synthesize loginViewController = _loginViewController;
@synthesize usrInfoViewController = _usrInfoViewController;
@synthesize songListViewController = _songListViewController;
@synthesize downloadViewController = _downloadViewController;
@synthesize isLogin = _isLogin;

- (void) setIsLogin:(Boolean)isLogin
{
    _isLogin = isLogin;
    
    if (_isLogin) {
        [_usrInfoViewController refreshUserInfo];
        [_loginViewController.view setHidden:YES];
        [_usrInfoViewController.view setHidden:NO];
        
    } else{
        [_loginViewController.view setHidden:NO];
        [_usrInfoViewController.view setHidden:YES];
    }
}

- (Boolean) isLogin
{
    return _isLogin;
}

- (void)dealloc
{
    [_loginViewController release];
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

- (void)awakeFromNib
{
    _loginViewController = [[UserLoginViewController alloc] initWithNibName:kUserLoginView bundle:nil];
    _loginViewController.delegate = self;
    [_usrLoginAndInfoViewTarget addSubview:_loginViewController.view];
    [_loginViewController.view setFrame:_usrLoginAndInfoViewTarget.bounds];
    
    _usrInfoViewController = [[UserInfoViewController alloc] initWithNibName:kUserInfoView bundle:nil];
    [_usrLoginAndInfoViewTarget addSubview:_usrInfoViewController.view];
    [_usrInfoViewController.view setFrame:_usrLoginAndInfoViewTarget.bounds];
    
    _songListViewController = [[SongListViewController alloc] initWithNibName:kSongListView bundle:nil];
    [_tableViewTarget addSubview:_songListViewController.view];
    [_songListViewController.view setFrame:_tableViewTarget.bounds];
   
    _downloadViewController = [[DownloadViewController alloc] initWithNibName:kDownloadView bundle:nil];
    [_downloadViewTarget addSubview:_downloadViewController.view];
    [_downloadViewController.view setFrame:_downloadViewTarget.bounds];
    
    _songListViewController.delegate = _downloadViewController;
    
    //Show UsrLoginView if not autoLogin
    self.isLogin = NO;
}

- (void)loginWithUsrname:(NSString *)userName Password:(NSString *)password
{
    NSError *error = [[dbLikelistFetch sharedInstance] LoginWithUsername:userName Password:password];
    
    if (error == nil) {
        error = [[dbLikelistFetch sharedInstance] FetchLikeList];
        if (error == nil) {
            self.isLogin = YES;
            [_songListViewController.tableView reloadData];

        }
    } else{
        self.isLogin = NO;
    }
}

@end
