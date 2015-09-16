//
//  DataStoreManager.h
//  VoyageUp
//
//  Created by Deepak on 16/05/15.
//  Copyright (c) 2015 Deepak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataStoreManager : NSObject
{
    NSArray *allQuestionsArray;
    NSArray *connectionsArray;
    NSArray *myConnectionsArray;
    NSArray *userMatchesArray;
    NSArray *latestMessagesArray;
    NSArray *shareArray;
    NSArray *myShareArray;
    NSArray *allMyQuestionArray;
    NSArray *answerArray;
    NSArray *myNotificationArray;
}
+ (id)sharedDataStoreManager;
+(void)ClearDataStoreManager;
+(void)saveUserName:(NSString*)username password:(NSString*)pswd;
+(NSString*)getUserName;
+(NSString*)getPassword;
-(void)setAllQuestionsArrayFrom:(NSMutableArray*)qnArray;
-(void)setAllconnectionsArrayFrom:(NSMutableArray*)qnArray;
-(NSArray*)getAllconnectionsArray;
-(void)setAllmyConnectionsArrayFrom:(NSMutableArray*)qnArray;
-(NSArray*)getAllmyConnectionsArray;
-(NSArray*)getAllQuestionsArray;
-(void)setuserMatchesArray:(NSMutableArray*)qnArray;
-(NSArray*)getuserMatchesArray;
-(void)setLatestMessagesArray:(NSMutableArray*)qnArray;
-(NSArray*)getLatestMessagesArray;
-(void)setshareArray:(NSMutableArray*)qnArray;
-(NSArray*)getshareArray;
-(void)setmyShareArray:(NSMutableArray*)qnArray;
-(NSArray*)getmyShareArray;
-(void)setallMyQuestionArray:(NSMutableArray*)qnArray;
-(NSArray*)getallMyQuestionArray;
-(void)setanswerArray:(NSMutableArray*)qnArray;
-(NSArray*)getanswerArray;
-(void)setmyNotificationArray:(NSMutableArray*)qnArray;
-(NSArray*)getmyNotificationArray;
@end
