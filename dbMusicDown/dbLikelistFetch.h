//
//  dbLikelistFetch.h
//  dbMusicDown
//
//  Created by Eric.C on 12-11-8.
//  Copyright (c) 2012年 Eric.C. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SynthesizeSingleton.h"


@interface LoginInfo : NSObject
{
    NSString* email;
    NSString* token;
    NSString* user_id;
    NSString* user_name;
    NSString* expire;
}
@property(nonatomic, copy)  NSString* email;
@property(nonatomic, copy)  NSString* token;
@property(nonatomic, copy)  NSString* user_id;
@property(nonatomic, copy)  NSString* user_name;
@property(nonatomic, copy)  NSString* expire;
@end



@interface DoubanMusicInfo : NSObject
{
    NSString* aid;
    NSString* album;
    NSString* albumtitle;
    NSString* artist;
    NSString* company;
    NSString* length;
    NSString* like;
    NSString* pictureUrl;
    NSString* public_time;
    NSString* rating_avg;
    NSString* sid;
    NSString* ssid;
    NSString* subtype;
    NSString* title;
    NSString* songUrl;
}
@property(nonatomic, copy)  NSString* aid;
@property(nonatomic, copy)  NSString* album;
@property(nonatomic, copy)  NSString* albumtitle;
@property(nonatomic, copy)  NSString* artist;
@property(nonatomic, copy)  NSString* company;
@property(nonatomic, copy)  NSString* length;
@property(nonatomic, copy)  NSString* like;
@property(nonatomic, copy)  NSString* pictureUrl;
@property(nonatomic, copy)  NSString* public_time;
@property(nonatomic, copy)  NSString* rating_avg;
@property(nonatomic, copy)  NSString* sid;
@property(nonatomic, copy)  NSString* ssid;
@property(nonatomic, copy)  NSString* subtype;
@property(nonatomic, copy)  NSString* title;
@property(nonatomic, copy)  NSString* songUrl;

@end




@interface dbLikelistFetch : NSObject

@property (nonatomic, retain) LoginInfo *loginInfo;
@property (nonatomic, retain) NSMutableArray *songList;

- (NSError *)LoginWithUsername:(NSString *)userName Password:(NSString *)password;
- (NSError *)FetchLikeList;
- (void)clearAllInfo;

SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(dbLikelistFetch);
@end
