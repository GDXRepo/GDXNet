//
//  LXNetPacket.h
//  Libertex
//
//  Created by Георгий Малюков on 18.05.15.
//  Copyright (c) 2015 Forex Club. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDXNetPacket.h"
#import "GDXRESTPacketOptions.h"

typedef NS_ENUM(NSInteger, GDXRESTPacketType) {
    GDXRESTPacketTypeGET,
    GDXRESTPacketTypePOST
};

typedef NS_ENUM(NSInteger, GDXRESTOperationType) {
    GDXRESTOperationTypeHTTP,
    GDXRESTOperationTypeJSON
};


@protocol GDXRESTPacket<NSObject>
@required

@property (readonly, nonatomic) NSString     *urlBase;
@property (readonly, nonatomic) NSString     *urlRelative;
@property (readonly, nonatomic) NSArray      *headers;
@property (readonly, nonatomic) NSDictionary *params;

@property (readonly, nonatomic) GDXRESTPacketType type;

@property (readonly, nonatomic) GDXRESTOperationType requestType;
@property (readonly, nonatomic) GDXRESTOperationType responseType;
@property (readonly, nonatomic) GDXRESTPacketOptions *options;


#pragma mark - Root

- (instancetype)initWithJSON:(id)json;


#pragma mark - Parse

- (void)parseResponse:(id)response error:(NSError *)error;

@end
