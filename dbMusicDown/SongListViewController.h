//
//  SongListViewController.h
//  dbMusicDown
//
//  Created by Eric.C on 12-11-10.
//  Copyright (c) 2012年 Eric.C. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol DownloadViewDelegate

@required -(void)downloadArray:(NSMutableArray *)array;

@end

@interface SongListViewController : NSViewController <NSTableViewDataSource, NSTableViewDelegate>

@property (assign) IBOutlet NSTableView *tableView;
@property (nonatomic, retain) id<DownloadViewDelegate> delegate;

- (IBAction)checkBoxClicked:(NSButton *)sender;
- (IBAction)downloadClicked:(NSButton *)sender;
@end
