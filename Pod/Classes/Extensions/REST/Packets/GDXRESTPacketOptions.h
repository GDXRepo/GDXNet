//
//  LXNetPacketOptions.h
//  Libertex
//
//  Created by Георгий Малюков on 19.05.15.
//  Copyright (c) 2015 Forex Club. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GDXRESTPacketOptions : NSObject {
    
}

@property (assign, nonatomic, getter=isCacheAllowed)    BOOL cacheAllowed;
@property (assign, nonatomic, getter=isSilent)          BOOL silent;
@property (assign, nonatomic, getter=isRepeatOnSuccess) BOOL repeatOnSuccess;
@property (assign, nonatomic, getter=isRepeatOnFailure) BOOL repeatOnFailure;
@property (assign, nonatomic) NSInteger timeout;

@end
