//
//  GDXPacket.m
//  GDXNetSample
//
//  Created by Георгий Малюков on 01.11.15.
//  Copyright © 2015 Georgiy Malyukov. All rights reserved.
//

#import "GDXNetPacket.h"


@implementation GDXNetPacket


#pragma mark - Root

- (instancetype)init {
    self = [super init];
    if (self) {
        _uid = [[NSUUID UUID] UUIDString];
    }
    return self;
}

@end
