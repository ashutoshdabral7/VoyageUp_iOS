//
//  SignUpViewController.h
//  VoyageUp
//
//  Created by Deepak on 09/05/15.
//  Copyright (c) 2015 Deepak. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "EMCCountryDelegate.h"
#import "EMCCountryPickerController.h"
@protocol signupSuccessDelegate <NSObject>
@optional
- (void)signUpSuccess:(NSString *)usrName pswd:(NSString*)pswd autologin:(BOOL)status;
@end
@class GPPSignInButton;
@interface SignUpViewController : UIViewController<GPPSignInDelegate,EMCCountryDelegate>
{
     UITapGestureRecognizer *tap;
    IBOutlet UITextField *txt_firstName;
    IBOutlet UITextField *txt_secondName;
    IBOutlet UITextField *txt_email;
    IBOutlet UITextField *txt_age;
    IBOutlet UITextField *txt_password;
    IBOutlet UITextField *txt_confirmPassword;
    IBOutlet UITextField *txt_country;
 
    UIToolbar *toolBar;
    BOOL autoLogin;
    NSString *fbEmail;
}
- (IBAction)signUp_Clicked:(id)sender;
- (IBAction)signUpWithFB:(id)sender;
- (IBAction)signUpWithGoogle:(id)sender;
- (IBAction)dismissView:(id)sender;
@property (weak,nonatomic) id<signupSuccessDelegate> delegate;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constrint_ScrollViewHeight;
@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;
@property (retain, nonatomic) IBOutlet GPPSignInButton *signInButton;
@end
