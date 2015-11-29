//
//  LXProxyNet.m
//  Libertex
//
//  Created by Георгий Малюков on 07.09.15.
//  Copyright (c) 2015 Forex Club. All rights reserved.
//

#import "GDXRESTAdapter.h"
#import "GDXNetAdapter+Protected.h"
#import "AFHTTPSessionManager.h"


@implementation GDXRESTAdapter


#pragma mark - GDXNetAdapter

- (NSString *)send:(GDXNetPacket *)packet userInfo:(NSDictionary *)userInfo {
    [super send:packet userInfo:userInfo];
    // configure context
    id<GDXRESTPacket> pack = (id<GDXRESTPacket>)packet;
    __block GDXRESTContext *ctx = [[GDXRESTContext alloc] initWithPacket:pack userInfo:userInfo];
    // save context
    [self addContext:ctx];
    // create manager
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]
                                     initWithBaseURL:[NSURL URLWithString:pack.urlBase]];
    // select request type
    switch (pack.requestType) {
        case GDXRESTOperationTypeHTTP: {
            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
            break;
        }
        case GDXRESTOperationTypeJSON: {
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            break;
        }
    }
    // select response type
    switch (pack.responseType) {
        case GDXRESTOperationTypeHTTP: {
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            break;
        }
        case GDXRESTOperationTypeJSON: {
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            break;
        }
    }
    // acceptance block
    __weak __typeof(self) weakSelf = self;
    
    void (^accept)(NSURLSessionDataTask *task, id responseObject, NSError *error) = ^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
        __strong __typeof(self) strongSelf = weakSelf;
        
        if (ctx.isCancelled) { // cancelled request
            // assign error only, it may be useful if exists
            ctx.error = error;
            // process as failed request
            [strongSelf processContextFailure:ctx];
        }
        else if (task && responseObject && !error) { // success
            dispatch_async(queueParsing, ^{
                // process response
                [ctx processTask:task response:responseObject error:nil];
                
                dispatch_sync(queueMain, ^{
                    [strongSelf processContextSuccess:ctx];
                });
            });
        }
        else if (task && !responseObject && error) { // failure
            dispatch_async(queueParsing, ^{
                // process response
                [ctx processTask:task response:nil error:error];
                    
                dispatch_sync(queueMain, ^{
                    [strongSelf processContextFailure:ctx];
                });
            });
        }
        else {
            NSAssert(0, @"Potentially invalid network operation.");
        }
    };
    // switch operation type & send request
    switch (pack.type) {
        case GDXRESTPacketTypeGET: {
            [manager GET:pack.urlRelative
              parameters:pack.params
                 success:^(NSURLSessionDataTask *task, id response) {
                     accept(task, response, nil);
                 }
                 failure:^(NSURLSessionDataTask *task, NSError *error) {
                     accept(task, nil, error);
                 }];
            break;
        }
        case GDXRESTPacketTypePOST: {
            [manager POST:pack.urlRelative
               parameters:pack.params
                  success:^(NSURLSessionDataTask *task, id response) {
                      accept(task, response, nil);
                  }
                  failure:^(NSURLSessionDataTask *task, NSError *error) {
                      accept(task, nil, error);
                  }];
            break;
        }
    }
    return ctx.uid;
}


#pragma mark - GDXNetAdapter

- (Protocol *)acceptablePacketProtocol {
    return @protocol(GDXRESTPacket);
}

@end
