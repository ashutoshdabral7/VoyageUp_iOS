//
//  VoyageUpAPIManager.m
//  VoyageUp
//
//  Created by Deepak on 16/05/15.
//  Copyright (c) 2015 Deepak. All rights reserved.
//

#import "VoyageUpAPIManager.h"
#import "HttpUtility.h"
#import "NSDictionary+NullValidation.h"
@implementation VoyageUpAPIManager
@synthesize delegate;

+ (VoyageUpAPIManager *)sharedManager
{
    static VoyageUpAPIManager *_sharedRestAPIManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedRestAPIManager = [[self alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
    });
    
    return _sharedRestAPIManager;
}

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    
    if (self)
    {
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.requestSerializer = [AFHTTPRequestSerializer serializer];
        [self addDefaultHeaders];
    }
    
    return self;
}

- (void)addDefaultHeaders
{
        AppDelegate* appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //    ProfileDetails *profile=[ProfileDetails getProfileDetails];
    //    [self.requestSerializer setValue:@"ios" forHTTPHeaderField:@"Device-type"];
    //    NSString *token = (profile.token.length > 0)?profile.token:@"";
    //    NSString *deviceid = (appdelegate.deviceid.length > 0)?appdelegate.deviceid:@"123";
    //
    //    [self.requestSerializer setValue:token forHTTPHeaderField:@"Token"];
    [self.requestSerializer setValue:appdelegate.api_key forHTTPHeaderField:@"api-key"];
}
- (void) POST:(NSString *)URLString
   parameters:(id)parameters
      success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
      failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
   showLoader:(BOOL)showLoader
     withText:(NSString *)text{
    NSLog(@"URLString:%@",URLString);
    if([helper isNetworkAvailable])
    {
        
        if (showLoader) {
            if (text) {
                [SVProgressHUD showWithStatus:text maskType:SVProgressHUDMaskTypeClear];
            }
            else{
                [SVProgressHUD show];
            }
        }
        [self addDefaultHeaders];
        [self POST:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             success(operation,responseObject);
             [SVProgressHUD dismiss];
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             failure(operation, error);
             [SVProgressHUD dismiss];
         }];
    }else{
        
        [[[UIAlertView alloc] initWithTitle:nil message:NO_NETWORK_AVAILABLE delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        
        
    }
    
}

- (void)GET:(NSString *)URLString
 parameters:(id)parameters
    success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
 showLoader:(BOOL)showLoader
   withText:(NSString *)text
{
    NSLog(@"URLString:%@",URLString);
    
    if (showLoader) {
        if (text) {
            [SVProgressHUD showWithStatus:text maskType:SVProgressHUDMaskTypeClear];
        }
        else{
            [SVProgressHUD show];
        }
    }
    [self addDefaultHeaders];
    [self GET:URLString
   parameters:parameters
      success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         success(operation,responseObject);
         [SVProgressHUD dismiss];
     }
      failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         failure(operation, error);
         [SVProgressHUD dismiss];
         
     }
     
     ];
    
}


#pragma mark post methods

