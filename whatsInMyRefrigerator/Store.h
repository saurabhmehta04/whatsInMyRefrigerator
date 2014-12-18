//
//  Store.h
//  whatsInMyRefrigerator
//
//  Created by Student on 12/17/14.
//  Copyright (c) 2014 -=fAlC0n=-. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>


@interface Store : NSObject<MKAnnotation>

@property(nonatomic, strong)NSString *storeName;
@property(nonatomic, strong)CLLocation *location;

-(id) initWithName: (NSString *) s_name
         slocation: (CLLocation *) s_location;

+(id) store;

@end
