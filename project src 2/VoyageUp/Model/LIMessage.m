//
//  LIMessage.m
//
//

#import "LIMessage.h"

@implementation LIMessage
#define messageWidth                       20
+(LIMessage *)latestMessagesDictonery:(NSDictionary *)dict
{
    LIMessage *chat = [LIMessage new];
    
    
//    chat.chat= [dict valueForKeyPath:@"chat"];;
//    chat.qn_id= [NSString stringWithFormat:@"%@", [dict objectForKey:@"id"]];
//    chat.isanswered= [dict objectForKey:@"isanswered"] != nil && [[dict objectForKey:@"isanswered"] isEqualToString:@"1"] ? YES : NO;
//    chat.date= [NSNumber numberWithDouble:[[dict objectForKey:@"date"] doubleValue]];
//    chat.chatType= [dict valueForKeyPath:@"type"];
//    chat.answer= [dict valueForKeyPath:@"answer"];
//    chat.user_name=[dict valueForKeyPath:@"user_name"];
//    chat.user_id=[NSString stringWithFormat:@"%@", [dict objectForKey:@"user_id"]];
//    chat.paymentType= [dict objectForKey:@"type"] != nil && [[dict objectForKey:@"type"] isEqualToString:@"paid"] ? YES : NO;
//    chat.user_about=[dict valueForKeyPath:@"user_name"];
//    chat.answer_count=[NSString stringWithFormat:@"%@",[dict valueForKeyPath:@"answer_count"]];
//    chat.photo_url=[NSString_Utilities trim:[dict valueForKeyPath:@"photo"]];
//    NSArray *answerArray = [dict objectForKey:@"answer"];
//    NSMutableArray *answer = [NSMutableArray new];
//    for (NSDictionary *an in answerArray)
//    {
//        [answer addObject:[Answer answerDictionary:[an dictionaryByReplacingNullsWithStrings]]];
//    }
//    chat.allAnswers=answer;
    ProfileDetails *profile=[ProfileDetails getProfileDetails];
   chat.messageId= [NSString stringWithFormat:@"%@", [dict objectForKey:@"MessageId"]];
    
    
    const char *jsonString = [[dict objectForKey:@"MessageText"] UTF8String];
    NSData *jsonData = [NSData dataWithBytes:jsonString length:strlen(jsonString)];
    NSString *goodMsg = [[NSString alloc] initWithData:jsonData encoding:NSNonLossyASCIIStringEncoding];
    
    
    chat.messageText= goodMsg;//[NSString stringWithFormat:@"%@", [dict objectForKey:@"MessageText"]];
    chat.messageReceivedDate= [NSString stringWithFormat:@"%@", [dict objectForKey:@"MessageReceivedDate"]];
    chat.messageSentDate= [NSString stringWithFormat:@"%@", [dict objectForKey:@"message_send_date"]];
    chat.messageTo= [NSString stringWithFormat:@"%@", [dict objectForKey:@"MessageReceiver"]];
    chat.messageFrom= [NSString stringWithFormat:@"%@", [dict objectForKey:@"MessageSender"]];
    //chat.messageHeight=[LIMessage manageMessageCellHeightWithMessage:chat];
    chat.messageHeight=[helper textFrame:chat.messageText fontSize:14 widthFactor:80].height+50;
    //[helper textFrame:chat.messageText fontSize:14 widthFactor:80].height;
    if ([profile.UserId isEqualToString:chat.messageTo])
        chat.messageMode=LIMESSAGE_MODE_RECEIVED;
    else
        chat.messageMode=LIMESSAGE_MODE_SENT;
    
    return chat;
}
+ (CGFloat)manageMessageCellHeightWithMessage :(LIMessage *)message
{
    CGSize boundingSize = CGSizeMake(messageWidth-20, 10000000);
    CGRect itemText = [message.messageText  boundingRectWithSize:boundingSize
                                                         options:NSStringDrawingUsesLineFragmentOrigin
                                                      attributes:@{NSFontAttributeName:[UIFont fontWithName:FONT_MONT_LIGHT size:14]}
                                                         context:nil];
    itemText.size.height = (itemText.size.height < 40) ? 45 : itemText.size.height;
    return ( itemText.size.height + 20) ;
}

@end
