//
//  UserDetailsViewController.h
//  VoyageUp
//
//  Created by Deepak on 11/05/15.
//  Copyright (c) 2015 Deepak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileDetails.h"
@interface UserDetailsViewController : UIViewController<UIActionSheetDelegate,UITextFieldDelegate>
{
    NSArray *userConnectionArray;
}
@property (strong, nonatomic) IBOutlet UIImageView *imageView_Photo;
@property (strong, nonatomic) IBOutlet UILabel *lbl_userName;
@property (strong, nonatomic) IBOutlet UILabel *lbl_dob;
@property (strong, nonatomic) IBOutlet UILabel *lbl_email;
@property (strong, nonatomic) IBOutlet UILabel *lbl_aboutme;
@property (strong, nonatomic) IBOutlet UILabel *lbl_connections;
@property (strong, nonatomic) IBOutlet UIButton *btn_chat;
@property (strong, nonatomic)NSString *user_id;
@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;
@property (strong, nonatomic)ProfileDetails *userProfile;
- (IBAction)ShowOptions:(id)sender;
- (IBAction)chat_Clicked:(id)sender;
@end
