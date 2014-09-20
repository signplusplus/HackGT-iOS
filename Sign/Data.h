//
//  Data.h
//  Sign
//
//  Created by Andrew Thieck on 9/20/14.
//  Copyright (c) 2014 Andrew Thieck. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Data : NSObject

+ (Data *)defaultData;

- (void) sendMessage: (NSString *)string toNumber: (NSNumber *)number;

@end
