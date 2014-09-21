//
//  Data.m
//  Sign
//
//  Created by Andrew Thieck on 9/20/14.
//  Copyright (c) 2014 Andrew Thieck. All rights reserved.
//

#import "Data.h"
#import "UNIRest.h"
#define successNotification		@"successNotification"
#define failNotification		@"failNotification"

@implementation Data

static Data *instance = nil;
static NSString *signPlusPlusURL = @"http://signplusplustwilio.azurewebsites.net";

+ (Data *)defaultData {
    if(instance == nil)
        instance = [[Data alloc] init];
    return instance;
}

- (void) sendMessage: (NSString *)string toNumber: (NSString *)string2 {
    NSDictionary *dictionary = @{@"message":string, @"number": string2};
    NSData *postData = [self encodeDictionary:dictionary];
    
    NSURL *url = [NSURL URLWithString:@"www.signplusplus.com/simple.php"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)postData.length] forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSLog(@"sending data %@", dictionary);
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
    
}

- (NSData*)encodeDictionary:(NSDictionary*)dictionary {
    NSMutableArray *parts = [[NSMutableArray alloc] init];
    for (NSString *key in dictionary) {
        NSString *encodedValue = [[dictionary objectForKey:key] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *encodedKey = [key stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *part = [NSString stringWithFormat: @"%@=%@", encodedKey, encodedValue];
        [parts addObject:part];
    }
    NSString *encodedDictionary = [parts componentsJoinedByString:@"&"];
    return [encodedDictionary dataUsingEncoding:NSUTF8StringEncoding];
}

/*
- (void) connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
    int code = [httpResponse statusCode];
    
    
}
- (void) conn
*/
@end
