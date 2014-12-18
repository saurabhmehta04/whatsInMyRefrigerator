//
//  Middlelayer.m
//  whatsInMyRefrigerator
//
//  Created by Student on 12/13/14.
//  Copyright (c) 2014 -=fAlC0n=-. All rights reserved.
//

#import "Middlelayer.h"

@implementation Middlelayer

- (NSArray *)downloadItems:(NSString *)url
{
    // Download the json file
    NSURL *jsonFileUrl = [NSURL URLWithString:url];
    
    
    // Create the request
    
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:jsonFileUrl];
    
    // Create the NSURLConnection
    //NSLog(@"URL2: %@",url);
    [NSURLConnection connectionWithRequest:urlRequest delegate:self];
    
    CFRunLoopRun();
    
    return self.dict;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // Initialize the data object
    
    self.data = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the newly downloaded data
    
    [self.data appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // Parse the JSON that came in
    //NSLog(@"connectionDidFinishLoading");
    NSError *error;
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:self.data options:NSJSONReadingAllowFragments error:&error];
    self.dict = jsonArray;
    
    CFRunLoopStop(CFRunLoopGetCurrent());
}





@end
