//
//  latestMessages.m
//  VoyageUp
//
//  Created by Deepak on 25/05/15.
//  Copyright (c) 2015 Deepak. All rights reserved.
//

#import "latestMessages.h"

@implementation latestMessages
+(latestMessages *)latestMessagesDictonery:(NSDictionary *)dict
{
    latestMessages *chat = [latestMessages new];
  
    chat.messageText= [NSString stringWithFormat:@"%@", [dict objectForKey:@"MessageText"]];
    chat.messageId= [NSString stringWithFormat:@"%@", [dict objectForKey:@"MessageId"]];
    chat.ProfilePhoto = [dict valueForKeyPath:@"ProfilePhoto"];
    chat.FirstName = [dict valueForKeyPath:@"FirstName"];
    chat.LastName = [dict valueForKeyPath:@"LastName"];
    chat.UserId = [dict valueForKeyPath:@"UserId"];
    chat.FullName=[NSString stringWithFormat:@"%@ %@",chat.FirstName,chat.LastName];
   chat.messageReceivedDate= [NSString stringWithFormat:@"%@", [dict objectForKey:@"message_send_date"]];
    
    return chat;
  
    
}
@end
