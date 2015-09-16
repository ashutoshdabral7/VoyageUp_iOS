//
//  latestMessages.h
//  VoyageUp
//
//  Created by Deepak on 25/05/15.
//  Copyright (c) 2015 Deepak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface latestMessages : NSObject
@property (nonatomic, strong) NSString *messageId;
@property (nonatomic, strong) NSString *FullName;
@property (nonatomic, strong) NSString *messageText;
@property (nonatomic, strong) NSString *messageReceivedDate;
@property (nonatomic, strong) NSString *messageSentDate;
@property (nonatomic, strong) NSString *messageTo;
@property (nonatomic, strong) NSString *messageFrom;
@property (nonatomic,strong) NSString* FirstName;
@property (nonatomic,strong) NSString* LastName;
@property (nonatomic,strong) NSString* Email;

@property (nonatomic,strong) NSString* ProfilePhoto;
@property (nonatomic,strong) NSString* UserId;
+(latestMessages *)latestMessagesDictonery:(NSDictionary *)dict;
@end
