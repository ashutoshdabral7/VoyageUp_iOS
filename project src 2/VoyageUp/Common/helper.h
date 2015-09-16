//
//  helper.h
//  VoyageUp
//
//  Created by Deepak on 26/04/15.
//  Copyright (c) 2015 Deepak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"
#import "AppDelegate.h"

@interface helper : NSObject


+(BOOL)isNetworkAvailable;
+(void)ShowHome;
+ (UILabel *) SetNavTitle:(NSString *) title;
+(void)alertShowWithTitle:(NSString*)title  message:(NSString*)msg delegate:(id)delegate;
+(NSArray*)filterData:(NSString*)searchString fromArray:(NSArray*)array ;// method for filter content accordance with typing words
+(NSArray*)sortByTime:(NSArray*)array acending:(BOOL)state;
+(NSArray*)sortByName:(NSArray*)array acending:(BOOL)state;
+(NSArray*)sortByAnswred:(NSArray*)array acending:(BOOL)state;
+(NSURL*)getImageUrl:(NSString*)url;
/**
 *  to get a min frame required to occupied a given text
 *
 *  @param text     text
 *  @param fontsize text font size
 *  @param widhtF   to set a maximum width which can be affordable in the view.Sometime can't take the the entire width of the screen.
 *
 *  @return size
 */
+(NSString*)convertTimestamptoDateString:(NSString*)timeStampvalue;
+(NSDate*)convertTimestamptoDate:(NSString*)timeStampvalue;
+(CGSize)textFrame:(NSString*)text  fontSize:(CGFloat)fontsize widthFactor:(CGFloat)widhtF;
+(void)alertWarningWithTitle:(NSString*)title  message:(NSString*)msg delegate:(id)delegate;
+(void)addDoneButtonForTextFiled:(UITextField *)textField;
+(void)alertErrorWithTitle:(NSString*)title  message:(NSString*)msg delegate:(id)delegate;
+(void)alertErrorWithTitle1:(NSString*)title  message:(NSString*)msg delegate:(id)delegate;
+(void)ShowSuccessAlert:(id)controller withTitle:(NSString*)title withMessage:(NSString*)message;
+(void)ShowSuccessAlertWithTitle:(NSString*)title withMessage:(NSString*)message;
+ (UIImage *)imageWithColor:(UIColor *)color ;
+(NSArray*)intToStringArray:(NSArray*)array;
+(void)ShowErrorAlertWithTitle:(NSString*)title withMessage:(NSString*)message;
-(NSString*)getNetworkId;
+(NSString *) randomStringWithLength;
+(void)alertErrorUserLoad:(NSString*)title  message:(NSString*)msg delegate:(id)delegate;
@end
