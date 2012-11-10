//
//  DownloadViewController.h
//  dbMusicDown
//
//  Created by Eric.C on 12-11-10.
//  Copyright (c) 2012年 Eric.C. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SongListViewController.h"

@interface DownloadViewController : NSViewController <DownloadViewDelegate>
@property (assign) IBOutlet NSTextField *downloadTextfield1;
@property (assign) IBOutlet NSTextField *downloadTextfield2;
@property (assign) IBOutlet NSTextField *downloadTextfield3;

@property (assign) IBOutlet NSProgressIndicator *downloadProgress1;
@property (assign) IBOutlet NSProgressIndicator *downloadProgress2;
@property (assign) IBOutlet NSProgressIndicator *downloadProgress3;

@end
