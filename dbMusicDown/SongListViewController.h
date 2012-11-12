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

- (IBAction)downloadClicked:(id)sender;

@end
