//
//  GDXNetAdapter.m
//  GDXNetSample
//
//  Created by Георгий Малюков on 01.11.15.
//  Copyright © 2015 Georgiy Malyukov. All rights reserved.
//

#import "GDXNetAdapter.h"
#import "GDXNetContext+Protected.h"

// notifications
NSString *const kNotificationGDXNetAdapterDidReceiveResponse = @"GDXNetAdapterDidReceiveResponse";
NSString *const kNotificationGDXNetAdapterDidFailRequest = @"GDXNetAdapterDidFailRequest";
// notification key
NSString *const kNotificationKeyGDXNetContext = @"GDXNetContext";


@interface GDXNetAdapter () {
    
}

@end


@implementation GDXNetAdapter


#pragma mark - Root

- (instancetype)init {
    self = [super init];
    if (self) {
        contexts = [NSMutableSet new];
        queueMain = dispatch_get_main_queue();
        queueParsing = dispatch_queue_create("GDXNet.Adapter.parse", 0);
    }
    return self;
}


#pragma mark - Processing

- (NSString *)send:(GDXNetPacket *)packet userInfo:(NSDictionary *)userInfo {
    NSAssert([packet conformsToProtocol:self.acceptablePacketProtocol], @"Invalid packet class.");
    
    return nil;
}


#pragma mark - Contexts

- (GDXNetContext *)contextById:(NSString *)contextId {
    for (GDXNetContext *ctx in contexts) {
        if ([ctx.uid isEqualToString:contextId]) {
            return ctx;
        }
    }
    return nil;
}

- (void)cancelRequestByContextId:(NSString *)contextId {
    GDXNetContext *ctx = [self contextById:contextId];
    // set isCancelled flag (don't remove it from the contexts storage!)
    ctx.isCancelled = YES;
}


#pragma mark - Properties

- (Protocol *)acceptablePacketProtocol {
    return @protocol(NSObject);
}

@end
