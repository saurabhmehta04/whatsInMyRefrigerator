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
    //NSLog(@"URL: %@",url);
    //NSURL *jsonFileUrl = [NSURL URLWithString:@"http://people.rit.edu/mmz9731/abs.php"];
    
    // Create the request
    //NSLog(@"URL1: %@",url);
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:jsonFileUrl];
    
    // Create the NSURLConnection
    //NSLog(@"URL2: %@",url);
    [NSURLConnection connectionWithRequest:urlRequest delegate:self];
    //NSLog(@"URL3: %@",url);
    CFRunLoopRun();
    //NSLog(@"URL4: %@",url);
    return self.dict;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // Initialize the data object
    //NSLog(@"didReceiveResponse: ");
    self.data = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the newly downloaded data
    //NSLog(@"didReceive:");
    [self.data appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // Parse the JSON that came in
    //NSLog(@"connectionDidFinishLoading");
    NSError *error;
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:self.data options:NSJSONReadingAllowFragments error:&error];
    self.dict = jsonArray;
    //NSLog(@"DATA: %@",self.dict);
    CFRunLoopStop(CFRunLoopGetCurrent());
}





@end