-(void)Signup:(NSDictionary*)postobject  WithCompletionblock:(VoyageUpCompletionBlock)completionHandler
{
    
    
    [self POST:[HttpUtility getUrlWithPath:API_SIGHNUP]
    parameters:@{
                 POST_FIRSTNAME:[postobject objectForKey:POST_FIRSTNAME],
                 POST_LASTNAME:[postobject objectForKey:POST_LASTNAME],
                 POST_EMAIL:[postobject objectForKey:POST_EMAIL],
                 POST_COUNTRY:[postobject objectForKey:POST_COUNTRY],
                 POST_DOB:[postobject objectForKey:POST_DOB],
                 POST_PASSWORD:[postobject objectForKey:POST_PASSWORD],
                 POST_GENDER:[postobject objectForKey:POST_GENDER],
                 POST_LOGINTYPE:[postobject objectForKey:POST_LOGINTYPE]
                 }
       success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if (completionHandler != nil)
             completionHandler([(NSDictionary *)responseObject dictionaryByReplacingNullsWithStrings],nil);
         
         else
         {
             if ( delegate != nil && [delegate respondsToSelector:@selector(VoyageUpRestAPIManagerdelegate:WithResponseDictionary:)] )
                 [delegate VoyageUpRestAPIManagerdelegate:self WithResponseDictionary:[(NSDictionary *)responseObject dictionaryByReplacingNullsWithStrings]];
             
         }
     }
       failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         //TODO: Show or handle error
         if (completionHandler != nil)
             completionHandler(nil,error);
         
          [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Some thing went to wrong, please try again later" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
     }
    showLoader:YES withText:@"Loading"
     ];
}
-(void)Login:(NSDictionary*)postobject  WithCompletionblock:(VoyageUpCompletionBlock)completionHandler
{
    
    [self POST:[HttpUtility getUrlWithPath:API_LOGIN]
    parameters:@{
                 POST_EMAIL:[postobject objectForKey:POST_EMAIL],
                 POST_PASSWORD:[postobject objectForKey:POST_PASSWORD]
                 //POST_FACEBOOK:[postobject objectForKey:POST_FACEBOOK]
                 }
       success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if (completionHandler != nil)
             completionHandler([(NSDictionary *)responseObject dictionaryByReplacingNullsWithStrings],nil);
         
         else
         {
             if ( delegate != nil && [delegate respondsToSelector:@selector(VoyageUpRestAPIManagerdelegate:WithResponseDictionary:)] )
                 [delegate VoyageUpRestAPIManagerdelegate:self WithResponseDictionary:[(NSDictionary *)responseObject dictionaryByReplacingNullsWithStrings]];
             
         }
     }
       failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         //TODO: Show or handle error
         if (completionHandler != nil)
             completionHandler(nil,error);
         
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Some thing went to wrong, please try again later" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
         
         
     }
    showLoader:YES withText:@"Logging in.."
     ];
}
-(void)ChangePassword:(NSDictionary*)postobject  WithCompletionblock:(VoyageUpCompletionBlock)completionHandler
{
    
    [self POST:[HttpUtility getUrlWithPath:API_CHANGE_PASSWORD]
    parameters:@{
                 POST_OLD_PASSWORD:[postobject objectForKey:POST_OLD_PASSWORD],
                 POST_NEW_PASSWORD:[postobject objectForKey:POST_NEW_PASSWORD]
                 }
       success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if (completionHandler != nil)
             completionHandler([(NSDictionary *)responseObject dictionaryByReplacingNullsWithStrings],nil);
         
         else
         {
             if ( delegate != nil && [delegate respondsToSelector:@selector(VoyageUpRestAPIManagerdelegate:WithResponseDictionary:)] )
                 [delegate VoyageUpRestAPIManagerdelegate:self WithResponseDictionary:[(NSDictionary *)responseObject dictionaryByReplacingNullsWithStrings]];
             
         }
     }
       failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         //TODO: Show or handle error
         if (completionHandler != nil)
             completionHandler(nil,error);
         [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Some thing went to wrong, please try again later" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
         
     }
    showLoader:YES withText:@"Loading"
     ];
}
-(void)ProfileUpdate:(NSDictionary*)postobject AndPhoto:(UIImage*)photo WithCompletionblock:(VoyageUpCompletionBlock)completionHandler
{
    ProfileDetails *profile=[ProfileDetails getProfileDetails];
    profile.token = @"";
    [self addDefaultHeaders];
    [self POST:[HttpUtility getUrlWithPath:API_PROFILE_UPDATE]
    parameters:@{
                 POST_FIRSTNAME:[postobject objectForKey:POST_FIRSTNAME],
                 POST_LASTNAME:[postobject objectForKey:POST_LASTNAME],
                 POST_COUNTRY:[postobject objectForKey:POST_COUNTRY],
                 POST_DOB:[postobject objectForKey:POST_DOB],
                 POST_GENDER:[postobject objectForKey:POST_GENDER],
                 }
     
constructingBodyWithBlock:^(id <AFMultipartFormData>formData)
     {
         NSData *imageData = UIImageJPEGRepresentation(photo, 0.5);
         // UIImage *img = [UIImage imageWithData:imageData];
         
         if (imageData != nil)
             [formData appendPartWithFileData:imageData name:@"uploaded_file" fileName:@"photo.jpg" mimeType:@"image/jpeg"];//TODO: Fill photo name
     }
       success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if (completionHandler != nil)
             completionHandler([(NSDictionary *)responseObject dictionaryByReplacingNullsWithStrings],nil);
         
         else
         {
             if ( delegate != nil && [delegate respondsToSelector:@selector(VoyageUpRestAPIManagerdelegate:WithResponseDictionary:)] )
                 [delegate VoyageUpRestAPIManagerdelegate:self WithResponseDictionary:[(NSDictionary *)responseObject dictionaryByReplacingNullsWithStrings]];
             
         }
     }
       failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         //TODO: Show or handle error
         if (completionHandler != nil)
             completionHandler(nil,error);
         
         [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Some thing went to wrong, please try again later" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
         
     }
     
     ];
}
-(void)Forgotpassword:(NSDictionary*)postobject  WithCompletionblock:(VoyageUpCompletionBlock)completionHandler
{
    
    [self POST:[HttpUtility getUrlWithPath:API_FORGOT_PASSWORD]
    parameters:@{
                 POST_EMAIL:[postobject objectForKey:POST_EMAIL]
                 }
       success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if (completionHandler != nil)
             completionHandler([(NSDictionary *)responseObject dictionaryByReplacingNullsWithStrings],nil);
         
         else
         {
             if ( delegate != nil && [delegate respondsToSelector:@selector(VoyageUpRestAPIManagerdelegate:WithResponseDictionary:)] )
                 [delegate VoyageUpRestAPIManagerdelegate:self WithResponseDictionary:[(NSDictionary *)responseObject dictionaryByReplacingNullsWithStrings]];
             
         }
     }
       failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         //TODO: Show or handle error
         if (completionHandler != nil)
             completionHandler(nil,error);
         
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Some thing went to wrong, please try again later" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
         
     }
     
     ];
    
}

