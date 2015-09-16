//
//  UserDetailsViewController.m
//  VoyageUp
//
//  Created by Deepak on 11/05/15.
//  Copyright (c) 2015 Deepak. All rights reserved.
//

#import "UserDetailsViewController.h"

@interface UserDetailsViewController ()

@end

@implementation UserDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self setView];
    
    //------------****** navigation bar settings ---------
    self.navigationController.navigationBar.tintColor = COLOR_MAIN_BG_DARK;
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil]
     setTitleTextAttributes:
     @{NSForegroundColorAttributeName:COLOR_MAIN_BG_DARK,
       NSFontAttributeName:BARBUTTON_FONT
       }
     forState:UIControlStateNormal];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.titleView = [helper SetNavTitle:SCREEN_USER_PROFILE];
    //------------****** ---------
    
}
- (void)viewDidLayoutSubviews
{
    //[self.scrollView setContentSize:CGSizeMake(0, (isBeginEdited) ? ((IS_IPHONE_4) ? 0 : 920) : ((IS_IPHONE_4) ? 0 : 920))];
    [self.ScrollView setContentSize:CGSizeMake(289, 380)];
}
-(void)setView
{
   
    [self getMyConnections];
    self.lbl_userName.text=self.userProfile.FullName;
    self.lbl_dob.text=[NSString stringWithFormat:@"Need a Help: %@",(self.userProfile.dob.length>0?self.userProfile.dob:@"NA")];
    self.lbl_email.text=self.userProfile.Email;
    self.lbl_aboutme.text=self.userProfile.Country;
   // self.imageView_Photo.image=self.userProfile.image_my;
     [self.imageView_Photo setImageWithURL:[helper getImageUrl:self.userProfile.ProfilePhoto]];
    self.imageView_Photo.layer.cornerRadius = 60;
    self.imageView_Photo.layer.masksToBounds = YES;
    self.imageView_Photo.clipsToBounds = YES;
    self.btn_chat.layer.cornerRadius=30;
    self.btn_chat.clipsToBounds=YES;
    [self.btn_chat.layer setBorderColor:[COLOR_MAIN_BG CGColor]];
    [self.btn_chat.layer setBorderWidth: 2.0];
    
}

#pragma mark api calls
-(void)GetUserById:(NSString *)questionid{
    NSDictionary *postobject = [NSDictionary dictionaryWithObjectsAndKeys:
                                questionid,USER_ID,
                                nil];
    
    [[VoyageUpAPIManager sharedManager] getSingleUserDetails:postobject WithCompletionblock:^(NSDictionary*result,NSError *error)
     {
         @try {
             
             if (result != nil)
             {
                 //                 NSDictionary*  question=[result valueForKeyPath:@"result"];
                 //                 selectedQn=[Questions questionsDictionary:question];
                 //                 cellCount=(int)selectedQn.allAnswers.count;
                 //                 self.question=selectedQn.Question;
                 //                 self.txt_answer.text=@"";
                 //                 [_tableview reloadData];
             }
             
         }
         @catch (NSException *exception){
             
             
         }
         
     }];
}

