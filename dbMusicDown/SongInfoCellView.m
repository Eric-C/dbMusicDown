//
//  SongInfoCellView.m
//  dbMusicDown
//
//  Created by Eric.C on 12-11-12.
//  Copyright (c) 2012年 Eric.C. All rights reserved.
//

#import "SongInfoCellView.h"

@implementation SongInfoCellView
@synthesize albumImageView = _albumImageView;
@synthesize titleTextField = _titleTextField;
@synthesize artistTextField = _artistTextField;
@synthesize albumTextField = _albumTextField;
@synthesize downloadButton = _downloadButton;
@synthesize openFolderButton = _openFolderButton;
@synthesize downloadProgress = _downloadProgress;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    // Drawing code here.
}

@end
