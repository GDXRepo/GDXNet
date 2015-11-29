//
//  PacketRSS.m
//  GDXNetSample
//
//  Created by Георгий Малюков on 01.11.15.
//  Copyright © 2015 Georgiy Malyukov. All rights reserved.
//

#import "PacketRSS.h"


@implementation PacketRSS


#pragma mark - PacketAppleInsider

- (void)parseResponse:(id)response error:(NSError *)error {
    NSLog(@"RSS received and ready to parse in the 'PacketRSS' class: %@", response);
}

- (NSString *)urlRelative {
    return @"rss";
}

@end
