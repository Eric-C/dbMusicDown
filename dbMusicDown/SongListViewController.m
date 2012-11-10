//
//  SongListViewController.m
//  dbMusicDown
//
//  Created by Eric.C on 12-11-10.
//  Copyright (c) 2012年 Eric.C. All rights reserved.
//

#import "SongListViewController.h"
#import "dbLikelistFetch.h"
@interface SongListViewController ()

@property(retain) NSMutableArray *needDownloadArray;

@end

@implementation SongListViewController
@synthesize tableView = _tableView;
@synthesize needDownloadArray = _needDownloadArray;
@synthesize delegate = _delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
        _needDownloadArray = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [dbLikelistFetch sharedInstance].songList.count;
}


- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    NSString *identifier = [tableColumn identifier];
    DoubanMusicInfo* info = [[dbLikelistFetch sharedInstance].songList objectAtIndex:row];
    
    if ([identifier isEqualToString:@"TitleCell"]) {
        return info.title;
    }
    else if ([identifier isEqualToString:@"ArtistCell"])
    {
        return info.artist;
    }
    else if ([identifier isEqualToString:@"AlbumCell"])
    {
        return info.albumtitle;
    }
    else if ([identifier isEqualToString:@"DownloadCell"])
    {
        unsigned index = (unsigned)CFArrayBSearchValues((CFArrayRef)_needDownloadArray,
                                                        CFRangeMake(0, _needDownloadArray.count),
                                                        [NSNumber numberWithInteger:row],
                                                        (CFComparatorFunction)CFNumberCompare,
                                                        NULL);
        
        if (index < _needDownloadArray.count) {
            return [NSNumber numberWithBool:YES];
        
        } else {
            return [NSNumber numberWithBool:NO];
        }
        
    }
    
    return nil;
}

- (void)tableView:(NSTableView *)tableView setObjectValue:(id)anObject forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    unsigned index = (unsigned)CFArrayBSearchValues((CFArrayRef)_needDownloadArray,
                                                    CFRangeMake(0, _needDownloadArray.count),
                                                    [NSNumber numberWithInteger:row],
                                                    (CFComparatorFunction)CFNumberCompare,
                                                    NULL);
    
    if (index < _needDownloadArray.count) {
        [_needDownloadArray removeObjectAtIndex:index];
    } else {
        [_needDownloadArray addObject:[NSNumber numberWithInteger:row]];
    }
}

- (IBAction)checkBoxClicked:(NSButton *)sender {
    NSNumber *check = [sender objectValue];
    
    if ([check isEqualToNumber:[NSNumber numberWithBool:NO]]) {
        [_needDownloadArray removeAllObjects];
    } else {
        for (NSInteger i = 0; i < [dbLikelistFetch sharedInstance].songList.count; i++) {
            [_needDownloadArray addObject:[NSNumber numberWithInteger:i]];
        }
    }
    
    [_tableView reloadData];
}

- (IBAction)downloadClicked:(NSButton *)sender {
    [_delegate downloadArray:_needDownloadArray];
}
@end
