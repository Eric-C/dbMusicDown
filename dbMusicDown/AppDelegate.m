//
//  AppDelegate.m
//  dbMusicDown
//
//  Created by Eric.C on 12-11-5.
//  Copyright (c) 2012年 Eric.C. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "dbLikelistFetch.h"
#import "songlistTableviewController.h"
#import "ASIHTTPRequest.h"

@implementation AppDelegate


- (void)dealloc
{
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

- (IBAction)getSonglist:(NSButton *)sender {
    
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
     
}
@end
