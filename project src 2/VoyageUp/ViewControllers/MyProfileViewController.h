//
//  MyProfileViewController.h
//  VoyageUp
//
//  Created by Deepak on 26/04/15.
//  Copyright (c) 2015 Deepak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileDetails.h"
#import <AssetsLibrary/AssetsLibrary.h>

#import "UIImageView+AFNetworking.h"
#import <QuartzCore/QuartzCore.h>
#import "SCLAlertView.h"
#import "UITextField+padding.h"
#import "EMCCountryDelegate.h"
#import "EMCCountryPickerController.h"
#import "PECropViewController.h"
#import "UIImage+fixOrientation.h"
@interface MyProfileViewController : UIViewController<UIScrollViewDelegate,UITextFieldDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate,UIPickerViewDelegate, UIPickerViewDataSource,UIAlertViewDelegate,EMCCountryDelegate,PECropViewControllerDelegate>{
    BOOL deleteflag,callDeleteApi;
    long profilePhotoNumber;
    int editstatus; // 1= edit 2 = update  3 = Done
    UIButton *Editbutton;
    
    UIActionSheet *imageUpload ;
   
    UIToolbar *toolBar;
    BOOL isBeginEdited;
    BOOL photoEdit;
    BOOL edit;
    BOOL newPhoto;
    NSArray *connectionArray;
    NSArray *myConnectionArray;
}
@property (weak, nonatomic) ProfileDetails *profileDetails;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *verticalconstraint;
@property (strong, nonatomic) ALAssetsLibrary *library;
@property (strong, nonatomic) UIImagePickerController *imgPicker;
@property (strong,nonatomic) UITapGestureRecognizer *tap;
@property (strong, nonatomic)NSString *user_id;
//@property (weak, nonatomic) IBOutlet UIView *cropview;
@property (weak, nonatomic) IBOutlet UIView *top_view;

@property (weak, nonatomic) IBOutlet UIImageView *userImageView1;

@property (weak, nonatomic) IBOutlet UITextField *txt_Firstname;
@property (weak, nonatomic) IBOutlet UITextField *txt_Lastname;
@property (weak, nonatomic) IBOutlet UITextField *txt_Email;
@property (weak, nonatomic) IBOutlet UITextView *txt_dob;
@property (weak, nonatomic) IBOutlet UITextView *txt_Country;
@property (weak, nonatomic) IBOutlet UIButton *btn_chat;
@property (weak, nonatomic) IBOutlet UIButton *btn_ChangePassword;
@property (weak, nonatomic) IBOutlet UIButton *btn_profilePhoto;
@property (strong, nonatomic) IBOutlet UISwitch *switch_drink;
@property (strong, nonatomic) IBOutlet UISwitch *switch_help;

@property (strong, nonatomic) IBOutlet UISwitch *swith_Chat;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)btn_ChangePassord:(id)sender;

- (IBAction)CountryPicker:(id)sender;

- (IBAction)UpdateProfile:(id)sender;
@end
