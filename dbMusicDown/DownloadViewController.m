//
//  DownloadViewController.m
//  dbMusicDown
//
//  Created by Eric.C on 12-11-10.
//  Copyright (c) 2012年 Eric.C. All rights reserved.
//

#import "DownloadViewController.h"
#import "dbLikelistFetch.h"
#import "ASIHTTPRequest.h"

@interface DownloadViewController ()

@property(retain, nonatomic) NSMutableArray* toDownloadList;

@end

@implementation DownloadViewController
@synthesize downloadTextfield1 = _downloadTextfield1;
@synthesize downloadTextfield2 = _downloadTextfield2;
@synthesize downloadTextfield3 = _downloadTextfield3;
@synthesize downloadProgress1 = _downloadProgress1;
@synthesize downloadProgress2 = _downloadProgress2;
@synthesize downloadProgress3 = _downloadProgress3;

@synthesize toDownloadList = _toDownloadList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
        _toDownloadList = [[NSMutableArray alloc] init];
    }
    
    return self;
}

-(void)downloadArray:(NSMutableArray *)array
{
    //init Download Array
    for (NSInteger i = 0; i < array.count; i++) {
        NSInteger index = [[array objectAtIndex:i] integerValue];

        DoubanMusicInfo *thisMusicInfo = [[dbLikelistFetch sharedInstance].songList objectAtIndex:index];
        [_toDownloadList addObject:thisMusicInfo];
    }
    
    while (_toDownloadList.count > 0) {
        //set lable and progress
        for (NSInteger i = 0; i < _toDownloadList.count && i < 3; i++) {
            DoubanMusicInfo *info = [_toDownloadList objectAtIndex:i];
            
            if (i == 0) {
                _downloadTextfield1.stringValue = info.title;
                [_downloadTextfield1 setHidden:NO];
                
                [_downloadProgress1 setHidden:NO];
            }
            if (i == 1) {
                _downloadTextfield2.stringValue = info.title;
                [_downloadTextfield2 setHidden:NO];
                
                [_downloadProgress2 setHidden:NO];
            }
            if (i == 2) {
                _downloadTextfield3.stringValue = info.title;
                [_downloadTextfield3 setHidden:NO];
                
                [_downloadProgress3 setHidden:NO];
            }
        }

        //Begin Download
        DoubanMusicInfo *downloadingInfo = [_toDownloadList objectAtIndex:0];
        
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:downloadingInfo.songUrl]];
        NSString *destPath = [@"/Users/Eric/Music/" stringByAppendingFormat:@"%@-%@.mp3",
                              downloadingInfo.title, downloadingInfo.artist];
        
        [request setDownloadDestinationPath:destPath];
        [request startSynchronous];
        
        [_downloadProgress1 setDoubleValue:100];
        sleep(0.5);
        [_toDownloadList removeObjectAtIndex:0];
    }
}

@end
