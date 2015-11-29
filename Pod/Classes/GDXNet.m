//
//  GDXNet.m
//  GDXNetSample
//
//  Created by Георгий Малюков on 01.11.15.
//  Copyright © 2015 Georgiy Malyukov. All rights reserved.
//

#import "GDXNet.h"


@interface GDXNet () {
    
}

@property (readonly, nonatomic) NSArray<GDXNetAdapter *> *adapters;

@end


@implementation GDXNet


#pragma mark - Root

- (instancetype)init {
    NSAssert(0, @"Forbidden initializer. Use 'instance' instead.");
    return nil;
}

- (instancetype)initPrivate {
    self = [super init];
    if (self) {
        _adapters = @[[GDXRESTAdapter new]];
    }
    return self;
}

+ (instancetype)instance {
    static GDXNet *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self.class alloc] initPrivate];
    });
    return instance;
}


#pragma mark - Common

- (NSDictionary *)send:(GDXNetPacket *)packet userInfo:(NSDictionary *)userInfo method:(GDXNetSendMethod)method {
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    
    for (NSInteger i = 0; i < self.adapters.count; i++) {
        GDXNetSendMethod methodItem = (GDXNetSendMethod)(i + 1);
        
        if (method & methodItem) {
            if ([packet conformsToProtocol:self.adapters[i].acceptablePacketProtocol]) {
                dictionary[@(methodItem)] = [self.adapters[i] send:packet userInfo:userInfo];
            }
        }
    }
    if (dictionary.allKeys.count == 0) {
        NSAssert(0, @"Unable to send packet. Please check method and your packet's protocols conformance.");
    }
    return dictionary;
}

- (void)cancelRequestByContextId:(NSString *)contextId {
    for (GDXNetAdapter *adapter in self.adapters) {
        [adapter cancelRequestByContextId:contextId];
    }
}

@end
