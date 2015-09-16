//
//  Constants.h
//  VoyageUp
//
//  Created by Deepak on 30/04/15.
//  Copyright (c) 2015 Deepak. All rights reserved.
//

#ifndef VoyageUp_Constants_h
#define VoyageUp_Constants_h
#define ENVIRONMENT_LIVE        1
#define ENVIRONMENT_DEV         2
#define ENVIRONMENT ENVIRONMENT_DEV

#endif
// this is for nslog work only in debug mode
#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#   define DLog(...)
#endif
//http://opine.co.in/index.php/user/locationupdate
//#define BASE_URL                       @"http://opine.co.in/index.php/user/"
#define BASE_URL                       @"http://www.voyageup.com/index.php/user/"
#define BASE_PHOTO_URL                       @"http://www.voyageup.com/uploaded/"

#define PASSWORD_COUNT    5
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)


// API
#define API_SIGHNUP                     @"signup"
#define API_LOGIN                       @"login"
#define API_FORGOT_PASSWORD             @"forgotpassword"
#define API_CHANGE_PASSWORD             @"changepassword"
#define API_PROFILE_UPDATE              @"profileupdate"

#define API_GET_CONNECTIONTYPE_USER_ID   @"getuser_connections/userid"
#define API_GET_CONNECTIONTYPES          @"getmy_connections"
#define API_UPDATE_CONNECTIONTYPES       @"update_connections"
#define API_POST_LOCATION               @"locationupdate"
#define API_GET_USERS                   @"getall_users"
#define API_GET_SINGLE_USER             @"getuser"
#define API_POST_INVITE                 @"invite"
#define API_POST_SHARE_ITEM             @"sharemyitem"
#define API_GET_ALL_SHARES              @"getallshares"
#define API_GET_MY_SHARES               @"getmyshares"
#define API_SHARE_TABLE               @"sharemytable"

#define API_GET_MY_QUESTIONS            @"getmyquestion"
#define API_GET_ALL_QUESTIONS           @"getallquestion"
#define API_POST_QUESTION               @"postquestion"
#define API_GET_QUESTIONBYID            @"getquestionbyid"
#define API_POST_ANSWER                 @"postanswer"

#define API_GET_ALL_NOTIFICATIONS       @"getallnotification"


#define API_POST_MESSAGE                @"sendmessage"
#define API_GET_LATEST_MSGS            @"getalllatestmessages"
#define API_GET_ALL_SINGLE_USER_MSGS    @"getallmessage"
#define API_DELETE_MESSAGE             @"deleteMessage"






//POST VARIABLES
#define USER_ID                 @"user_id"
#define POST_FIRSTNAME        @"first_name"
#define POST_LASTNAME         @"last_name"
#define POST_EMAIL            @"email"
#define POST_CITY             @"city"
#define POST_COUNTRY          @"country"
#define POST_GENDER           @"gender"
#define POST_USERNAME         @"user_name"
#define POST_PASSWORD         @"password"
#define POST_FACEBOOK         @"facebook"
#define POST_LOGINTYPE        @"logintype"
#define POST_DOB              @"dateofbirth"
#define POST_DEVICE_ID        @"device_id"
#define POST_OLD_PASSWORD     @"current_password"
#define POST_NEW_PASSWORD     @"new_password"
#define POST_DEVICE_ID        @"device_id"
#define POST_GENDER            @"gender"

#define POST_CONNECTIONTYPE_ID          @"my_connection"
#define POST_LATITUDE                   @"latitude"
#define POST_LOGITUDE                   @"longitude"
#define POST_GEOFENCE_AREA              @"geofenceArea"
#define POST_DEVISE_ID                   @"device_id"
#define POST_NETWORK_ID              @"network_id"
#define POST_INVITE_TYPE                @"NotificationTitle"
#define POST_INVITE_MESSAGE             @"NotificationMessage"

#define INVITE_TABLE             @"sharetable"
#define INVITE_MEET             @"meet"
#define INVITE_COFFEE             @"coffee"


#define POST_ITEM_NAME              @"ItemName"
#define POST_ITEM_ID                @"item_id"
#define POST_SHARE_MESSAGE          @"share_message"

#define POST_QUESTION               @"question"
#define POST_QUESTION_ID            @"QuestionId"
#define POST_ANSWER                 @"answer"

#define POST_CHAT_MESSAGE           @"message"
#define POST_CHAT_SENDER_ID           @"sender_id"
#define POST_CHAT_RECEIVER_ID           @"receiver_id"


#define POST_SETTINGS_ELABORATION_AMOUNT        @"elaboration_amount"
#define POST_SETTINGS_APPLEPAY_USRN             @"applepay_username"
#define POST_SETTINGS_APPLEPAY_PSWD             @"applepay_password"

