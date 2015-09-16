//
//  VoyageUpAPIManager.h
//  VoyageUp
//
//  Created by Deepak on 16/05/15.
//  Copyright (c) 2015 Deepak. All rights reserved.
//
#import "AFHTTPRequestOperationManager.h"
#import <Foundation/Foundation.h>
@class VoyageUpAPIManager;
@protocol VoyageUpRestAPIManagerProtocol <NSObject>

-(void)VoyageUpRestAPIManagerdelegate:(VoyageUpAPIManager*)manager WithResponseDictionary:(NSDictionary*)dict;

@end

//API handlers
typedef void (^VoyageUpCompletionBlock)(NSDictionary*, NSError*);
@interface VoyageUpAPIManager : AFHTTPRequestOperationManager
@property (strong, nonatomic) id<VoyageUpRestAPIManagerProtocol> delegate;

+(VoyageUpAPIManager *)sharedManager;
-(instancetype)initWithBaseURL:(NSURL *)url;
- (void)addDefaultHeaders;
//post methods
-(void)Signup:(NSDictionary*)postobject WithCompletionblock:(VoyageUpCompletionBlock)completionHandler;
-(void)Login:(NSDictionary*)postobject  WithCompletionblock:(VoyageUpCompletionBlock)completionHandler;
-(void)ProfileUpdate:(NSDictionary*)postobject AndPhoto:(UIImage*)photo WithCompletionblock:(VoyageUpCompletionBlock)completionHandler;
-(void)ChangePassword:(NSDictionary*)postobject  WithCompletionblock:(VoyageUpCompletionBlock)completionHandler;
-(void)Forgotpassword:(NSDictionary*)postobject  WithCompletionblock:(VoyageUpCompletionBlock)completionHandler;
-(void)UpdateConnectionTypes:(NSDictionary*)postobject  WithCompletionblock:(VoyageUpCompletionBlock)completionHandler;
-(void)UpdateLocation:(NSDictionary*)postobject  WithCompletionblock:(VoyageUpCompletionBlock)completionHandler;
-(void)getUsers:(NSDictionary*)postobject  WithCompletionblock:(VoyageUpCompletionBlock)completionHandler;
-(void)getSingleUserDetails:(NSDictionary*)postobject  WithCompletionblock:(VoyageUpCompletionBlock)completionHandler;
-(void)Invite_Notification:(NSDictionary*)postobject  WithCompletionblock:(VoyageUpCompletionBlock)completionHandler;
-(void)ShareMyItem:(NSDictionary*)postobject  WithCompletionblock:(VoyageUpCompletionBlock)completionHandler;
-(void)GetAllSharesInMyArea:(NSDictionary*)postobject loader:(BOOL)loader WithCompletionblock:(VoyageUpCompletionBlock)completionHandler;
-(void)PostQuestion:(NSDictionary*)postobject  WithCompletionblock:(VoyageUpCompletionBlock)completionHandler;
-(void)GetQuestionById:(NSDictionary*)postobject  WithCompletionblock:(VoyageUpCompletionBlock)completionHandler;
-(void)PostAnswer:(NSDictionary*)postobject  WithCompletionblock:(VoyageUpCompletionBlock)completionHandler;
-(void)ShareTable:(NSDictionary*)postobject  WithCompletionblock:(VoyageUpCompletionBlock)completionHandler;
//get methods
-(void)GetConnectionList:(VoyageUpCompletionBlock)completionHandler;
-(void)GEtMyShares:(BOOL)loader :(VoyageUpCompletionBlock)completionHandler;
-(void)GetAllQuestions:(VoyageUpCompletionBlock)completionHandler;
-(void)GetMyQuestions:(VoyageUpCompletionBlock)completionHandler;
-(void)GetAllNotifications:(BOOL)loader :(VoyageUpCompletionBlock)completionHandler;
-(void)GetConnection_singleUser:(NSString*)userid :(VoyageUpCompletionBlock)completionHandler;
-(void)deleteMessage:(NSDictionary*)postobject  WithCompletionblock:(VoyageUpCompletionBlock)completionHandler;
-(void)deleteMessageAutomatic:(NSDictionary*)postobject  WithCompletionblock:(VoyageUpCompletionBlock)completionHandler;
//  chat ---

-(void)sendMessage:(NSDictionary*)postobject  WithCompletionblock:(VoyageUpCompletionBlock)completionHandler;
-(void)GetLatestMessages:(VoyageUpCompletionBlock)completionHandler;
-(void)getAllMessagesFromSingleUser:(NSDictionary*)postobject  WithCompletionblock:(VoyageUpCompletionBlock)completionHandler;
@end
