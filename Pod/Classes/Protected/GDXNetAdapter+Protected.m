//
//  GDXNetAdapter+Protected.m
//  GDXNetSample
//
//  Created by Георгий Малюков on 01.11.15.
//  Copyright © 2015 Georgiy Malyukov. All rights reserved.
//

#import "GDXNetAdapter+Protected.h"


@implementation GDXNetAdapter (Protected)


#pragma mark - Processing

- (void)processContextSuccess:(GDXNetContext *)ctx {
    if (![self canProcessContextId:ctx.uid]) {
        return;
    }
    [contexts removeObject:ctx];
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:kNotificationGDXNetAdapterDidReceiveResponse
     object:self
     userInfo:@{kNotificationKeyGDXNetContext : ctx}];
}

- (void)processContextFailure:(GDXNetContext *)ctx {
    if (![self canProcessContextId:ctx.uid]) {
        return;
    }
    [contexts removeObject:ctx];
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:kNotificationGDXNetAdapterDidFailRequest
     object:self
     userInfo:@{kNotificationKeyGDXNetContext : ctx}];
}


#pragma mark - Contexts

- (void)addContext:(GDXNetContext *)context {
    if (![self contextById:context.uid]) {
        [contexts addObject:context];
    }
}

- (BOOL)canProcessContextId:(NSString *)contextId {
    return ([self contextById:contextId] != nil);
}

@end
