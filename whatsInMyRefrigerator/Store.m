//
//  Store.m
//  whatsInMyRefrigerator
//
//  Created by Student on 12/17/14.
//  Copyright (c) 2014 -=fAlC0n=-. All rights reserved.
//

#import "Store.h"

@implementation Store

-(id) init{
    self = [super init];
    return self;
}

-(id)initWithName:(NSString *)s_name slocation:(CLLocation *)s_location{
    self = [super init];
    if(self!=nil){
        self.storeName = s_name;
        self.location = s_location;
    }
    
    return self;
}

//+(id) store{
//
//    return store;
//}


@end