#pragma mark  share my table
- (void)Invite:(NSString*)msg type:(NSString*)type{
    
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    alert.shouldDismissOnTapOutside = YES;
    alert.showAnimationType = SlideInToCenter;
   UITextField* txt_shareMytable = [alert addTextField:@"Leave a message here"];
    txt_shareMytable.autocorrectionType = UITextAutocorrectionTypeNo;
    txt_shareMytable.delegate = self;
    alert.backgroundViewColor=COLOR_MAIN_BG;
    [alert addButton:@"Done" actionBlock:^(void) {
        
        [self shareMyTableApiCall:txt_shareMytable.text type:type];
        
    }];
    [alert addButton:@"Cancel" actionBlock:^(void) {
        
        
        
    }];
    UIImage *image=[UIImage imageNamed:type];
    // [alert showNotice:self title:kInfoTitle subTitle:nil closeButtonTitle:Nil duration:0.0f];
    
    [alert showCustom:self image:image color:COLOR_TEXT title:type subTitle:msg closeButtonTitle:nil duration:0.0f];
}
-(void)shareMyTableApiCall:(NSString*)message type:(NSString*)type
{
    if (message.length<1)
        [self Invite:SHARE_TABLE_VALIDATION_MSG type:type];
    else
    {
        NSDictionary *postobject = [NSDictionary dictionaryWithObjectsAndKeys:
                                    self.user_id,@"notification_receiver",
                                    type,POST_INVITE_TYPE,
                                    POST_INVITE_MESSAGE,POST_INVITE_MESSAGE,
                                    nil];
        
        [[VoyageUpAPIManager sharedManager] Invite_Notification:postobject WithCompletionblock:^(NSDictionary*result,NSError *error)
         {
             @try {
                 
                 NSString *title = [result objectForKey:@"title"];
                 NSString *message = [result objectForKey:@"message"];
                 
                 if ([[result valueForKeyPath:@"status"] isEqualToString:@"success"])
                 {
                     [helper ShowSuccessAlert:self withTitle:title withMessage:message];
                     
                 }
                 
             }
             @catch (NSException *exception){
                 
             }
             
         }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)chat_Clicked:(id)sender
{
    VUChatMessageViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:SB_ID_Chat];
    
    vc.userProfile=self.userProfile;
    //vc.modalPresentationStyle= UIModalPresentationCustom;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)ShowOptions:(id)sender {
    
  UIActionSheet*  actionSheet = [[UIActionSheet alloc]
                   initWithTitle:nil
                   delegate:self
                   cancelButtonTitle:@"Cancel"
                   destructiveButtonTitle:(nil)
                   otherButtonTitles:@"Chat",@"Invite to Meet",@"Invite for a Coffee", nil];

    [actionSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0)
    {
        VUChatMessageViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:SB_ID_Chat];
        
        vc.userProfile=self.userProfile;
        //vc.modalPresentationStyle= UIModalPresentationCustom;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    if (buttonIndex == 1)
    {
        [self Invite:[NSString stringWithFormat:@"Are you sure want to meet %@ ?",self.userProfile.FullName] type:INVITE_MEET];
    }
    if (buttonIndex == 2)
    {
         [ self Invite:[NSString stringWithFormat:@"Are you sure want to invite %@ for a coffee?",self.userProfile.FullName] type:INVITE_COFFEE];
      }
}
#pragma mark - textfiled delegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)dismissKeyboard {
    
    [self.view endEditing:YES];
}
-(void)getMyConnections
{
    @try {
    
    [[VoyageUpAPIManager sharedManager] GetConnection_singleUser:self.user_id  :^(NSDictionary*result,NSError *error) {
        
        
        NSArray *questionsArrayTemp=[result valueForKeyPath:@"all_connections"];
        NSMutableArray *myConnectionsArray=[result valueForKeyPath:@"my_connections"];
        NSMutableArray *qnArray = [NSMutableArray new];
        for (NSDictionary *pack in questionsArrayTemp)
        {
            [qnArray addObject:[connectionItems connectionDictionary:pack]];
        }
        
        [self setConnections:[helper intToStringArray:myConnectionsArray]];
        
        
    }];
    }
    @catch (NSException *exception) {
        
    }
    
    
}
-(void)setConnections:(NSArray*)array
{
    @try {
   
    if (array.count>0 &&( [array containsObject:@"1"]||[array containsObject:@"2"])) {
    
    NSMutableString *connection=  [NSMutableString string];
         [connection appendString:@"Connections: "];
    if ([array containsObject:@"1"])
        [connection appendString:@"Chat,"];
    
    if ([array containsObject:@"2"])
        [connection appendString:@" Meet for a drink"];
     
        self.lbl_connections.text=connection;
        
    }
    }
    @catch (NSException *exception) {
        
    }
    
}
@end
