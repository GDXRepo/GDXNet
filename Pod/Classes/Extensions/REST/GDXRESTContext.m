//
//  LXNetContext.m
//  Libertex
//
//  Created by Георгий Малюков on 19.05.15.
//  Copyright (c) 2015 Forex Club. All rights reserved.
//

#import "GDXRESTContext.h"


@implementation GDXRESTContext


#pragma mark - Processing

- (void)processTask:(NSURLSessionDataTask *)task response:(id)responseObject error:(NSError *)error {
    _task = task;
    _responseObject = responseObject;
    _error = error;
    
    [(id<GDXRESTPacket>)self.packet parseResponse:self.responseObject error:self.error];
}


#pragma mark - GDXNetContext

- (Protocol *)acceptablePacketProtocol {
    return @protocol(GDXRESTPacket);
}

@end
