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
#import "dbLikelistFetch.h"

NSString *const kUserLoginView = @"UserLoginViewController";

@interface AppDelegate ()

@property (nonatomic, retain) UserLoginViewController *loginViewController;

@end

@implementation AppDelegate
@synthesize usrLoginAndInfoView = _usrLoginAndInfoView;
@synthesize loginViewController = _loginViewController;

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
	//Show UsrLoginView if not autoLogin
    _loginViewController = [[UserLoginViewController alloc] initWithNibName:kUserLoginView bundle:nil];
    _loginViewController.delegate = self;
    [_usrLoginAndInfoView addSubview:_loginViewController.view];
    [_loginViewController.view setFrame:_usrLoginAndInfoView.bounds];
    
}

- (void)loginWithUsrname:(NSString *)userName Password:(NSString *)password
{
    [[dbLikelistFetch sharedInstance] LoginWithUsername:userName Password:password];
    [_loginViewController.view setHidden:YES];
}

- (IBAction)getSonglist:(NSButton *)sender {
  /*
    dbLikelistFetch* listFetch = [[dbLikelistFetch alloc] init];
    [listFetch LoginWithUsername:@"mr.cyclopedia@gmail.com" Password:@"2395320"];
    [listFetch FetchLikeList];
   // [listFetch release];
    
    NSString * path = @"/Users/Eric/Downloads/1.mp3";

    DoubanMusicInfo* info = [listFetch.songList objectAtIndex:2];
    
    NSURL *url = [ NSURL URLWithString : info.songUrl ];
    
    ASIHTTPRequest *request = [ ASIHTTPRequest requestWithURL :url];
    
    [request setDownloadDestinationPath :path];
    
   // [request setDownloadProgressDelegate : progressView ];
    
    [request startSynchronous ];
     
   */
}
@end