-(void)UpdateConnectionTypes:(NSDictionary*)postobject  WithCompletionblock:(VoyageUpCompletionBlock)completionHandler
{
    NSArray *array= [[NSArray alloc]initWithObjects:@"1",@"2",@"3", nil];
    NSString * timeSlots = [array componentsJoinedByString:@","];
    [self POST:[HttpUtility getUrlWithPath:API_UPDATE_CONNECTIONTYPES]
    parameters:@{
                 POST_CONNECTIONTYPE_ID:[postobject objectForKey:POST_CONNECTIONTYPE_ID]
                 }
       success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if (completionHandler != nil)
             completionHandler([(NSDictionary *)responseObject dictionaryByReplacingNullsWithStrings],nil);
         
         else
         {
             if ( delegate != nil && [delegate respondsToSelector:@selector(VoyageUpRestAPIManagerdelegate:WithResponseDictionary:)] )
                 [delegate VoyageUpRestAPIManagerdelegate:self WithResponseDictionary:[(NSDictionary *)responseObject dictionaryByReplacingNullsWithStrings]];
             
         }
     }
       failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         //TODO: Show or handle error
         if (completionHandler != nil)
             completionHandler(nil,error);
         
//         [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Some thing went to wrong, please try again later" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
         
     }
    showLoader:NO withText:@"Loading"
     ];
}

