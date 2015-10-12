//
//  helper.m
//  VoyageUp
//
//  Created by Deepak on 26/04/15.
//  Copyright (c) 2015 Erbauen Labs. All rights reserved.
//

#import "helper.h"
#import "SCLAlertView.h"
@implementation helper
+(BOOL)isNetworkAvailable
{
    
    Reachability* reach = [Reachability reachabilityWithHostname:@"www.google.com"];
    NetworkStatus networkStatus = [reach currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        return FALSE;
    } else {
        return  TRUE;
    }
    
}
+(void)ShowHome;
{
    AppDelegate* appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:STORYBOARD_MAIN bundle:nil];
    UIViewController* myStoryBoardInitialViewController = [storyboard instantiateInitialViewController];
    [appdelegate.window setRootViewController:myStoryBoardInitialViewController];
}
+ (UILabel *) SetNavTitle:(NSString *) title{
    UILabel *Label = [[UILabel alloc]initWithFrame:CGRectMake(0,0,50,40)];
    Label.text = title;
    Label.backgroundColor = [UIColor clearColor];
    Label.font = [UIFont fontWithName:FONT_MONT_REGULAR size:22];
    [Label setTextColor:COLOR_MAIN_BG];
    return Label;
}

+(NSArray*)filterData:(NSString*)searchString fromArray:(NSArray*)array
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.Question CONTAINS[c] %@",searchString];
    return [array filteredArrayUsingPredicate: predicate];
}
+(NSDate*)convertTimestamptoDate:(NSString*)timeStampvalue
{
    return [NSDate dateWithTimeIntervalSince1970:[timeStampvalue doubleValue]];
}
+(NSString*)convertTimestamptoDateString:(NSNumber*)timeStampvalue
{
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:[timeStampvalue doubleValue]];
    NSString *dateString = [NSDateFormatter localizedStringFromDate:date
                                                          dateStyle:NSDateFormatterShortStyle
                                                          timeStyle:NSDateFormatterFullStyle];
    return dateString;
    
}
-(NSTimeInterval)convertDatetoTimestamp:(NSDate*)date
{
    return [date timeIntervalSince1970];
}
+(NSURL*)getImageUrl:(NSString*)url
{
    NSString *path = [NSString stringWithFormat:@"%@%@",BASE_PHOTO_URL,url];
    NSString *pathNew= [path stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    return [NSURL URLWithString:pathNew];
}
+(CGSize)textFrame:(NSString*)text  fontSize:(CGFloat)fontsize widthFactor:(CGFloat)widhtF
{
    
    CGFloat width = 100;//[UIScreen mainScreen].bounds.size.width-widhtF;
    UIFont *font = [UIFont fontWithName:FONT_NAME size:fontsize];
    NSAttributedString *attributedText =
    [[NSAttributedString alloc]
     initWithString:text
     attributes:@
     {
     NSFontAttributeName: font
     }];
    CGRect rect = [attributedText boundingRectWithSize:(CGSize){width, CGFLOAT_MAX}
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    
    return rect.size;
}
+(void)addDoneButtonForTextFiled:(UITextField *)textField{
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:textField action:@selector(resignFirstResponder)];
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    //  [toolbar setBackgroundColor:[UIColor blueColor]];
    // [toolbar setBackgroundColor:[UIColor colorWithRed:34.0/255.0 green:107.0/255.0 blue:164.0/255.0 alpha:1.0]];
    // [toolbar setBackgroundImage:[UIImage imageNamed:@"search-bg.png"] forToolbarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefaultPrompt];
    
    
    toolbar.items = [NSArray arrayWithObject:barButton];
    textField.inputAccessoryView=toolbar;
}

#pragma mark alert

+(void)alertShowWithTitle:(NSString*)title  message:(NSString*)msg delegate:(id)delegate{
    
    //    UIAlertView *alertView= [[UIAlertView alloc]initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    //    [alertView show];
    SCLAlertView*  alert = [[SCLAlertView alloc]init];
    alert.shouldDismissOnTapOutside = YES;
    alert.showAnimationType = SlideInToCenter;
    [alert showSuccess:delegate title:title subTitle:msg closeButtonTitle:@"OK" duration:0.0f];
    
    
}
+(void)alertWarningWithTitle:(NSString*)title  message:(NSString*)msg delegate:(id)delegate{
    
    SCLAlertView*  alert = [[SCLAlertView alloc]init];
    alert.shouldDismissOnTapOutside = YES;
    alert.showAnimationType = SlideInToCenter;
    [alert showWarning:delegate title:@"warning" subTitle:msg closeButtonTitle:@"OK" duration:0.0f];
    
}
+(void)alertErrorWithTitle:(NSString*)title  message:(NSString*)msg delegate:(id)delegate{
    
   msg=@"An unexpected error occured. Please try again";
    SCLAlertView*  alert = [[SCLAlertView alloc]init];
    alert.shouldDismissOnTapOutside = YES;
    alert.showAnimationType = SlideInToCenter;
    [alert showError:delegate title:title subTitle:msg closeButtonTitle:@"OK" duration:0.0f];
    
}
+(void)alertErrorUserLoad:(NSString*)title  message:(NSString*)msg delegate:(id)delegate
{

    SCLAlertView*  alert = [[SCLAlertView alloc]init];
    alert.shouldDismissOnTapOutside = YES;
    alert.showAnimationType = SlideInToCenter;
    [alert showError:delegate title:title subTitle:msg closeButtonTitle:@"OK" duration:0.0f];
    
}
+(void)alertErrorWithTitle1:(NSString*)title  message:(NSString*)msg delegate:(id)delegate{
    
    msg=@"Usename or password incorrect or you are not verified your email id";
    SCLAlertView*  alert = [[SCLAlertView alloc]init];
    alert.shouldDismissOnTapOutside = YES;
    alert.showAnimationType = SlideInToCenter;
    [alert showError:delegate title:title subTitle:msg closeButtonTitle:@"OK" duration:0.0f];
    
}
+(void)ShowSuccessAlert:(id)controller withTitle:(NSString*)title withMessage:(NSString*)message
{
    // NSString *kInfoTitle = @"Change Password";
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    alert.shouldDismissOnTapOutside = YES;
    alert.showAnimationType = SlideInToCenter;
    
    [alert showSuccess:controller title:title subTitle:message closeButtonTitle:@"Ok" duration:0.0f];
}
+(void)ShowSuccessAlertWithTitle:(NSString*)title withMessage:(NSString*)message
{
    // NSString *kInfoTitle = @"Change Password";
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    alert.shouldDismissOnTapOutside = YES;
    alert.showAnimationType = SlideInToCenter;
    
    [alert showSuccess:title subTitle:message  closeButtonTitle:@"Ok" duration:0.0f];
}
+(void)ShowErrorAlertWithTitle:(NSString*)title withMessage:(NSString*)message
{
    // NSString *kInfoTitle = @"Change Password";
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    alert.shouldDismissOnTapOutside = YES;
    alert.showAnimationType = SlideInToCenter;
     [alert showError:nil title:title subTitle:message closeButtonTitle:@"OK" duration:0.0f];
   
}
+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
+(NSArray*)intToStringArray:(NSArray*)array
{
    NSMutableArray *new=[NSMutableArray new];
    for (int i=0; i<array.count; i++) {
        NSString *value=[NSString stringWithFormat:@"%@",[array objectAtIndex:i]];
        [new addObject:value];
    }
    return new;
}
-(NSString*)getNetworkId
{
    @try {
        //------- get network id
        
        NSArray *interfaceNames = CFBridgingRelease(CNCopySupportedInterfaces());
        
        NSLog(@"%s: Supported interfaces: %@", __func__, interfaceNames);
        
        
        
        NSDictionary *SSIDInfo;
        
        for (NSString *interfaceName in interfaceNames) {
            
            SSIDInfo = CFBridgingRelease(
                                         
                                         CNCopyCurrentNetworkInfo((__bridge CFStringRef)interfaceName));
            
            NSLog(@" --=> %@",SSIDInfo);
            
            BOOL isNotEmpty = (SSIDInfo.count > 0);
            
            if (isNotEmpty) {
               return [SSIDInfo valueForKey:@"SSID"];
                break;
                
            }
            
        }
       
        //----------------
    }
    @catch (NSException *exception) {
        return @"";
    }
}


+(NSString *) randomStringWithLength {
  NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: 6];
    
    for (int i=0; i<6; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform((uint32_t)[letters length])]];
    }
    
    return randomString;
}
@end
