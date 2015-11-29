//
//  AppDelegate.m
//  GDXNetSample
//
//  Created by Георгий Малюков on 01.11.15.
//  Copyright © 2015 Georgiy Malyukov. All rights reserved.
//

#import "AppDelegate.h"
#import "RSSReader.h"

@interface AppDelegate ()

@property (strong, nonatomic) RSSReader *reader;

@end


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.reader = [RSSReader new];
    [self.reader requestRSS];
    
    return YES;
}

@end
