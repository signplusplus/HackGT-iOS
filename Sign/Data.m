//
//  Data.m
//  Sign
//
//  Created by Andrew Thieck on 9/20/14.
//  Copyright (c) 2014 Andrew Thieck. All rights reserved.
//

#import "Data.h"
#import "AFHTTPRequestOperationManager.h"

@implementation Data

static Data *instance = nil;
static NSString *signPlusPlusURL = @"http://signplusplus.web44.net";

+ (Data *)defaultData {
    if(instance == nil)
        instance = [[Data alloc] init];
    return instance;
}

- (void) sendMessage: (NSString *)string toNumber: (NSNumber *)number {
    
     NSDictionary *params=@{@"text": string,
                            @"number": number};
     
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager POST:[NSString stringWithFormat:@"%@", signPlusPlusURL]
       parameters:params
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              //NSLog(@"%@", responseObject);
              
              UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Message Sent" message:@"The message successfully sent!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
              
              [alertView show];
            
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"There doesn't seem to be any internet connection." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
              
              NSLog(@"%@", operation.response);
              
              [alertView show];
              NSLog(@"%@",error);
          }];
    
}

@end
