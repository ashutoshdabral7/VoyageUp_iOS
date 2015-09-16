//
//  Sharing.h
//  VoyageUp
//
//  Created by Deepak on 16/05/15.
//  Copyright (c) 2015 Deepak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Sharing : NSObject
@property (nonatomic,strong) NSString* itemName;
@property (nonatomic,strong) NSString* itemID;
@property (nonatomic,strong) NSString* shareMessage;
@property (nonatomic,strong) NSString* shareDate;
@property (nonatomic,strong) NSString* SharedUserId;
@property (nonatomic,strong) NSString* SharedUserFirstName;
@property (nonatomic,strong) NSString* SharedUserLastName;
@property (nonatomic,strong) NSString* SharedUserPhoto;
@property (nonatomic,strong) NSString* sharedLatitude;
@property (nonatomic,strong) NSString* sharedLongitude;
@property (nonatomic,strong) NSString* sharedGeoFenceArea;
@property (nonatomic,strong) NSString* FullName;
+(Sharing *)shareDetails:(NSDictionary *)result;
@end
