//
//  songlistTableviewController.h
//  dbMusicDown
//
//  Created by Eric.C on 12-11-9.
//  Copyright (c) 2012年 Eric.C. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "dbLikelistFetch.h"

@interface songlistTableviewController : NSViewController <NSTableViewDataSource, NSTableViewDelegate>

@property (assign) IBOutlet NSTableView *tableView;

@end
