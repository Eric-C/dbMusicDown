//
//  songlistTableviewController.m
//  dbMusicDown
//
//  Created by Eric.C on 12-11-9.
//  Copyright (c) 2012年 Eric.C. All rights reserved.
//

#import "songlistTableviewController.h"

@interface songlistTableviewController ()

@end

@implementation songlistTableviewController
@synthesize tableView = _tableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
        //[[ LoginWithUsername:@"ruhan@douban.com" Password:@"ruhan"];
        //[_likeListFetch LoginWithUsername:@"mr.cyclopedia@gmail.com" Password:@"2395320"];
        //[_likeListFetch FetchLikeList];
    }
    
    return self;
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
   // return [_likeListFetch.songList count];
}

// This method is optional if you use bindings to provide the data
- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    NSString *identifier = [tableColumn identifier];
    DoubanMusicInfo* info = [[dbLikelistFetch sharedInstance].songList objectAtIndex:row];
    
    if ([identifier isEqualToString:@"TitleCell"]) {
        NSTableCellView *cellView = [_tableView makeViewWithIdentifier:identifier owner:self];
        cellView.textField.stringValue = info.title;
        return cellView;
    }
    else if ([identifier isEqualToString:@"ArtistCell"])
    {
        NSTableCellView *cellView = [tableView makeViewWithIdentifier:identifier owner:self];
        cellView.textField.stringValue = info.artist;
        return cellView;
    }
    else if ([identifier isEqualToString:@"AlbumCell"])
    {
        NSTableCellView *cellView = [tableView makeViewWithIdentifier:identifier owner:self];
        cellView.textField.stringValue = info.albumtitle;
        return cellView;
    }
    
    return nil;
}

@end
