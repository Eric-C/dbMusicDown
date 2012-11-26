//
//  QQMusicFetch.m
//  dbMusicDown
//
//  Created by Eric.C on 12-11-22.
//  Copyright (c) 2012年 Eric.C. All rights reserved.
//

#import "QQMusicFetch.h"
#import "ASIHTTPRequest.h"
#import "SBJson.h"

/*
"http://shopcgi.qqmusic.qq.com/fcgi-bin/shopsearch.fcg?value=歌曲名&artist=歌手名&type=qry_song&out=json&page_no=页码&page_record_num=单页记录数量"
 */
#define kBaseSearchUrl   @"http://shopcgi.qqmusic.qq.com/fcgi-bin/shopsearch.fcg?"

@implementation QQMusicFetch

SYNTHESIZE_SINGLETON_FOR_CLASS(QQMusicFetch);

- (NSString *)getUrlMusicName:(NSString *)name Artist:(NSString *)artist
{
    NSString *searchString = [kBaseSearchUrl stringByAppendingFormat:@"type=qry_song&out=json&page_no=1&page_record_num=3", name, artist];
    //if (name) {
        searchString = [searchString stringByAppendingFormat:@"&value=%@", name];
    //}
    //if (artist) {
        searchString = [searchString stringByAppendingFormat:@"&artist=%@", artist];
    //}
   // NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
   // NSString *retStr = [[NSString alloc] initWithData:data encoding:enc];
   // NSURL* searchUrl = [NSURL URLWithString:[searchString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSURL *url = [NSURL URLWithString:[searchString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *retStr = [[NSString alloc] initWithData:data encoding:enc];
    NSURL* searchUrl = [NSURL URLWithString:retStr];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:searchUrl];
    [request startSynchronous];
    NSError *error = [request error];
    NSString *returnString = nil;
    if (!error) {
        NSString *searchResponse = [request responseString];
        NSString *stringforParse = [searchResponse substringWithRange:NSMakeRange(15, searchResponse.length - 17)];
        
        stringforParse = [stringforParse stringByReplacingOccurrencesOfString:@"result:" withString:@"\"result\":"];
        stringforParse = [stringforParse stringByReplacingOccurrencesOfString:@"msg:" withString:@"\"msg\":"];
        stringforParse = [stringforParse stringByReplacingOccurrencesOfString:@"totalnum:" withString:@"\"totalnum\":"];
        stringforParse = [stringforParse stringByReplacingOccurrencesOfString:@"curnum:" withString:@"\"curnum\":"];
        stringforParse = [stringforParse stringByReplacingOccurrencesOfString:@"search:" withString:@"\"search\":"];
        stringforParse = [stringforParse stringByReplacingOccurrencesOfString:@"songlist:" withString:@"\"songlist\":"];
        stringforParse = [stringforParse stringByReplacingOccurrencesOfString:@"idx:" withString:@"\"idx\":"];
        stringforParse = [stringforParse stringByReplacingOccurrencesOfString:@"song_id:" withString:@"\"song_id\":"];
        stringforParse = [stringforParse stringByReplacingOccurrencesOfString:@"song_name:" withString:@"\"song_name\":"];
        stringforParse = [stringforParse stringByReplacingOccurrencesOfString:@"album_name:" withString:@"\"album_name\":"];
        stringforParse = [stringforParse stringByReplacingOccurrencesOfString:@"singer_name:" withString:@"\"singer_name\":"];
        stringforParse = [stringforParse stringByReplacingOccurrencesOfString:@"location:" withString:@"\"location\":"];
        stringforParse = [stringforParse stringByReplacingOccurrencesOfString:@"singer_id:" withString:@"\"singer_id\":"];
        stringforParse = [stringforParse stringByReplacingOccurrencesOfString:@"album_id:" withString:@"\"album_id\":"];
        stringforParse = [stringforParse stringByReplacingOccurrencesOfString:@"price:" withString:@"\"price\":"];
        
        SBJsonParser* sjonParser = [[SBJsonParser alloc] init];
        NSMutableDictionary *responseDic = [sjonParser objectWithString:stringforParse error:nil];

        NSArray *songList = [responseDic objectForKey:@"songlist"];
        
        for (NSInteger i = 0; i < [songList count]; ++i) {
            NSDictionary *firstSong = [songList objectAtIndex:i];
            
            NSString *location = [firstSong objectForKey:@"location"];
            NSString *songID = [firstSong objectForKey:@"song_id"];
            if (songID.length < 7) {
                continue;
            }
            if ([location integerValue] >= 10) {
                continue;
            }
            
            returnString = [NSString stringWithFormat:@"http://stream1%ld.qqmusic.qq.com/3%@.mp3", [location integerValue], songID];
            break;
        }
        [sjonParser release];
    }
    
    return returnString;
}

@end
