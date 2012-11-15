//
//  BannerViewController.m
//  dbMusicDown
//
//  Created by Eric.C on 12-11-14.
//  Copyright (c) 2012年 Eric.C. All rights reserved.
//

#import "BannerViewController.h"

@interface BannerViewController ()

@end

@implementation BannerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (IBAction)onlineReportClicked:(id)sender {
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"http://www.newdelete.com/blog/index.php/2012/11/the-watercress-hearts-music-download-tool/"]];
}
@end
