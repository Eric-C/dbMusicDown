//
//  dbLikelistFetch.m
//  dbMusicDown
//
//  Created by Eric.C on 12-11-8.
//  Copyright (c) 2012年 Eric.C. All rights reserved.
//

#import "dbLikelistFetch.h"
#import "ASIHTTPRequest.h"
#import "SBJson.h"

#define kBaseLoginUrl   @"http://www.douban.com/j/app/login"
#define kBaseLikeUrl    @"http://www.douban.com/j/app/radio/liked_songs"

@implementation LoginInfo
@synthesize email,token,user_id,user_name,expire;
@end

@implementation DoubanMusicInfo
@synthesize aid,albumtitle,album,artist,company,length,like,pictureUrl,public_time,rating_avg,sid,ssid,subtype,title,songUrl;
@end

@implementation dbLikelistFetch
@synthesize loginInfo = _loginInfo;
@synthesize songList = _songList;

- (void)dealloc
{
    [super dealloc];
    [_loginInfo release];
    [_songList release];
}

- (NSError *)LoginWithUsername:(NSString *)userName Password:(NSString *)password
{
    NSString* loginString = [kBaseLoginUrl stringByAppendingFormat:@"?email=%@&password=%@&app_name=%@&version=%@", userName, password, @"radio_desktop_win", @"100"];
    NSURL* loginUrl = [NSURL URLWithString:loginString];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:loginUrl];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        NSString *loginResponse = [request responseString];
        
        SBJsonParser* sjonParser = [[SBJsonParser alloc] init];
        NSMutableDictionary *responseDic = [sjonParser objectWithString:loginResponse error:nil];
 
        if (_loginInfo == NULL) {
            _loginInfo = [[LoginInfo alloc] init];
        }
        
        _loginInfo.email = [responseDic objectForKey:@"email"];
        _loginInfo.token = [responseDic objectForKey:@"token"];
        _loginInfo.user_id = [responseDic objectForKey:@"user_id"];
        _loginInfo.user_name = [responseDic objectForKey:@"user_name"];
        _loginInfo.expire = [responseDic objectForKey:@"expire"];
        
        [sjonParser release];
    }

    return error;
}

- (NSError *)FetchLikeList
{
    NSString* likeString = [kBaseLikeUrl stringByAppendingFormat:@"?version=100&&app_name=radio_desktop_win&count=2000&token=%@&user_id=%@&expire=%@", _loginInfo.token, _loginInfo.user_id, _loginInfo.expire];
    
    NSURL* likeUrl = [NSURL URLWithString:likeString];
    
    ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:likeUrl];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        NSString* likeResponse = [request responseString];
        
        SBJsonParser* sjonParser = [[SBJsonParser alloc] init];
        NSDictionary* responseDic = [sjonParser objectWithString:likeResponse error:nil];
        
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
        
        [sjonParser release];
    }
    
    return error;
}

@end