-(void)UpdateLocation:(NSDictionary*)postobject  WithCompletionblock:(VoyageUpCompletionBlock)completionHandler
{
    
    [self POST:[HttpUtility getUrlWithPath:API_POST_LOCATION]
    parameters:@{
                 POST_LATITUDE:[postobject objectForKey:POST_LATITUDE],
                 POST_LOGITUDE:[postobject objectForKey:POST_LOGITUDE],
                 POST_GEOFENCE_AREA:[postobject objectForKey:POST_GEOFENCE_AREA],
                 POST_DEVISE_ID:[postobject objectForKey:POST_DEVISE_ID],
                  POST_NETWORK_ID:[postobject objectForKey:POST_NETWORK_ID]
                 }
       success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if (completionHandler != nil)
             completionHandler([(NSDictionary *)responseObject dictionaryByReplacingNullsWithStrings],nil);
         
         else
         {
             if ( delegate != nil && [delegate respondsToSelector:@selector(VoyageUpRestAPIManagerdelegate:WithResponseDictionary:)] )
                 [delegate VoyageUpRestAPIManagerdelegate:self WithResponseDictionary:[(NSDictionary *)responseObject dictionaryByReplacingNullsWithStrings]];
             
         }
     }
       failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         //TODO: Show or handle error
         if (completionHandler != nil)
             completionHandler(nil,error);
         
//       [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Some thing went to wrong, please try again later" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
//         
     }
    showLoader:NO withText:@"Loading"
     ];
}
-(void)getUsers:(NSDictionary*)postobject  WithCompletionblock:(VoyageUpCompletionBlock)completionHandler
{
    
    [self POST:[HttpUtility getUrlWithPath:API_GET_USERS]
    parameters:@{
                 POST_LATITUDE:[postobject objectForKey:POST_LATITUDE],
                 POST_LOGITUDE:[postobject objectForKey:POST_LOGITUDE],
                 POST_GEOFENCE_AREA:[postobject objectForKey:POST_GEOFENCE_AREA]
                 }
       success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if (completionHandler != nil)
             completionHandler([(NSDictionary *)responseObject dictionaryByReplacingNullsWithStrings],nil);
         
         else
         {
             if ( delegate != nil && [delegate respondsToSelector:@selector(VoyageUpRestAPIManagerdelegate:WithResponseDictionary:)] )
                 [delegate VoyageUpRestAPIManagerdelegate:self WithResponseDictionary:[(NSDictionary *)responseObject dictionaryByReplacingNullsWithStrings]];
             
         }
     }
       failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         //TODO: Show or handle error
         if (completionHandler != nil)
             completionHandler(nil,error);
         
       //[[[UIAlertView alloc] initWithTitle:@"Error" message:@"Some thing went to wrong, please try again later" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
         
     }
    showLoader:NO withText:@"Loading"
     ];
}
-(void)getUsersWithOutAlert:(NSDictionary*)postobject  WithCompletionblock:(VoyageUpCompletionBlock)completionHandler
{
    
    [self POST:[HttpUtility getUrlWithPath:API_GET_USERS]
    parameters:@{
                 POST_LATITUDE:[postobject objectForKey:POST_LATITUDE],
                 POST_LOGITUDE:[postobject objectForKey:POST_LOGITUDE],
                 POST_GEOFENCE_AREA:[postobject objectForKey:POST_GEOFENCE_AREA]
                 }
       success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if (completionHandler != nil)
             completionHandler([(NSDictionary *)responseObject dictionaryByReplacingNullsWithStrings],nil);
         
         else
         {
             if ( delegate != nil && [delegate respondsToSelector:@selector(VoyageUpRestAPIManagerdelegate:WithResponseDictionary:)] )
                 [delegate VoyageUpRestAPIManagerdelegate:self WithResponseDictionary:[(NSDictionary *)responseObject dictionaryByReplacingNullsWithStrings]];
             
         }
     }
       failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         //TODO: Show or handle error
         if (completionHandler != nil)
             completionHandler(nil,error);
    
         
     }
    showLoader:NO withText:@"Loading"
     ];
}
-(void)getSingleUserDetails:(NSDictionary*)postobject  WithCompletionblock:(VoyageUpCompletionBlock)completionHandler
{
    
    [self POST:[HttpUtility getUrlWithPath:API_GET_SINGLE_USER]
    parameters:@{
                 USER_ID:[postobject objectForKey:USER_ID]
                 }
       success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if (completionHandler != nil)
             completionHandler([(NSDictionary *)responseObject dictionaryByReplacingNullsWithStrings],nil);
         
         else
         {
             if ( delegate != nil && [delegate respondsToSelector:@selector(VoyageUpRestAPIManagerdelegate:WithResponseDictionary:)] )
                 [delegate VoyageUpRestAPIManagerdelegate:self WithResponseDictionary:[(NSDictionary *)responseObject dictionaryByReplacingNullsWithStrings]];
             
         }
     }
       failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         //TODO: Show or handle error
         if (completionHandler != nil)
             completionHandler(nil,error);
         
         [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Some thing went to wrong, please try again later" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
     }
    showLoader:YES withText:@"Loading"
     ];
}
-(void)deleteMessage:(NSDictionary*)postobject  WithCompletionblock:(VoyageUpCompletionBlock)completionHandler
{
    
    [self POST:[HttpUtility getUrlWithPath:API_DELETE_MESSAGE]
    parameters:@{
                 USER_ID:[postobject objectForKey:USER_ID]
                 }
       success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if (completionHandler != nil)
             completionHandler([(NSDictionary *)responseObject dictionaryByReplacingNullsWithStrings],nil);
         
         else
         {
             if ( delegate != nil && [delegate respondsToSelector:@selector(VoyageUpRestAPIManagerdelegate:WithResponseDictionary:)] )
                 [delegate VoyageUpRestAPIManagerdelegate:self WithResponseDictionary:[(NSDictionary *)responseObject dictionaryByReplacingNullsWithStrings]];
             
         }
     }
       failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         //TODO: Show or handle error
         if (completionHandler != nil)
             completionHandler(nil,error);
         
         [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Some thing went to wrong, please try again later" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
     }
    showLoader:YES withText:@"Loading"
     ];
}
-(void)deleteMessageAutomatic:(NSDictionary*)postobject  WithCompletionblock:(VoyageUpCompletionBlock)completionHandler
{
    
    [self POST:[HttpUtility getUrlWithPath:API_DELETE_MESSAGE]
    parameters:@{
                 USER_ID:[postobject objectForKey:USER_ID]
                 }
       success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if (completionHandler != nil)
             completionHandler([(NSDictionary *)responseObject dictionaryByReplacingNullsWithStrings],nil);
         
         else
         {
             if ( delegate != nil && [delegate respondsToSelector:@selector(VoyageUpRestAPIManagerdelegate:WithResponseDictionary:)] )
                 [delegate VoyageUpRestAPIManagerdelegate:self WithResponseDictionary:[(NSDictionary *)responseObject dictionaryByReplacingNullsWithStrings]];
             
         }
     }
       failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         //TODO: Show or handle error
         if (completionHandler != nil)
             completionHandler(nil,error);
         
         
     }
    showLoader:NO withText:@"Loading"
     ];
}
-(void)Invite_Notification:(NSDictionary*)postobject  WithCompletionblock:(VoyageUpCompletionBlock)completionHandler
{
    
    [self POST:[HttpUtility getUrlWithPath:API_POST_INVITE]
    parameters:@{
                 @"notification_receiver":[postobject objectForKey:@"notification_receiver"],
                 POST_INVITE_TYPE:[postobject objectForKey:POST_INVITE_TYPE],
                 POST_INVITE_MESSAGE:[postobject objectForKey:POST_INVITE_MESSAGE]
                 }
       success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if (completionHandler != nil)
             completionHandler([(NSDictionary *)responseObject dictionaryByReplacingNullsWithStrings],nil);
         
         else
         {
             if ( delegate != nil && [delegate respondsToSelector:@selector(VoyageUpRestAPIManagerdelegate:WithResponseDictionary:)] )
                 [delegate VoyageUpRestAPIManagerdelegate:self WithResponseDictionary:[(NSDictionary *)responseObject dictionaryByReplacingNullsWithStrings]];
             
         }
     }
       failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         //TODO: Show or handle error
         if (completionHandler != nil)
             completionHandler(nil,error);
         
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Some thing went to wrong, please try again later" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
         
     }
    showLoader:YES withText:@"Loading"
     ];
}
-(void)ShareTable:(NSDictionary*)postobject  WithCompletionblock:(VoyageUpCompletionBlock)completionHandler
{
    
    [self POST:[HttpUtility getUrlWithPath:API_SHARE_TABLE]
    parameters:@{
                
                 POST_INVITE_TYPE:[postobject objectForKey:POST_INVITE_TYPE],
                 POST_INVITE_MESSAGE:[postobject objectForKey:POST_INVITE_MESSAGE]
                 }
       success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if (completionHandler != nil)
             completionHandler([(NSDictionary *)responseObject dictionaryByReplacingNullsWithStrings],nil);
         
         else
         {
             if ( delegate != nil && [delegate respondsToSelector:@selector(VoyageUpRestAPIManagerdelegate:WithResponseDictionary:)] )
                 [delegate VoyageUpRestAPIManagerdelegate:self WithResponseDictionary:[(NSDictionary *)responseObject dictionaryByReplacingNullsWithStrings]];
             
         }
     }
       failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         //TODO: Show or handle error
         if (completionHandler != nil)
             completionHandler(nil,error);
         
         [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Some thing went to wrong, please try again later" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
         
     }
    showLoader:YES withText:@"Loading"
     ];
}

