//
//  ZoomingProtocol.h
//  FavoritePlaces
//
//  Created by Student on 10/23/14.
//  Copyright (c) 2014 Bryan French. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@protocol ZoomingProtocol <NSObject>

-(void) zoomOnAnnotation:(id<MKAnnotation>) annotation;

@end
