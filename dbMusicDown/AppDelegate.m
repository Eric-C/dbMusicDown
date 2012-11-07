//
//  AppDelegate.m
//  dbMusicDown
//
//  Created by Eric.C on 12-11-5.
//  Copyright (c) 2012年 Eric.C. All rights reserved.
//

#import "AppDelegate.h"
#import "ASIHTTPRequest.h"
#import "SBJson.h"

#define kBaseUrl @"http://www.douban.com/j/app/login"
/*
"email=<你的邮箱>&password=<你的密码>&app_name=radio_android&version=606&client=s%3Amobile%7Cy%3Aandroid+2.3.5%7Cf%3A606%7Cm%3ADouban%7Cd%3A-1629744272%7Ce%3Ahkcsl_cht_htc_desire_s ";
 */

@interface NSString (ParseCategory)
- (NSMutableDictionary *)explodeToDictionaryInnerGlue:(NSString *)innerGlue
                                           outterGlue:(NSString *)outterGlue;
@end

@implementation NSString (ParseCategory)

- (NSMutableDictionary *)explodeToDictionaryInnerGlue:(NSString *)innerGlue
                                           outterGlue:(NSString *)outterGlue {
    // Explode based on outter glue
    NSArray *firstExplode = [self componentsSeparatedByString:outterGlue];
    NSArray *secondExplode;
    
    // Explode based on inner glue
    NSInteger count = [firstExplode count];
    NSMutableDictionary* returnDictionary = [NSMutableDictionary dictionaryWithCapacity:count];
    for (NSInteger i = 0; i < count; i++) {
        secondExplode =
        [(NSString*)[firstExplode objectAtIndex:i] componentsSeparatedByString:innerGlue];
        if ([secondExplode count] == 2) {
            [returnDictionary setObject:[secondExplode objectAtIndex:1]
                                 forKey:[secondExplode objectAtIndex:0]];
        }
    }
    return returnDictionary;
}

@end

@implementation AppDelegate

- (void)dealloc
{
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

- (IBAction)getSonglist:(NSButton *)sender {
    NSString* appendUrl = kBaseUrl;
    
   // appendUrl = [appendUrl stringByAppendingString:@"email=mr.cyclopedia@gmail.com&password=2395320&app_name=radio_desktop_win&version=100"];
    appendUrl = [appendUrl stringByAppendingFormat:@"?email=%@&password=%@&app_name=%@&version=%@", @"mr.cyclopedia@gmail.com", @"2395320", @"radio_desktop_win", @"100"];
    NSURL *url = [NSURL URLWithString:appendUrl];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        NSString *response = [request responseString];
        NSLog(response);
        
        SBJsonParser* sjonParser = [[SBJsonParser alloc] init];
        NSMutableDictionary *dic = [sjonParser objectWithString:response error:nil];
        
        NSString *token = [dic objectForKey:@"token"];
        NSString *user_id = [dic objectForKey:@"user_id"];
        NSString *expire = [dic objectForKey:@"expire"];
        
        /*
         URL: http://www.douban.com/j/app/radio/liked_songs?exclude=675558|12384|642358|546734|10761|761079|1394944|546727|676245|431315&version=608&client=s:mobile|y:android+4.1.1|f:608|m:Google|d:-1178839463|e:google_galaxy_nexus&app_name=radio_android&from=android_608_Google&formats=aac&count=COUNT&token=TOKEN&user_id=USER_ID&expire=EXPIRE
         */
        
        NSString* likeString = [NSString stringWithFormat:@"http://www.douban.com/j/app/radio/liked_songs?version=100&&app_name=radio_desktop_win&formats=aac&count=20&token=%@&user_id=%@&expire=%@", token, user_id, expire];
        
        NSURL *likeUrl = [NSURL URLWithString:likeString];
        
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:likeUrl];
        [request startSynchronous];
        NSError *error = [request error];
        
        NSString *list = [request responseString];
        NSLog(list);
        
        NSMutableDictionary *dic2 = [sjonParser objectWithString:list error:nil];
        NSLog(dic2);
        
        list = [dic2 objectForKey:@"songs"];
    }

}
@end
