//
//  Middlelayer.h
//  whatsInMyRefrigerator
//
//  Created by Student on 12/13/14.
//  Copyright (c) 2014 -=fAlC0n=-. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Middlelayer : NSObject<NSURLConnectionDataDelegate>

@property (nonatomic, strong) NSMutableData *data;
@property (nonatomic, strong) NSArray *dict;


- (NSArray *) downloadItems:(NSString *)url;
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response;
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;
- (void)connectionDidFinishLoading:(NSURLConnection *)connection;
@end
