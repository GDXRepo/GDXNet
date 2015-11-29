//
//  GDXNetAdapter.h
//  GDXNetSample
//
//  Created by Георгий Малюков on 01.11.15.
//  Copyright © 2015 Georgiy Malyukov. All rights reserved.
//

#import "GDXNetContext.h"

// notifications
FOUNDATION_EXPORT NSString *const kNotificationGDXNetAdapterDidReceiveResponse;
FOUNDATION_EXPORT NSString *const kNotificationGDXNetAdapterDidFailRequest;
// notification keys
FOUNDATION_EXPORT NSString *const kNotificationKeyGDXNetContext;


@interface GDXNetAdapter : NSObject {
    NSMutableSet<GDXNetContext *> *contexts;
    
    dispatch_queue_t queueMain;
    dispatch_queue_t queueParsing;
}

@property (readonly, nonatomic) Protocol *acceptablePacketProtocol;


#pragma mark - Processing

- (NSString *)send:(GDXNetPacket *)packet userInfo:(NSDictionary *)userInfo;


#pragma mark - Contexts

- (GDXNetContext *)contextById:(NSString *)contextId;
- (void)cancelRequestByContextId:(NSString *)contextId;

@end
