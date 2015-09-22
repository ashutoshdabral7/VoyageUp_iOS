//
//  AppDelegate.m
//  VoyageUp
//
//  Created by Deepak on 20/04/15.
//  Copyright (c) 2015 Deepak. All rights reserved.
//

#import "AppDelegate.h"
#import "SLPagingViewController.h"
#import <FacebookSDK/FacebookSDK.h>

@interface AppDelegate ()

@end

@implementation AppDelegate
//@synthesize locationManager,geocoder,placemark;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    geocoder = [[CLGeocoder alloc] init];
//    locationManager = [[CLLocationManager alloc] init];
//    [self getCurrentLocation ];
    [self registerForRemoteNotifications];
    //    SLPagingViewController *pageViewController  = self.window.rootViewController.childViewControllers.firstObject;
    //    pageViewController.navigationSideItemsStyle = SLNavigationSideItemsStyleOnBounds;
    //    [pageViewController setCurrentIndex:1
    //                               animated:NO];
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    tabBarController.selectedIndex =0;
    [tabBarController.tabBar setSelectedImageTintColor:COLOR_MAIN_BG];
    return YES;
}

#pragma mark push notification methods
- (void)registerForRemoteNotifications
{
    
    UIApplication *application = [UIApplication sharedApplication];
    
    // Register for Push Notitications, if running iOS 8
#ifdef __IPHONE_8_0
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert |
                                                        UIUserNotificationTypeBadge |
                                                        UIUserNotificationTypeSound);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes
                                                                                 categories:nil];
        [application registerUserNotificationSettings:settings];
        [application registerForRemoteNotifications];
    }
    else{
        // Register for Push Notifications before iOS 8
        [application registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                         UIRemoteNotificationTypeAlert |
                                                         UIRemoteNotificationTypeSound)];
    }
#else
    {
        // Register for Push Notifications before iOS 8
        [application registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                         UIRemoteNotificationTypeAlert |
                                                         UIRemoteNotificationTypeSound)];
    }
