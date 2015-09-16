//
//  ProfileDetails.h
//  AskBaaghil
//
//  Created by Doyel Joboy on 31/03/15.
//  Copyright (c) 2015 Reflections Info Systems. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProfileDetails : NSObject

@property (nonatomic,strong) NSString* FirstName;
@property (nonatomic,strong) NSString* LastName;
@property (nonatomic,strong) NSString* City;
@property (nonatomic,strong) NSString* Country;
@property (nonatomic,strong) NSString* Email;
@property (nonatomic,strong) NSString* UserName;
@property (nonatomic,strong) NSString* Password;
@property (nonatomic,strong) NSString* token;
@property (nonatomic,strong) NSString* ProfilePhoto;
@property (nonatomic,strong) NSString* UserId;
@property (nonatomic,strong) NSString* gender;
@property (nonatomic,strong) NSString* latitude;
@property (nonatomic,strong) NSString* longitude;
@property (nonatomic,strong) NSArray* ConnectionType;
@property (nonatomic,strong) NSString* GeofenceArea;
@property (nonatomic,strong) NSString* LoginType;
@property (nonatomic,strong) NSString* api_key;
@property (nonatomic,strong) NSString* dob;
@property (nonatomic,strong) UIImage* image_my;
@property (nonatomic,strong)NSString *FullName;
@property (nonatomic,strong)NSString *network_ID;
@property  BOOL admin;
+(id)getProfileDetails;
+(void)ClearProfileData;
-(void)saveUserDetails:(NSDictionary *)result;
+(ProfileDetails *)profileDetails:(NSDictionary *)result;
@end
