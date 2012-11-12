//
//  SongInfoCellView.h
//  dbMusicDown
//
//  Created by Eric.C on 12-11-12.
//  Copyright (c) 2012年 Eric.C. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SongInfoCellView : NSTableCellView

@property(assign) IBOutlet NSImageView *albumImageView;
@property(assign) IBOutlet NSTextField *titleTextField;
@property(assign) IBOutlet NSTextField *artistTextField;
@property(assign) IBOutlet NSTextField *albumTextField;
@property(assign) IBOutlet NSButton    *downloadButton;
@property(assign) IBOutlet NSProgressIndicator *downloadProgress;

@end
