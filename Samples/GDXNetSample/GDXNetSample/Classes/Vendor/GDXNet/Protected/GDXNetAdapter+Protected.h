//
//  GDXNetAdapter+Protected.h
//  GDXNetSample
//
//  Created by Георгий Малюков on 01.11.15.
//  Copyright © 2015 Georgiy Malyukov. All rights reserved.
//

#import "GDXNetAdapter.h"


@interface GDXNetAdapter (Protected)


#pragma mark - Processing

- (void)processContextSuccess:(GDXNetContext *)context;
- (void)processContextFailure:(GDXNetContext *)context;


#pragma mark - Contexts

- (void)addContext:(GDXNetContext *)context;
- (BOOL)canProcessContextId:(NSString *)contextId;

@end