#endif
}

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    
    NSData* pushToken = [[NSData alloc] initWithData:deviceToken];
    NSString* token = [[[[pushToken description] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""];
    self.apns_token = token;
    self.apns_token_temp = token;
    
}
- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    @try{
        
        
        
    }
    @catch (NSException *exception)
    {
        
        
        
    }
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    // attempt to extract a token from the url
    return [FBSession.activeSession handleOpenURL:url];//||[GPPURLHandler handleURL:url
    //                                                               sourceApplication:sourceApplication
    //                                                                      annotation:annotation];
    //return [FBSession.activeSession handleOpenURL:url];
    
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    if (locationUpdate) {
        [locationUpdate invalidate];
    }
    [self updateNetworkdidGoingtoBackground];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    //[self getCurrentLocation];
    //[self locationUpdate:nil];
    [self DeleteAllMessages];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    // [self getCurrentLocation];
    
    locationUpdate = [NSTimer scheduledTimerWithTimeInterval:60.0
                                                      target:self
                                                    selector:@selector(locationUpdate:)
                                                    userInfo:nil
                                                     repeats:YES];
    
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    tabBarController.selectedViewController=[tabBarController.viewControllers objectAtIndex:0];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
#pragma mark location
//- (void)getCurrentLocation{
//    locationManager.delegate = self;
//    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//    
//    [locationManager startUpdatingLocation];
//    if(IS_OS_8_OR_LATER) {
//        [self.locationManager requestAlwaysAuthorization];
//        [self.locationManager requestWhenInUseAuthorization];
//    }
//}
//- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
//{
//    CLLocation *currentLocation = newLocation;
//    
//    if (currentLocation != nil) {
//        self.Latitude= [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
//        self.longitude = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
//    }
//    
//    // Stop Location Manager
//    // [locationManager stopUpdatingLocation];
//    
//    //    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
//    //        NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
//    //        if (error == nil && [placemarks count] > 0) {
//    //            placemark = [placemarks lastObject];
//    //            //            addressLabel.text = [NSString stringWithFormat:@"%@ %@\n%@ %@\n%@\n%@",
//    //            //                                 placemark.subThoroughfare, placemark.thoroughfare,
//    //            //                                 placemark.postalCode, placemark.locality,
//    //            //                                 placemark.administrativeArea,
//    //            //                                 placemark.country];
//    //        } else {
//    //            NSLog(@"%@", error.debugDescription);
//    //        }
//    //    } ];
//    
//}
//- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
//{
//    UIAlertView *errorAlert = [[UIAlertView alloc]
//                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//    [errorAlert show];
//}
- (void)locationUpdate:(NSString*)latitude {
    
    @try
    {
        
        [self getNetworkId];
        ProfileDetails *profile=[ProfileDetails getProfileDetails];
        if (profile.GeofenceArea.length<1)
            self.geofenceArea=@"500";
        else
            self.geofenceArea=profile.GeofenceArea;
        if (self.Latitude.length<1)
            self.Latitude=@"12.38459555";
        if (self.longitude.length<1)
            self.longitude=@"76.39949303";
        if (self.apns_token.length<1)
            self.apns_token=@"1234567890102022";
        
        NSDictionary *postobject = [NSDictionary dictionaryWithObjectsAndKeys:
                                    self.Latitude,POST_LATITUDE,
                                    self.longitude,POST_LOGITUDE,
                                    self.geofenceArea,POST_GEOFENCE_AREA,
                                    self.apns_token,POST_DEVISE_ID,
                                    self.network_token, POST_NETWORK_ID,
                                    nil];
        
        [[VoyageUpAPIManager sharedManager] UpdateLocation:postobject WithCompletionblock:^(NSDictionary*result,NSError *error)
         {
             
             
         }];
    }
    @catch (NSException *exception)
    {
        
    }
}

-(void)getNetworkId
{
    self.network_token= [helper randomStringWithLength];//@"xxx";//
    @try {
        //------- get network id
        
        NSArray *interfaceNames = CFBridgingRelease(CNCopySupportedInterfaces());
        
        
        
        
        NSDictionary *SSIDInfo;
        
        for (NSString *interfaceName in interfaceNames) {
            
            SSIDInfo = CFBridgingRelease(
                                         
                                         CNCopyCurrentNetworkInfo((__bridge CFStringRef)interfaceName));
            
            
            self.network_token=[SSIDInfo valueForKey:@"SSID"];
            
            BOOL isNotEmpty = (SSIDInfo.count > 0);
            
            if (isNotEmpty) {
                
                break;
                
            }
            
        }
        
        //----------------
    }
    @catch (NSException *exception) {
        self.network_token=[helper randomStringWithLength];
    }
}
- (void)updateNetworkdidGoingtoBackground{
    
    @try
    {
        
        
        self.geofenceArea=@"500";
        self.Latitude=@"12.38459555";
        
        self.longitude=@"76.39949303";
        if (self.apns_token.length<1)
            self.apns_token=@"1234567890102022";
        self.network_token=[helper randomStringWithLength];//@"xxx";//[
        NSDictionary *postobject = [NSDictionary dictionaryWithObjectsAndKeys:
                                    self.Latitude,POST_LATITUDE,
                                    self.longitude,POST_LOGITUDE,
                                    self.geofenceArea,POST_GEOFENCE_AREA,
                                    self.apns_token,POST_DEVISE_ID,
                                    self.network_token, POST_NETWORK_ID,
                                    nil];
        
        [[VoyageUpAPIManager sharedManager] UpdateLocation:postobject WithCompletionblock:^(NSDictionary*result,NSError *error)
         {
             
             
         }];
    }
    @catch (NSException *exception)
    {
        
    }
}
-(void)DeleteAllMessages
{
    
    [[VoyageUpAPIManager sharedManager] DeleteAllMessages:^(NSDictionary*result,NSError *error) {
        
        
    }];
    
    
}
@end
