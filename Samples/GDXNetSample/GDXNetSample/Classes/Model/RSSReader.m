//
//  RSSReader.m
//  GDXNetSample
//
//  Created by Георгий Малюков on 01.11.15.
//  Copyright © 2015 Georgiy Malyukov. All rights reserved.
//

#import "RSSReader.h"
#import "GDXNet.h"
#import "PacketRSS.h"


@interface RSSReader () {
    
}

#pragma mark - Private

- (void)processResponse:(NSNotification *)notification;

@end


@implementation RSSReader


#pragma mark - Root

- (instancetype)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter]
         addObserver:self
         selector:@selector(processResponse:)
         name:kNotificationGDXNetAdapterDidReceiveResponse
         object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - Common

- (void)requestRSS {
    [[GDXNet instance] send:[PacketRSS new] userInfo:nil method:GDXNetSendMethodREST];
}


#pragma mark - Private

- (void)processResponse:(NSNotification *)notification {
    GDXNetContext *ctx = notification.userInfo[kNotificationKeyGDXNetContext];
    NSLog(@"Parsed context with packet inside: %@", ctx);
}

@end