-(void)ShareMyItem:(NSDictionary*)postobject   WithCompletionblock:(VoyageUpCompletionBlock)completionHandler
{
    
    [self POST:[HttpUtility getUrlWithPath:API_POST_SHARE_ITEM]
    parameters:@{
                 
                 @"Latitude":[postobject objectForKey:@"Latitude"],
                 @"Longitude":[postobject objectForKey:@"Longitude"],
                 @"FenceArea":[postobject objectForKey:@"FenceArea"],
                 POST_ITEM_NAME:[postobject objectForKey:POST_ITEM_NAME],
                 POST_SHARE_MESSAGE:[postobject objectForKey:POST_SHARE_MESSAGE],
                 }
       success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if (completionHandler != nil)
             completionHandler([(NSDictionary *)responseObject dictionaryByReplacingNullsWithStrings],nil);
         
         else
         {
             if ( delegate != nil && [delegate respondsToSelector:@selector(VoyageUpRestAPIManagerdelegate:WithResponseDictionary:)] )
                 [delegate VoyageUpRestAPIManagerdelegate:self WithResponseDictionary:[(NSDictionary *)responseObject dictionaryByReplacingNullsWithStrings]];
             
         }
     }
       failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         //TODO: Show or handle error
         if (completionHandler != nil)
             completionHandler(nil,error);
         
         [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Some thing went to wrong, please try again later" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
     }
    showLoader:YES withText:@"Loading"
     ];
}
-(void)GetAllSharesInMyArea:(NSDictionary*)postobject loader:(BOOL)loader WithCompletionblock:(VoyageUpCompletionBlock)completionHandler
{
    
    
    [self POST:[HttpUtility getUrlWithPath:API_GET_ALL_SHARES]
    parameters:@{
                 POST_LATITUDE:[postobject objectForKey:POST_LATITUDE],
                 POST_LOGITUDE:[postobject objectForKey:POST_LOGITUDE],
                 POST_GEOFENCE_AREA:[postobject objectForKey:POST_GEOFENCE_AREA],
                 }
       success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if (completionHandler != nil)
             completionHandler([(NSDictionary *)responseObject dictionaryByReplacingNullsWithStrings],nil);
         
         else
         {
             if ( delegate != nil && [delegate respondsToSelector:@selector(VoyageUpRestAPIManagerdelegate:WithResponseDictionary:)] )
                 [delegate VoyageUpRestAPIManagerdelegate:self WithResponseDictionary:[(NSDictionary *)responseObject dictionaryByReplacingNullsWithStrings]];
             
         }
     }
       failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         //TODO: Show or handle error
         if (completionHandler != nil)
             completionHandler(nil,error);
         [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Some thing went to wrong, please try again later" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
         
     }
    showLoader:loader withText:@"Loading"
     ];
}
-(void)PostQuestion:(NSDictionary*)postobject  WithCompletionblock:(VoyageUpCompletionBlock)completionHandler
{
    
    [self POST:[HttpUtility getUrlWithPath:API_POST_QUESTION]
    parameters:@{
                 POST_QUESTION:[postobject objectForKey:POST_QUESTION]
                 
                 }
       success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if (completionHandler != nil)
             completionHandler([(NSDictionary *)responseObject dictionaryByReplacingNullsWithStrings],nil);
         
         else
         {
             if ( delegate != nil && [delegate respondsToSelector:@selector(VoyageUpRestAPIManagerdelegate:WithResponseDictionary:)] )
                 [delegate VoyageUpRestAPIManagerdelegate:self WithResponseDictionary:[(NSDictionary *)responseObject dictionaryByReplacingNullsWithStrings]];
             
         }
     }
       failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         //TODO: Show or handle error
         if (completionHandler != nil)
             completionHandler(nil,error);
         
         [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Some thing went to wrong, please try again later" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
         
         
     }
    showLoader:YES withText:@"Loading"
     ];
}
-(void)GetQuestionById:(NSDictionary*)postobject  WithCompletionblock:(VoyageUpCompletionBlock)completionHandler
{
    
    [self POST:[HttpUtility getUrlWithPath:API_GET_QUESTIONBYID]
    parameters:@{
                 POST_QUESTION_ID:[postobject objectForKey:POST_QUESTION_ID]
                 }
       success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if (completionHandler != nil)
             completionHandler([(NSDictionary *)responseObject dictionaryByReplacingNullsWithStrings],nil);
         
         else
         {
             if ( delegate != nil && [delegate respondsToSelector:@selector(VoyageUpRestAPIManagerdelegate:WithResponseDictionary:)] )
                 [delegate VoyageUpRestAPIManagerdelegate:self WithResponseDictionary:[(NSDictionary *)responseObject dictionaryByReplacingNullsWithStrings]];
             
         }
     }
       failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         //TODO: Show or handle error
         if (completionHandler != nil)
             completionHandler(nil,error);
         
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Some thing went to wrong, please try again later" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
         
         
     }
    showLoader:YES withText:@"Loading"
     ];
}
-(void)PostAnswer:(NSDictionary*)postobject  WithCompletionblock:(VoyageUpCompletionBlock)completionHandler
{
    
    [self POST:[HttpUtility getUrlWithPath:API_POST_ANSWER]
    parameters:@{
                 POST_QUESTION_ID:[postobject objectForKey:POST_QUESTION_ID],
                 POST_ANSWER:[postobject objectForKey:POST_ANSWER]
                 }
       success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if (completionHandler != nil)
             completionHandler([(NSDictionary *)responseObject dictionaryByReplacingNullsWithStrings],nil);
         
         else
         {
             if ( delegate != nil && [delegate respondsToSelector:@selector(VoyageUpRestAPIManagerdelegate:WithResponseDictionary:)] )
                 [delegate VoyageUpRestAPIManagerdelegate:self WithResponseDictionary:[(NSDictionary *)responseObject dictionaryByReplacingNullsWithStrings]];
             
         }
     }
       failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         //TODO: Show or handle error
         if (completionHandler != nil)
             completionHandler(nil,error);
         
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Some thing went to wrong, please try again later" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
         
         
     }
    showLoader:YES withText:@"Loading"
     ];
}

