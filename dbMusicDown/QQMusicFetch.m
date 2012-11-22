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
    NSString *searchString = [kBaseSearchUrl stringByAppendingFormat:@"value=%@&artist=%@&type=qry_song&out=json&page_no=1&page_record_num=3", name, artist];
    
    NSURL* searchUrl = [NSURL URLWithString:[searchString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:searchUrl];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        NSString *loginResponse = [request responseString];
        NSString *stringforParse = [loginResponse substringWithRange:NSMakeRange(15, loginResponse.length - 17)];
        
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
/*
        NSString* songListString = [[responseDic objectForKey:@"songs"] JSONRepresentation];
        NSArray* songList = [sjonParser objectWithString:songListString error:nil];
        
        if (_songList == NULL) {
            _songList = [[NSMutableArray alloc] init];
        }
        else{
            [_songList removeAllObjects];
        }
        
        for (NSInteger i = 0; i < songList.count; i++) {
            NSString* theSong = [[songList objectAtIndex:i] JSONRepresentation];
            NSDictionary *songInfoDic = [sjonParser objectWithString:theSong error:nil];
            
            DoubanMusicInfo *theSongInfo = [[DoubanMusicInfo alloc] init];
            theSongInfo.aid = [songInfoDic objectForKey:@"aid"];
            theSongInfo.album = [songInfoDic objectForKey:@"album"];
            theSongInfo.albumtitle = [[songInfoDic objectForKey:@"albumtitle"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            theSongInfo.artist = [[songInfoDic objectForKey:@"artist"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            theSongInfo.company = [[songInfoDic objectForKey:@"company"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            theSongInfo.length = [[songInfoDic objectForKey:@"length"] stringValue];
            theSongInfo.like = [[songInfoDic objectForKey:@"like"] stringValue];
            theSongInfo.pictureUrl = [songInfoDic objectForKey:@"picture"];
            theSongInfo.public_time = [songInfoDic objectForKey:@"public_time"];
            theSongInfo.rating_avg = [[songInfoDic objectForKey:@"rating_avg"] stringValue];
            theSongInfo.sid = [songInfoDic objectForKey:@"sid"];
            theSongInfo.ssid = [songInfoDic objectForKey:@"ssid"];
            theSongInfo.title = [[songInfoDic objectForKey:@"title"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            theSongInfo.songUrl = [songInfoDic objectForKey:@"url"];
            
            [_songList addObject:theSongInfo];
        }
*/
        
        [sjonParser release];
    }

    
}

@end
