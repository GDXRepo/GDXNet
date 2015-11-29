//
//  GDXNetContext.m
//  GDXNetSample
//
//  Created by Георгий Малюков on 01.11.15.
//  Copyright © 2015 Georgiy Malyukov. All rights reserved.
//

#import "GDXNetContext.h"


@implementation GDXNetContext


#pragma mark - Root

- (instancetype)init {
    NSAssert(0, nil);
    return nil;
}

- (instancetype)initWithPacket:(GDXNetPacket *)packet userInfo:(NSDictionary *)userInfo {
    self = [super init];
    if (self) {
        NSAssert([packet conformsToProtocol:self.acceptablePacketProtocol], @"Invalid packet class.");
        
        _uid = [[NSUUID UUID] UUIDString];
        _packet = packet;
        _userInfo = userInfo;
    }
    return self;
}


#pragma mark - Properties

- (Protocol *)acceptablePacketProtocol {
    return @protocol(NSObject);
}

@end
