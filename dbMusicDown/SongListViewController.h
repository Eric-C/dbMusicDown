//
//  SongListViewController.h
//  dbMusicDown
//
//  Created by Eric.C on 12-11-10.
//  Copyright (c) 2012年 Eric.C. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SongListViewController : NSViewController <NSTableViewDataSource, NSURLDownloadDelegate>

@property (assign) IBOutlet NSTableView *tableView;
@property (retain) NSMutableDictionary *downLoadingSongs;

- (IBAction)downloadClicked:(id)sender;
- (IBAction)openFolderClicked:(id)sender;
- (void)downloadAll;

@end
