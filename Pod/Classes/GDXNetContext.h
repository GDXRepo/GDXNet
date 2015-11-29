//
//  GDXNetContext.h
//  GDXNetSample
//
//  Created by Георгий Малюков on 01.11.15.
//  Copyright © 2015 Georgiy Malyukov. All rights reserved.
//

#import "GDXNetPacket.h"


@interface GDXNetContext : NSObject {
    
}

@property (readonly, nonatomic) NSString *uid;
@property (readonly, nonatomic) Protocol *acceptablePacketProtocol;
@property (readonly, nonatomic) BOOL     isCancelled;

@property (readonly, nonatomic) GDXNetPacket *packet;
@property (readonly, nonatomic) NSDictionary *userInfo;


#pragma mark - Root

- (instancetype)initWithPacket:(GDXNetPacket *)packet userInfo:(NSDictionary *)userInfo;

@end
