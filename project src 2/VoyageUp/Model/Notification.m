//
//  Notification.m
//  VoyageUp
//
//  Created by Deepak on 31/05/15.
//  Copyright (c) 2015 Deepak. All rights reserved.
//

#import "Notification.h"

@implementation Notification
+(Notification *)NotificationDictionary:(NSDictionary *)dict
{
    Notification *answer = [Notification new];
    
    answer.NotificationId= [dict valueForKeyPath:@"NotificationId"];
    answer.NotificationTitle= [dict valueForKeyPath:@"NotificationTitle"];
    answer.NotificationMessage= [dict valueForKeyPath:@"NotificationMessage"];
    answer.Date= [dict valueForKeyPath:@"Date"];
    answer.SenderID= [dict valueForKeyPath:@"notification_Sender"];
    answer.receiver_ID= [dict valueForKeyPath:@"notification_receiver"];
    answer.sender_firstName= [dict valueForKeyPath:@"FirstName"];
    answer.sender_lastName = [dict valueForKeyPath:@"LastName"];
    answer.senderProfilePhoto = [dict valueForKeyPath:@"ProfilePhoto"];
    answer.sendrFullName=[NSString stringWithFormat:@"%@ %@",answer.sender_firstName,answer.sender_lastName];
    return answer;
}
@end