#define POST_MONTH              @"month"
#define POST_YEAR               @"year"
#define POST_TIMESLOT           @"time_slot"
#define POST_DATE               @"date"

//Storyboard

#define STORYBOARD_MAIN             @"Main"
#define SB_ID_LOGIN                 @"login"
//#define SB_ID_PROFILE               @"myprofile"
#define SB_ID_HOME                  @"home"
#define SB_ID_SIGNUP                @"SignUpViewController"
#define SB_ID_USER_DETAIL           @"UserDetailsViewController"
#define SB_ID_USER           @"userprofile"
#define SB_ID_MYCONNECTIONS         @"MyConnectionsViewController"
#define SB_ID_SETTINGS              @"AppSettingViewController"
#define SB_ID_MESSAGES              @"messages"
#define SB_ID_MESSAGLIST            @"messagelist"
#define SB_ID_SHAREING_HELPING      @"Sharing_HelpingViewController"
#define SB_ID_Q_A                   @"Q_A_ViewController"
#define SB_ID_CONTACT_LIST          @"ContactsListViewController"
#define SB_ID_NOTIFICATION          @"MyNotificationsViewController"
#define SB_ID_Chat                  @"Chat_ViewController"
#define SB_ID_PROFILE             @"MyProfileViewController"
#define SB_ID_CROPVIEW             @"photoCropViewController"
#define SB_ID_ANSWER             @"AnswerViewController"
#define SB_ID_COUNTRY          @"CountryLoaderController"

//screen title
#define SCREEN_ANSWER             @"Answers"
#define SCREEN_Q_A             @"My Q&A"
#define SCREEN_MESSAGE          @"New Message"
#define SCREEN_MESSAGE_LISTING  @"My Messages"
#define SCREEN_CONNECTIONS            @"My Connections"
#define SCREEN_SETTINGS              @"Settings"
#define SCREEN_SHARING              @"Sharing & Helping"
#define SCREEN_SETTINGS_TITLE              @"My Settings"
#define SCREEN_NOTIFICATIONS              @"My Notifications"
#define SCREEN_CHAT_TITLE              @"Chat"
#define SCREEN_MY_PROFILE              @"My Profile"
#define SCREEN_USER_PROFILE              @"Profile"
// ------ font name -----

#   define FONT_NAME  @"OpenSans"
#   define FONT_NEO_BOLD  @"NeoSans-Bold"
#   define FONT_MONT_REGULAR @"Montserrat-Regular"
#   define FONT_MONT_BOLD  @"Montserrat-Bold"
#   define FONT_MONT_LIGHT  @"Montserrat-Light"
#define BARBUTTON_FONT ((UIFont *)[UIFont fontWithName:@"Montserrat-Light" size:17])
#define IS_IPHONE_4 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )


#define    SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height
#define    STORYBOARD_4  [UIStoryboard storyboardWithName:@"storyBoard4" bundle:nil];
#define    STORYBOARDMAIN  [UIStoryboard storyboardWithName:@"Main" bundle:nil];
#define FRAME_BARBUTTON    CGRectMake(0, 0, 58, 21)
//alertbutton title
#define BUTTON_WILL_WAIT                 @"I will wait"
#define PHOTO_NIL         (UIImage *)[UIImage imageNamed:@"noimagesmall"]
//----- color codes----

#define CUSTOM_LIGHT_BLUE     [UIColor colorWithRed:0.0/255.0 green:112.0/255.0 blue:162.0/255.0 alpha:1.0]
#define CUSTOM_DARK_BLUE     [UIColor colorWithRed:0.0/255.0 green:112.0/255.0 blue:162.0/255.0 alpha:1.0]

#define ELABORATE_QN    [UIColor colorWithRed:95.0/255.0 green:114.0/255.0 blue:131.0/255.0 alpha:1.0]
#define COLOR_MAIN_BG    [UIColor colorWithRed:66.0/255.0 green:182.0/255.0 blue:160.0/255.0 alpha:1.0]
#define COLOR_TEXT    [UIColor colorWithRed:86.0/255.0 green:55.0/255.0 blue:67.0/255.0 alpha:1.0]
#define COLOR_CELL_SEPARATOR    [UIColor colorWithRed:236.0/255.0 green:240.0/255.0 blue:241.0/255.0 alpha:1.0]
#define COLOR_LINE_SEPARATOR    [UIColor colorWithRed:165.0/255.0 green:146.0/255.0 blue:152.0/255.0 alpha:1.0]
#define COLOR_MAIN_BG_DARK    [UIColor colorWithRed:29.0/255.0 green:89.0/255.0 blue:49.0/255.0 alpha:1.0]
#define COLOR_PHOTO_BORDER   [UIColor colorWithRed:236.0/255.0 green:240.0/255.0 blue:241.0/255.0 alpha:1.0];