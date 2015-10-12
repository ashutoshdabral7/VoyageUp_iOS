//
//  VUMenuViewController.m
//  VoyageUp
//
//  Created by Deepak on 26/04/15.
//  Copyright (c) 2015 Erbauen Labs. All rights reserved.
//

#import "VUMenuViewController.h"
#import "MyProfileViewController.h"
@interface VUMenuViewController ()

@end

@implementation VUMenuViewController
#pragma mark - loading Methods
-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        
        UIImage *logo = [UIImage imageNamed:@"logo"];
        logo = [logo imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImageView* imageView = [[UIImageView alloc] initWithImage:logo];
        self.navigationItem.titleView = imageView;
        
        
        
        
    }
    return self;
}
#pragma mark inital methods -----------
- (void)viewDidLoad {
    [super viewDidLoad];
    menuItems = [self getMenuItems];
    UIVisualEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame =CGRectMake(0,0,375,207);// self.blurImageView.frame;
    [self.blurImageView addSubview:effectView];
    self.photoImageView.layer.cornerRadius =80;// self.photoImageView.frame.size.width / 2;
    self.photoImageView.layer.masksToBounds = YES;
    UIColor *col=COLOR_PHOTO_BORDER;
    [self.photoImageView.layer setBorderColor: [col CGColor]];
    [self.photoImageView.layer setBorderWidth: 2.0];
    ;
    // Do any additional setup after loading the view.
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
//    ProfileDetails *profileDetails = [ProfileDetails getProfileDetails];
//    self.blurImageView.image=profileDetails.image_my;
//    self.photoImageView.image=profileDetails.image_my;
    self.tableView.contentSize = CGSizeMake(self.tableView.frame.size.width, (5*50)+10);
    [self.tableView setSeparatorColor:COLOR_TEXT];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
//*********************
- (NSArray *)getMenuItems
{
    return @[
             @"App Settings",
             //@"Share My Table",
             //@"Sharing and Helping",
             //@"My Q&A",
             // @"My Connection Type",
             //@"My Notifications",
             @"Sign Out",
             @"Change Password"
             ];
}
#pragma mark - UITableViewDatasourse Methods
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    // This will create a "invisible" footer
    return 0.01f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [menuItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *mainMenuCellIdentifier = @"cell";
    MenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mainMenuCellIdentifier];
    
    if (cell == nil)
        cell = [[MenuTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mainMenuCellIdentifier];
    
    [cell.lbl_menuTitle setText:menuItems[indexPath.row]];
    cell.lbl_menuTitle.textColor=COLOR_TEXT;
    cell.lbl_menuTitle.font = [UIFont fontWithName:FONT_NAME size:16];
    
    return cell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self selectMenutem:indexPath.row];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark action methods
-(void)selectMenutem:(int)item
{
    switch (item) {
        case 0:
        {
            AppSettingViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:SB_ID_SETTINGS];
            //vc.modalPresentationStyle= UIModalPresentationCustom;
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 100:
        {
            [self ShareMyTable:SHARE_TABLE_MSG];
            break;
        }
        case 1123:
        {
            Sharing_HelpingViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:SB_ID_SHAREING_HELPING];
            //vc.modalPresentationStyle= UIModalPresentationCustom;
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 300:
        {
            Q_A_ViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:SB_ID_Q_A];
            //vc.modalPresentationStyle= UIModalPresentationCustom;
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 311:
        {
            MyConnectionsViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:SB_ID_MYCONNECTIONS];
            //vc.modalPresentationStyle= UIModalPresentationCustom;
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 222:
        {
            MyNotificationsViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:SB_ID_NOTIFICATION];
            //vc.modalPresentationStyle= UIModalPresentationCustom;
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 1:
        {
            [self ShowLogin];
            break;
        }
        case 2:
        {
            [self btn_ChangePassord:nil];
            break;
        }
        default:
            break;
    }
    
    
}
-(void)ShowLogin{
    
    [self locationUpdate];
    [SSKeychain setPassword:@"" forService:@"username" account:@"VoyageUp"];
    [SSKeychain setPassword:@"" forService:@"password" account:@"VoyageUp"];
    [DataStoreManager saveUserName:@"" password:@""];
    UIStoryboard *sb;
    if (SCREEN_HEIGHT<=480)
        sb= [UIStoryboard storyboardWithName:@"storyBoard4" bundle:nil];
    else
        sb=self.storyboard;
    
    [ ProfileDetails ClearProfileData];
    [DataStoreManager ClearDataStoreManager];
    
    AppDelegate *appDelegate = (AppDelegate *)([UIApplication sharedApplication].delegate);
    appDelegate.Islogin=false;
    appDelegate.api_key=@"";
    
    LoginViewController *vc = [sb instantiateViewControllerWithIdentifier:SB_ID_LOGIN];
    vc.delegate=self;
   // vc.modalPresentationStyle= UIModalPresentationCustom;
    [self presentViewController:vc animated:YES completion:nil];
    
    
}
-(void)LoginSuccess
{
    AppDelegate *appDelegate = (AppDelegate *)([UIApplication sharedApplication].delegate);
    UITabBarController *tabBarController = (UITabBarController *)appDelegate.window.rootViewController;
    tabBarController.selectedIndex =0;
  
    
}
- (IBAction)takePhoto:(id)sender {
}
- (IBAction)editProfile:(id)sender
{
//    MyProfileViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:SB_ID_PROFILE];
//    [self.navigationController pushViewController:vc animated:YES];
    AppDelegate *appDelegate = (AppDelegate *)([UIApplication sharedApplication].delegate);
    UITabBarController *tabBarController = (UITabBarController *)appDelegate.window.rootViewController;
    tabBarController.selectedIndex =2;
    
}
#pragma mark  share my table
- (void)ShareMyTable:(NSString*)msg{
    
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    alert.shouldDismissOnTapOutside = YES;
    alert.showAnimationType = SlideInToCenter;
    txt_shareMytable = [alert addTextField:@"Leave a message here"];
    txt_shareMytable.delegate = self;
    alert.backgroundViewColor=COLOR_MAIN_BG;
    [alert addButton:@"Done" actionBlock:^(void) {
        
        [self shareMyTableApiCall:txt_shareMytable.text];
        
    }];
    [alert addButton:@"Cancel" actionBlock:^(void) {
        
        
        
    }];
    UIImage *image=[UIImage imageNamed:@"table"];
    // [alert showNotice:self title:kInfoTitle subTitle:nil closeButtonTitle:Nil duration:0.0f];
    
    [alert showCustom:self image:image color:COLOR_TEXT title:@"Share My Table" subTitle:msg closeButtonTitle:nil duration:0.0f];
}
-(void)shareMyTableApiCall:(NSString*)sender
{
    if (sender.length<1)
        [self ShareMyTable:SHARE_TABLE_VALIDATION_MSG];
    else
    {
        NSDictionary *postobject = [NSDictionary dictionaryWithObjectsAndKeys:
                                    @"Share table",POST_INVITE_TYPE,
                                    sender,POST_INVITE_MESSAGE,
                                    nil];
        
        [[VoyageUpAPIManager sharedManager] ShareTable:postobject WithCompletionblock:^(NSDictionary*result,NSError *error)
         {
             @try {
                 
                 if (result != nil)
                 {
                     
                     NSString *title = [result objectForKey:@"title"];
                     NSString *message = [result objectForKey:@"message"];
                     [helper ShowSuccessAlert:self withTitle:title withMessage:message];
                     
                 }
                 
             }
             @catch (NSException *exception){
                 
             }
             
         }];
        
        
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
#pragma mark change password
- (IBAction)btn_ChangePassord:(id)sender{
    
    NSString *kInfoTitle = @"Change Password";
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    alert.shouldDismissOnTapOutside = YES;
    //alert.showAnimationType = SlideInToCenter;
    alert.backgroundViewColor=COLOR_MAIN_BG;
    oldpassword = [alert addTextField:@"Current Password"];
    oldpassword.delegate = self;
    oldpassword.text=oldpass;
    [oldpassword setSecureTextEntry:true];
    newpassword = [alert addTextField:@"New Password"];
    newpassword.delegate = self;
    newpassword.text = newpass;
    [newpassword setSecureTextEntry:true];
    confirmpassword = [alert addTextField:@"Confirm Password"];
    confirmpassword.delegate = self;
    confirmpassword.text = confirmpass;
    [confirmpassword setSecureTextEntry:true];
    [alert addButton:@"Done" actionBlock:^(void) {
        
        [self changepassword];
        
    }];
    [alert addButton:@"Cancel" actionBlock:^(void) {
        
        newpass= @"";
        oldpass=@"";
        confirmpass=@"";
        
    }];
    [alert showEdit:self title:kInfoTitle subTitle:nil closeButtonTitle:Nil duration:0.0f];
    
}
- (void)changepassword
{
    
    if([self ValidateChangePassword])
    {
        
        NSDictionary *postobject = [NSDictionary dictionaryWithObjectsAndKeys:
                                    oldpassword.text,POST_OLD_PASSWORD,
                                    confirmpassword.text,POST_NEW_PASSWORD,
                                    nil];
        
        [[VoyageUpAPIManager sharedManager] ChangePassword:postobject WithCompletionblock:^(NSDictionary*result,NSError *error)
         {
             
             NSString *title = [result objectForKey:@"title"];
             NSString *message = [result objectForKey:@"message"];
             
             if ([[result valueForKeyPath:@"status"] isEqualToString:@"success"])
                 [helper ShowSuccessAlert:self withTitle:title withMessage:message];
             else
                 [helper ShowErrorAlertWithTitle:title withMessage:message];
             
             
         }];
    }
}
-(BOOL)ValidateChangePassword{
    
    oldpass = oldpassword.text;
    newpass = newpassword.text;
    confirmpass = confirmpassword.text;
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    alert.shouldDismissOnTapOutside = YES;
    alert.showAnimationType = SlideInToCenter;
    [alert addButton:@"Ok" target:self selector:@selector(ValidateOkButton)];
    long pcount = newpass.length;
    
    if (![InputValidator validateMandatoryFields:oldpass])
    {
        [alert showWarning:self title:@"Warning" subTitle:VALIDATION_PASSWORD_OLD closeButtonTitle:Nil duration:0.0f];
        return false;
        
    }else if (![InputValidator validateMandatoryFields:newpass])
    {
        [alert showWarning:self title:@"Warning" subTitle:VALIDATION_PASSWORD_NEW closeButtonTitle:Nil duration:0.0f];
        return false;
    }
    else if(pcount < PASSWORD_COUNT)
    {
        [alert showWarning:self title:@"Warning" subTitle:VALIDATION_PASSWORD_COUNT closeButtonTitle:Nil duration:0.0f];
        return false;
    }
    else if (![InputValidator validateMandatoryFields:confirmpass])
    {
        [alert showWarning:self title:@"Warning" subTitle:VALIDATION_PASSWORD_CONFIRM closeButtonTitle:Nil duration:0.0f];
        return false;
    }
    else if (![newpass isEqualToString:confirmpass]) {
        [alert showWarning:self title:@"Warning" subTitle:VALIDATION_PASSWORD_MISMATCH closeButtonTitle:Nil duration:0.0f];
        return false;
    }
    else if ([oldpass isEqualToString:newpass]) {
        [alert showWarning:self title:@"Warning" subTitle:VALIDATION_PASSWORD_SAME closeButtonTitle:Nil duration:0.0f];
        return false;
    }
    return true;
    
}
-(void)ValidateOkButton{
    
    [self btn_ChangePassord:nil];
    
    
}
- (void)locationUpdate{
    
    @try
    {
        
 
        NSDictionary *postobject = [NSDictionary dictionaryWithObjectsAndKeys:
                                    @"",POST_LATITUDE,
                                    @"",POST_LOGITUDE,
                                    @"",POST_GEOFENCE_AREA,
                                    @"",POST_DEVISE_ID,
                                    @"", POST_NETWORK_ID,
                                    nil];
        
        [[VoyageUpAPIManager sharedManager] UpdateLocation:postobject WithCompletionblock:^(NSDictionary*result,NSError *error)
         {
             
             
         }];
    }
    @catch (NSException *exception)
    {
        
    }
}

@end
