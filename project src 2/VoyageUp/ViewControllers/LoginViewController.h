//
//  LoginViewController.h
//  VoyageUp
//
//  Created by Deepak on 03/05/15.
//  Copyright (c) 2015 Deepak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import <GooglePlus/GooglePlus.h>
#import <GoogleOpenSource/GoogleOpenSource.h>
#import "SignUpViewController.h"
@class GPPSignInButton;
@protocol loginSuccessDelegate <NSObject>
- (void)LoginSuccess;
@end
@interface LoginViewController : UIViewController<UITextFieldDelegate,GPPSignInDelegate,signupSuccessDelegate>
{
    IBOutlet UITextField *txt_passWord;
    IBOutlet UITextField *txt_userName;
    IBOutlet UIView *view_Login;
    IBOutlet UIButton *btn_signup;
    IBOutlet UIView *view_loginBg;
    UITapGestureRecognizer *tap;
    UITextField *txt_forgotPassword;
    CGFloat constrain_view;
}
@property (nonatomic, weak) id<loginSuccessDelegate> delegate;
@property (retain, nonatomic) IBOutlet GPPSignInButton *signInButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *verticalconstraint;
- (IBAction)signUp_clicked:(id)sender;
- (IBAction)login_clicked:(id)sender;
- (IBAction)forgotPassword:(id)sender;
- (IBAction)loginWithFacebook:(id)sender;
- (IBAction)loginWithGoogle:(id)sender;
@end