#pragma mark get methods

-(void)GetConnectionList:(VoyageUpCompletionBlock)completionHandler
{
    
    
    [self GET:[HttpUtility getUrlWithPath:API_GET_CONNECTIONTYPES]
   parameters:nil
      success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if (completionHandler != nil)
             completionHandler([(NSDictionary *)responseObject dictionaryByReplacingNullsWithStrings],nil);
         
         else
         {
             if ( delegate != nil && [delegate respondsToSelector:@selector(VoyageUpRestAPIManagerdelegate:WithResponseDictionary:)] )
                 [delegate VoyageUpRestAPIManagerdelegate:self WithResponseDictionary:[(NSDictionary *)responseObject dictionaryByReplacingNullsWithStrings]];
             
         }
     }
      failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
//         [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Some thing went to wrong, please try again later" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
     }showLoader:NO withText:@"Loading.."
     ];
    
}
-(void)GetConnection_singleUser:(NSString*)userid :(VoyageUpCompletionBlock)completionHandler
{
    NSString *api=[API_GET_CONNECTIONTYPE_USER_ID stringByReplacingOccurrencesOfString:@"userid" withString:userid];
    
    [self GET:[HttpUtility getUrlWithPath:api]
   parameters:nil
      success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if (completionHandler != nil)
             completionHandler([(NSDictionary *)responseObject dictionaryByReplacingNullsWithStrings],nil);
         
         else
         {
             if ( delegate != nil && [delegate respondsToSelector:@selector(VoyageUpRestAPIManagerdelegate:WithResponseDictionary:)] )
                 [delegate VoyageUpRestAPIManagerdelegate:self WithResponseDictionary:[(NSDictionary *)responseObject dictionaryByReplacingNullsWithStrings]];
             
         }
     }
      failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
//         [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Some thing went to wrong, please try again later" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
     }showLoader:NO withText:@"Loading.."
     ];
    
}
-(void)GEtMyShares:(BOOL)loader :(VoyageUpCompletionBlock)completionHandler
{
    
    
    [self GET:[HttpUtility getUrlWithPath:API_GET_MY_SHARES]
   parameters:nil
      success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if (completionHandler != nil)
             completionHandler([(NSDictionary *)responseObject dictionaryByReplacingNullsWithStrings],nil);
         
         else
         {
             if ( delegate != nil && [delegate respondsToSelector:@selector(VoyageUpRestAPIManagerdelegate:WithResponseDictionary:)] )
                 [delegate VoyageUpRestAPIManagerdelegate:self WithResponseDictionary:[(NSDictionary *)responseObject dictionaryByReplacingNullsWithStrings]];
             
         }
     }
      failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Some thing went to wrong, please try again later" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
     }showLoader:loader withText:@"Loading.."
     ];
    
}
-(void)GetAllQuestions:(VoyageUpCompletionBlock)completionHandler
{
    
    
    [self GET:[HttpUtility getUrlWithPath:API_GET_ALL_QUESTIONS]
   parameters:nil
      success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if (completionHandler != nil)
             completionHandler([(NSDictionary *)responseObject dictionaryByReplacingNullsWithStrings],nil);
         
         else
         {
             if ( delegate != nil && [delegate respondsToSelector:@selector(VoyageUpRestAPIManagerdelegate:WithResponseDictionary:)] )
                 [delegate VoyageUpRestAPIManagerdelegate:self WithResponseDictionary:[(NSDictionary *)responseObject dictionaryByReplacingNullsWithStrings]];
             
         }
     }
      failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Some thing went to wrong, please try again later" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
     }showLoader:YES withText:@"Loading.."
     ];
    
}
-(void)GetMyQuestions:(VoyageUpCompletionBlock)completionHandler
{
    
    
    [self GET:[HttpUtility getUrlWithPath:API_GET_MY_QUESTIONS]
   parameters:nil
      success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if (completionHandler != nil)
             completionHandler([(NSDictionary *)responseObject dictionaryByReplacingNullsWithStrings],nil);
         
         else
         {
             if ( delegate != nil && [delegate respondsToSelector:@selector(VoyageUpRestAPIManagerdelegate:WithResponseDictionary:)] )
                 [delegate VoyageUpRestAPIManagerdelegate:self WithResponseDictionary:[(NSDictionary *)responseObject dictionaryByReplacingNullsWithStrings]];
             
         }
     }
      failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Some thing went to wrong, please try again later" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
     }showLoader:YES withText:@"Loading.."
     ];
    
}
-(void)GetAllNotifications:(BOOL)loader :(VoyageUpCompletionBlock)completionHandler
{
    
    
    [self GET:[HttpUtility getUrlWithPath:API_GET_ALL_NOTIFICATIONS]
   parameters:nil
      success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if (completionHandler != nil)
             completionHandler([(NSDictionary *)responseObject dictionaryByReplacingNullsWithStrings],nil);
         
         else
         {
             if ( delegate != nil && [delegate respondsToSelector:@selector(VoyageUpRestAPIManagerdelegate:WithResponseDictionary:)] )
                 [delegate VoyageUpRestAPIManagerdelegate:self WithResponseDictionary:[(NSDictionary *)responseObject dictionaryByReplacingNullsWithStrings]];
             
         }
     }
      failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Some thing went to wrong, please try again later" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
     }showLoader:loader withText:@"Loading.."
     ];
    
}

