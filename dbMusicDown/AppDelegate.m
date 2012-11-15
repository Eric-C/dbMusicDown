//
//  AppDelegate.m
//  dbMusicDown
//
//  Created by Eric.C on 12-11-5.
//  Copyright (c) 2012年 Eric.C. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "AppDelegate.h"

#import "SongListViewController.h"
#import "BannerViewController.h"
#import "dbLikelistFetch.h"

NSString *const kUserLoginView = @"UserLoginViewController";
NSString *const kUserInfoView = @"UserInfoViewController";
NSString *const kSongListView = @"SongListViewController";
NSString *const kBannerdView = @"BannerViewController";

@interface AppDelegate ()

@property (nonatomic, retain) UserLoginViewController *loginViewController;
@property (nonatomic, retain) UserInfoViewController *usrInfoViewController;
@property (nonatomic, retain) SongListViewController *songListViewController;
@property (nonatomic, retain) BannerViewController *bannerViewController;
@property (assign) Boolean isLogin;

@end

@implementation AppDelegate
@synthesize usrLoginAndInfoViewTarget = _usrLoginAndInfoViewTarget;
@synthesize tableViewTarget = _tableViewTarget;
@synthesize bannerViewTarget = _bannerViewTarget;
@synthesize loginViewController = _loginViewController;
@synthesize usrInfoViewController = _usrInfoViewController;
@synthesize songListViewController = _songListViewController;
@synthesize bannerViewController = _bannerViewController;
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
        [[dbLikelistFetch sharedInstance] clearAllInfo];
        [_songListViewController.tableView reloadData];
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

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender
{
    return YES;
}

- (void)awakeFromNib
{
    _loginViewController = [[UserLoginViewController alloc] initWithNibName:kUserLoginView bundle:nil];
    _loginViewController.delegate = self;
    [_usrLoginAndInfoViewTarget addSubview:_loginViewController.view];
    [_loginViewController.view setFrame:_usrLoginAndInfoViewTarget.bounds];
    
    _usrInfoViewController = [[UserInfoViewController alloc] initWithNibName:kUserInfoView bundle:nil];
    _usrInfoViewController.delegate = self;
    [_usrLoginAndInfoViewTarget addSubview:_usrInfoViewController.view];
    [_usrInfoViewController.view setFrame:_usrLoginAndInfoViewTarget.bounds];
    
    _songListViewController = [[SongListViewController alloc] initWithNibName:kSongListView bundle:nil];
    [_tableViewTarget addSubview:_songListViewController.view];
    [_songListViewController.view setFrame:_tableViewTarget.bounds];
   
    _bannerViewController = [[BannerViewController alloc] initWithNibName:kBannerdView bundle:nil];
    [_bannerViewTarget addSubview:_bannerViewController.view];
    [_bannerViewController.view setFrame:_bannerViewTarget.bounds];
    
    NSString *errorDesc = nil;
    NSPropertyListFormat format;
    NSString *plistPath;
    NSDictionary *temp = nil;
    NSString *rootPath = NSTemporaryDirectory();

    NSNumber *bAutoLogin = 0;
    plistPath = [rootPath stringByAppendingPathComponent:@"dbMusicDown.plist"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
        NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
        temp = (NSDictionary *)[NSPropertyListSerialization
                                              propertyListFromData:plistXML
                                              mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                              format:&format
                                              errorDescription:&errorDesc];
        
        bAutoLogin = [temp objectForKey:@"AutoLogin"];
    }
    
    if ([bAutoLogin integerValue]) {
        NSString *usrAccount = [temp objectForKey:@"Account"];
        NSString *usrPassword = [temp objectForKey:@"Password"];
        [self loginWithUsrname:usrAccount Password:usrPassword];
    }
    else
    {
        self.isLogin = NO;
    }
}

- (void)applicationWillTerminate:(NSNotification *)notification
{
    NSNumber *bAutoLogin = [NSNumber numberWithInteger:_loginViewController.autoLoginCheckbox.state];
    
    if (self.isLogin == YES) {
        NSString *error;
        NSString *rootPath = NSTemporaryDirectory();
        NSString *plistPath = [rootPath stringByAppendingPathComponent:@"dbMusicDown.plist"];
        NSDictionary *plistDict = [NSDictionary dictionaryWithObjects:
                                   [NSArray arrayWithObjects: _loginViewController.usrAccountTextField.stringValue, _loginViewController.usrPasswordTextField.stringValue, bAutoLogin, nil]
                                                              forKeys:[NSArray arrayWithObjects: @"Account", @"Password", @"AutoLogin", nil]];
        NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:plistDict
                                                                       format:NSPropertyListXMLFormat_v1_0
                                                             errorDescription:&error];
        if(plistData) {
            [plistData writeToFile:plistPath atomically:YES];
        }
        else {
            [error release];
        }
    }
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
        NSAlert *logoinAlert = [NSAlert alertWithMessageText:@"登陆失败"
                                               defaultButton:@"OK"
                                             alternateButton:nil
                                                 otherButton:nil
                                   informativeTextWithFormat:@"请确保网络正常，以及用户名密码正确！"];
        [logoinAlert setAlertStyle:NSInformationalAlertStyle];
        [logoinAlert runModal];
        
        self.isLogin = NO;
    }
}

- (void)loginOutUsrname:(NSString *)userName
{
    //Log out
    if (_songListViewController.downLoadingSongs.count != 0) {
        NSAlert *logoutAlert = [NSAlert alertWithMessageText:@"有音乐正在下载，无法退出当前用户"
                                             defaultButton:@"OK"
                                           alternateButton:nil
                                               otherButton:nil
                                 informativeTextWithFormat:@"取消下载或等待下载完成之后，再退出当前用户"];
        [logoutAlert setAlertStyle:NSCriticalAlertStyle];
        [logoutAlert runModal];
    } else {
        self.isLogin = NO;
    }
}

- (void)downloadAll
{
    [_songListViewController downloadAll];
}

@end
