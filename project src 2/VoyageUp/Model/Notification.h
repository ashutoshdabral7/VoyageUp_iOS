//
//  Notification.h
//  VoyageUp
//
//  Created by Deepak on 31/05/15.
//  Copyright (c) 2015 Deepak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Notification : NSObject
@property  NSString *NotificationId;
@property  NSString *NotificationTitle;
@property  NSString *NotificationMessage;
@property  NSString *Date;
@property  NSString *SenderID;
@property  NSString *receiver_ID;
@property  NSString *sender_firstName;
@property  NSString *sender_lastName;
@property  NSString * FirstName;
@property  NSString * LastName;
@property  NSString *senderProfilePhoto;
@property  NSString *sendrFullName;
+(Answer *)NotificationDictionary:(NSDictionary *)dict;
@end
