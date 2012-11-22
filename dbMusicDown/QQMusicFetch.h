//
//  QQMusicFetch.h
//  dbMusicDown
//
//  Created by Eric.C on 12-11-22.
//  Copyright (c) 2012年 Eric.C. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SynthesizeSingleton.h"

@interface QQMusicFetch : NSObject

- (NSString *)getUrlMusicName:(NSString *)name Artist:(NSString *)artist;

SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(QQMusicFetch);
@end
