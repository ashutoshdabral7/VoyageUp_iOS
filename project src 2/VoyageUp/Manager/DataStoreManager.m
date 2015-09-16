//
//  DataStoreManager.m
//  VoyageUp
//
//  Created by Deepak on 16/05/15.
//  Copyright (c) 2015 Deepak. All rights reserved.
//

#import "DataStoreManager.h"
static DataStoreManager *dataStoreManager = nil;
@implementation DataStoreManager
+ (id)sharedDataStoreManager
{
    @synchronized(self)
    {
        if (dataStoreManager == nil)
            dataStoreManager = [[self alloc] init];
    }
    return dataStoreManager;
}

- (id)init
{
    if (self = [super init])
    {
        
    }
    return self;
}

+(void)ClearDataStoreManager
{
    if (dataStoreManager)
        dataStoreManager = nil;
}
-(void)setAllQuestionsArrayFrom:(NSMutableArray*)qnArray
{
    allQuestionsArray = [qnArray copy];
}

-(NSArray*)getAllQuestionsArray
{
    return allQuestionsArray;
}
-(void)setAllconnectionsArrayFrom:(NSMutableArray*)qnArray
{
    connectionsArray = [qnArray copy];
}

-(NSArray*)getAllconnectionsArray
{
    return connectionsArray;
}
-(void)setAllmyConnectionsArrayFrom:(NSMutableArray*)qnArray
{
    myConnectionsArray = [qnArray copy];
}
+(void)saveUserName:(NSString *)username password:(NSString *)pswd
{
    [[NSUserDefaults standardUserDefaults] setObject:username forKey:@"username"];
    [[NSUserDefaults standardUserDefaults] setObject:pswd forKey:@"password"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(NSString*)getUserName
{
    return [[NSUserDefaults standardUserDefaults]
            stringForKey:@"username"];
}
+(NSString*)getPassword
{
    return [[NSUserDefaults standardUserDefaults]
            stringForKey:@"password"];
}
-(NSArray*)getAllmyConnectionsArray
{
    return myConnectionsArray;
}
-(void)setuserMatchesArray:(NSMutableArray*)qnArray
{
    userMatchesArray = [qnArray copy];
}
-(NSArray*)getuserMatchesArray
{
    return userMatchesArray;
}
-(void)setLatestMessagesArray:(NSMutableArray*)qnArray;

{
    latestMessagesArray = [qnArray copy];
}
-(NSArray*)getLatestMessagesArray
{
    return latestMessagesArray;
}
-(void)setshareArray:(NSMutableArray*)qnArray
{
    shareArray = [qnArray copy];
}

-(NSArray*)getshareArray
{
    return shareArray;
    
}
-(void)setmyShareArray:(NSMutableArray*)qnArray
{
    myShareArray = [qnArray copy];
}
-(NSArray*)getmyShareArray
{
    return myShareArray;
    
}
-(void)setallMyQuestionArray:(NSMutableArray*)qnArray
{
    allMyQuestionArray=[qnArray copy];
}
-(NSArray*)getallMyQuestionArray
{
    return allMyQuestionArray;
}
-(void)setanswerArray:(NSMutableArray*)qnArray
{
    answerArray=[qnArray copy];
    
}
-(NSArray*)getanswerArray
{
    return answerArray;
}
-(void)setmyNotificationArray:(NSMutableArray*)qnArray
{
    myNotificationArray=[qnArray copy];
}
-(NSArray*)getmyNotificationArray
{
    return myNotificationArray;
}
@end
