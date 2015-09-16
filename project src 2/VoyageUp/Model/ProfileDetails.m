//
//  ProfileDetails.m
//  AskBaaghil
//
//  Created by Doyel Joboy on 31/03/15.
//  Copyright (c) 2015 Reflections Info Systems. All rights reserved.
//

#import "ProfileDetails.h"

static ProfileDetails *profileDetails = nil;

@implementation ProfileDetails

-(void)saveUserDetails:(NSDictionary *)result
{
   AppDelegate* appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];    
    self.ConnectionType = [result valueForKeyPath:@"ConnectionType"];
    self.Email = [result valueForKeyPath:@"Email"];
    self.FirstName = [result valueForKeyPath:@"FirstName"];
    self.GeofenceArea = [result valueForKeyPath:@"GeofenceArea"];
    self.LastName = [result valueForKeyPath:@"LastName"];
    self.LoginType = [result valueForKeyPath:@"LoginType"];
    self.ProfilePhoto =[result valueForKeyPath:@"ProfilePhoto"];
    self.UserId = [result valueForKeyPath:@"UserId"];
    self.gender = [result valueForKeyPath:@"gender"];
    self.latitude = [result valueForKeyPath:@"latitude"];
    self.latitude = [result valueForKeyPath:@"longitude"];
    self.api_key=[result valueForKeyPath:@"api_key"];
    self.Country=[result valueForKeyPath:@"country"];
    self.dob=[result valueForKeyPath:@"dateofbirth"];
    self.FullName=[NSString stringWithFormat:@"%@ %@",self.FirstName,self.LastName];
    NSString* key=[result valueForKeyPath:@"api_key"];
    if (key.length>0)
        appdelegate.api_key=[result valueForKeyPath:@"api_key"];
    self.admin=true;
    

    NSData *imageData = [NSData dataWithContentsOfURL:[helper getImageUrl:self.ProfilePhoto]];
   self.image_my = [UIImage imageWithData:imageData];
}
+(ProfileDetails *)profileDetails:(NSDictionary *)result
{
    ProfileDetails *user = [ProfileDetails new];
    user.ConnectionType = [result valueForKeyPath:@"ConnectionType"];
    user.Email = [result valueForKeyPath:@"Email"];
    user.FirstName = [result valueForKeyPath:@"FirstName"];
    user.GeofenceArea = [result valueForKeyPath:@"GeofenceArea"];
    user.LastName = [result valueForKeyPath:@"LastName"];
    user.LoginType = [result valueForKeyPath:@"LoginType"];
    user.ProfilePhoto = [result valueForKeyPath:@"ProfilePhoto"];
    user.UserId = [result valueForKeyPath:@"UserId"];
    user.gender = [result valueForKeyPath:@"gender"];
    user.latitude = [result valueForKeyPath:@"latitude"];
    user.longitude = [result valueForKeyPath:@"longitude"];
    user.GeofenceArea= [result valueForKeyPath:@"GeofenceArea"];
    user.Country=[result valueForKeyPath:@"country"];
    user.dob=[result valueForKeyPath:@"dateofbirth"];
    user.network_ID=[result valueForKeyPath:@"network_id"];
    user.FullName=[NSString stringWithFormat:@"%@ %@",user.FirstName,user.LastName];
    user.admin=false;
//    NSData *imageData = [NSData dataWithContentsOfURL:[helper getImageUrl:user.ProfilePhoto]];
//    user.image_my = [UIImage imageWithData:imageData];
    
    
    
    
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSData *imgData = [NSData dataWithContentsOfURL:[helper getImageUrl:user.ProfilePhoto]];
//        if (imgData) {
//            UIImage *image = [UIImage imageWithData:imgData];
//            if (image) {
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    user.image_my=image;
//                });
//            }
//        }
//    });
    
    
    
    return user;
}


+ (id)getProfileDetails
{
    @synchronized(self)
    {
        if (profileDetails == nil)
            profileDetails = [[self alloc] init];
    }
    return profileDetails;
}

- (id)init
{
    if (self = [super init])
    {
        
    }
    return self;
}

+(void)ClearProfileData
{
    if (profileDetails)
        profileDetails = nil;
        }
@end