#pragma mark chat sessions

-(void)sendMessage:(NSDictionary*)postobject  WithCompletionblock:(VoyageUpCompletionBlock)completionHandler
{
    
    [self POST:[HttpUtility getUrlWithPath:API_POST_MESSAGE]
    parameters:@{
                 POST_CHAT_MESSAGE:[postobject objectForKey:POST_CHAT_MESSAGE],
                 POST_CHAT_RECEIVER_ID:[postobject objectForKey:POST_CHAT_RECEIVER_ID]
                 }
       success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if (completionHandler != nil)
             completionHandler([(NSDictionary *)responseObject dictionaryByReplacingNullsWithStrings],nil);
         
         else
         {
             if ( delegate != nil && [delegate respondsToSelector:@selector(VoyageUpRestAPIManagerdelegate:WithResponseDictionary:)] )
                 [delegate VoyageUpRestAPIManagerdelegate:self WithResponseDictionary:[(NSDictionary *)responseObject dictionaryByReplacingNullsWithStrings]];
             
         }
     }
       failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         //TODO: Show or handle error
         if (completionHandler != nil)
             completionHandler(nil,error);
         
        // [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Some thing went to wrong, please try again later" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
         
     }
    showLoader:NO withText:nil
     ];
}

-(void)GetLatestMessages:(VoyageUpCompletionBlock)completionHandler
{
    
    
    [self GET:[HttpUtility getUrlWithPath:API_GET_LATEST_MSGS]
   parameters:nil
      success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if (completionHandler != nil)
             completionHandler([(NSDictionary *)responseObject dictionaryByReplacingNullsWithStrings],nil);
         
         else
         {
             if ( delegate != nil && [delegate respondsToSelector:@selector(VoyageUpRestAPIManagerdelegate:WithResponseDictionary:)] )
                 [delegate VoyageUpRestAPIManagerdelegate:self WithResponseDictionary:[(NSDictionary *)responseObject dictionaryByReplacingNullsWithStrings]];
             
         }
     }
      failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Some thing went to wrong, please try again later" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
     }showLoader:NO withText:@"Loading.."
     ];
    
}
-(void)DeleteAllMessages:(VoyageUpCompletionBlock)completionHandler
{
    
    
    [self GET:[HttpUtility getUrlWithPath:API_DELETE_ALL_MESSAGES]
   parameters:nil
      success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if (completionHandler != nil)
             completionHandler([(NSDictionary *)responseObject dictionaryByReplacingNullsWithStrings],nil);
         
         else
         {
             if ( delegate != nil && [delegate respondsToSelector:@selector(VoyageUpRestAPIManagerdelegate:WithResponseDictionary:)] )
                 [delegate VoyageUpRestAPIManagerdelegate:self WithResponseDictionary:[(NSDictionary *)responseObject dictionaryByReplacingNullsWithStrings]];
             
         }
     }
      failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         
     }showLoader:NO withText:@"Loading.."
     ];
    
}
-(void)getAllMessagesFromSingleUser:(NSDictionary*)postobject  WithCompletionblock:(VoyageUpCompletionBlock)completionHandler
{
    
    [self POST:[HttpUtility getUrlWithPath:API_GET_ALL_SINGLE_USER_MSGS]
    parameters:@{
                 USER_ID:[postobject objectForKey:USER_ID],
                 }
       success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if (completionHandler != nil)
             completionHandler([(NSDictionary *)responseObject dictionaryByReplacingNullsWithStrings],nil);
         
         else
         {
             if ( delegate != nil && [delegate respondsToSelector:@selector(VoyageUpRestAPIManagerdelegate:WithResponseDictionary:)] )
                 [delegate VoyageUpRestAPIManagerdelegate:self WithResponseDictionary:[(NSDictionary *)responseObject dictionaryByReplacingNullsWithStrings]];
             
         }
     }
       failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         //TODO: Show or handle error
         if (completionHandler != nil)
             completionHandler(nil,error);
         
        // [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Some thing went to wrong, please try again later" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
         
     }
    showLoader:NO withText:nil
     ];
}

@end
