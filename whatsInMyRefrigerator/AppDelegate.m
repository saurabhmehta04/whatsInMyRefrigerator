//
//  AppDelegate.m
//  whatsInMyRefrigerator
//
//  Created by -=fAlC0n=- on 12/3/14.
//  Copyright (c) 2014 -=fAlC0n=-. All rights reserved.
//

#import "AppDelegate.h"
#import "MapVC.h"
//#import <GoogleMaps/GoogleMaps.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //[self.window setTintColor:[UIColor greenColor]];
    
    [self.window setTintColor:[UIColor colorWithRed:46.0/255.0 green:204.0/255.0 blue:113.0/255.0 alpha:1]];
    [self loadstore];
    
    MapVC *mv = [[MapVC alloc] init];
    mv.store = self.store;
    
    // Override point for customization after application launch.
    
//    if([[NSUserDefaults standardUserDefaults] stringForKey:@"username"].length>0){
//        UITabBarController *tab = (UITabBarController *)self.window.rootViewController;
//        UINavigationController *navVC = (UINavigationController *) [[tab viewControllers]objectAtIndex:1];
//        InventoryTVC *invent = [[UIStoryboard alloc] instantiateViewControllerWithIdentifier:@"inventory"];
//        [navVC pushViewController:invent animated:YES];
//    }
//    [GMSServices provideAPIKey:@"AIzaSyBtV2tlMp-dqxoz299dVeLQ46uL5RyNhYQ"];
    return YES;

}

-(void) loadstore{
    
    self.store = [NSMutableArray array];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"map" ofType:@"plist"];
    
    NSDictionary *tempDictionary = [NSDictionary dictionaryWithContentsOfFile:path];
    
    NSArray *tempArray = [tempDictionary objectForKey:@"nearbylocation"];
    
    // create parks ivar
    self.store = [[NSMutableArray alloc]init];
    
    for (id dict in tempArray) {
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        NSString *name = [dict objectForKey:@"name"];
        float latitude = [[dict objectForKey:@"lat"] floatValue];
        float longitude = [[dict objectForKey:@"long"] floatValue];
        CLLocation *location = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
        //you get the rest of the values
        //....
        [arr addObject:name];
        [arr addObject:location];
        
        //you do rest of assignments
        //....
        
        //add to self.parks array
        [self.store addObject:arr];
        
    }


}

- (void)applicationWillResignActive:(UIApplication *)application {
    //NSLog(@"applicationWillResignActive");
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    //NSLog(@"applicationDidEnterBackground");
   
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
   // NSLog(@"applicationWillEnterForeground");
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    //NSLog(@"applicationDidBecomeActive");
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    //[[NSUserDefaults standardUserDefaults] removeObjectForKey:@"username"];
    //[[NSUserDefaults standardUserDefaults] synchronize];
    //NSLog(@"applicationWillTerminate");
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
