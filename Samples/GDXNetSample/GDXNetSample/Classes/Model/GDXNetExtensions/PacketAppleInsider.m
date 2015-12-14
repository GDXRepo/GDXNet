//
//  PacketAppleInsider.m
//  GDXNetSample
//
//  Created by Георгий Малюков on 01.11.15.
//  Copyright © 2015 Georgiy Malyukov. All rights reserved.
//

#import "PacketAppleInsider.h"


@implementation PacketAppleInsider


#pragma mark - GDXRESTPacket

- (instancetype)initWithJSON:(id)json {
    return [super init];
}

- (void)parseResponse:(id)response error:(NSError *)error {
    // empty
}

- (NSString *)urlBase {
    return @"http://appleinsider.ru/";
}

- (NSDictionary *)headers {
    return @{};
}

- (NSString *)urlRelative {
    NSAssert(0, nil);
    return nil;
}

- (NSDictionary *)params {
    return @{};
}

- (void (^)(id<AFMultipartFormData> formData))bodyConstructionBlock {
    return nil;
}

- (GDXRESTPacketType)type {
    return GDXRESTPacketTypePOST;
}

- (GDXRESTPacketOptions *)options {
    GDXRESTPacketOptions *options = [GDXRESTPacketOptions new];
    options.cacheAllowed = NO;
    options.silent = NO;
    options.repeatOnSuccess = NO;
    options.repeatOnFailure = NO;
    options.timeout = 30;
    
    return options;
}

- (GDXRESTOperationType)requestType {
    return GDXRESTOperationTypeHTTP;
}

- (GDXRESTOperationType)responseType {
    return GDXRESTOperationTypeHTTP;
}

@end
