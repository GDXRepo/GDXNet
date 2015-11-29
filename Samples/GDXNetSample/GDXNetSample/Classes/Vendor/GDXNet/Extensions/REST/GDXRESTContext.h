//
//  LXNetContext.h
//
//  Created by Георгий Малюков on 19.05.15.
//  Copyright © 2015 Georgiy Malyukov. All rights reserved.
//

#import "GDXNetContext.h"
#import "GDXRESTPacket.h"


@interface GDXRESTContext : GDXNetContext {
    
}

@property (readonly, nonatomic) NSURLSessionDataTask *task;
@property (readonly, nonatomic) id responseObject;

@property (copy, nonatomic) NSError *error;


#pragma mark - Processing

- (void)processTask:(NSURLSessionDataTask *)task response:(id)responseObject error:(NSError *)error;

@end
