//
//  SongListViewController.m
//  dbMusicDown
//
//  Created by Eric.C on 12-11-10.
//  Copyright (c) 2012年 Eric.C. All rights reserved.
//

#import "SongListViewController.h"
#import "SongInfoCellView.h"
#import "dbLikelistFetch.h"
@interface SongListViewController ()

@property (retain) NSMutableDictionary *downLoadingSongs;

@end

@implementation SongListViewController
@synthesize tableView = _tableView;
@synthesize downLoadingSongs = _downLoadingSongs;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
        _downLoadingSongs = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [dbLikelistFetch sharedInstance].songList.count;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    DoubanMusicInfo *musicInfo = [[dbLikelistFetch sharedInstance].songList objectAtIndex:row];
    SongInfoCellView *cellView = [tableView makeViewWithIdentifier:@"MainCell" owner:self];
    cellView.titleTextField.stringValue = musicInfo.title;
    cellView.artistTextField.stringValue = musicInfo.artist;
    cellView.albumTextField.stringValue = musicInfo.albumtitle;
  
    return cellView;
}

- (IBAction)downloadClicked:(id)sender {
    NSInteger row = [_tableView rowForView:sender];
    if (row != -1) {
        DoubanMusicInfo *musicInfo = [[dbLikelistFetch sharedInstance].songList objectAtIndex:row];
        NSURL *url = [NSURL URLWithString:musicInfo.songUrl];
        NSURLRequest* request = [NSURLRequest requestWithURL:url];
        NSURLDownload *download = [[NSURLDownload alloc] initWithRequest:request delegate:self];
        [_downLoadingSongs setValue:download forKey:[[NSNumber numberWithInteger:row] stringValue]];
    }
}

- (void)download:(NSURLDownload *)aDownload decideDestinationWithSuggestedFilename:(NSString *)filename
{
    NSArray *keyArray = [_downLoadingSongs allKeysForObject:aDownload];
    if (keyArray.count == 1) {
        NSString *indexString = [keyArray objectAtIndex:0];
        DoubanMusicInfo *musicInfo = [[dbLikelistFetch sharedInstance].songList objectAtIndex:[indexString integerValue]];
        NSString *fileName = [NSString stringWithFormat:@"%@-%@.mp3",
                              musicInfo.title, musicInfo.artist];
        NSString* path = [[@"~/Music/" stringByExpandingTildeInPath] stringByAppendingPathComponent:fileName];
        
        [aDownload setDestination:path allowOverwrite:YES];
        
        return;
    }
    NSLog(@"error");
}

- (void)download:(NSURLDownload *)aDownload didReceiveResponse:(NSURLResponse *)response;
{
    long long expectedContentLength = [response expectedContentLength];
    if (expectedContentLength > 0.0) {
        NSArray *keyArray = [_downLoadingSongs allKeysForObject:aDownload];
        if (keyArray.count == 1) {
            NSString *indexString = [keyArray objectAtIndex:0];
            SongInfoCellView *cellView = [_tableView viewAtColumn:0 row:[indexString integerValue] makeIfNecessary:YES];
            [cellView.downloadProgress setMinValue:0];
            [cellView.downloadProgress setMaxValue:expectedContentLength];
            [cellView.downloadProgress setDoubleValue:100];
            [cellView.downloadProgress setHidden:NO];
            return;
        }
    }
    NSLog(@"error");
}

- (void)download:(NSURLDownload *)aDownload didReceiveDataOfLength:(NSUInteger)length
{
    NSArray *keyArray = [_downLoadingSongs allKeysForObject:aDownload];
    if (keyArray.count == 1) {
        NSString *indexString = [keyArray objectAtIndex:0];
        SongInfoCellView *cellView = [_tableView viewAtColumn:0 row:[indexString integerValue] makeIfNecessary:YES];
        [cellView.downloadProgress incrementBy:length];
        
        return;
    }
    NSLog(@"error");
}

- (void)downloadDidFinish:(NSURLDownload *)aDownload
{
    NSArray *keyArray = [_downLoadingSongs allKeysForObject:aDownload];
    if (keyArray.count == 1) {
        [aDownload cancel];
        [aDownload release];
        NSString *indexString = [keyArray objectAtIndex:0];
        [_downLoadingSongs removeObjectForKey:indexString];
        return;
    }
    NSLog(@"error");
}

- (void)download:(NSURLDownload *)download didFailWithError:(NSError *)error
{
}
@end
