//
//  Sharing&HelpingViewController.m
//  VoyageUp
//
//  Created by Deepak on 10/05/15.
//  Copyright (c) 2015 Erbauen Labs. All rights reserved.
//

#import "Sharing&HelpingViewController.h"

@interface Sharing_HelpingViewController ()

@end

@implementation Sharing_HelpingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    //------------****** navigation bar settings ---------
    self.navigationController.navigationBar.tintColor = COLOR_MAIN_BG_DARK;
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil]
     setTitleTextAttributes:
     @{NSForegroundColorAttributeName:COLOR_MAIN_BG_DARK,
       NSFontAttributeName:BARBUTTON_FONT
       }
     forState:UIControlStateNormal];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.titleView = [helper SetNavTitle:SCREEN_SHARING];
    //------------****** ---------
   //----------------- if previous date exist , show it first--------
    allSharesArray=[[DataStoreManager sharedDataStoreManager]getshareArray];
   allMySharesArray=[[DataStoreManager sharedDataStoreManager]getmyShareArray];
    [self SharedItems_Clicked:nil];
    
    if (allSharesArray.count>0)
        [self getAllShares:NO];
    else
        [self getAllShares:YES];
    
    [self GetMyShares:NO];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [self.tableView setSeparatorColor:COLOR_MAIN_BG];
    
    
}
-(void)viewDidDisappear:(BOOL)animated
{
   // [self.navigationController popToRootViewControllerAnimated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark api call  
-(void)getAllShares:(BOOL)loader
{
    ProfileDetails* profile=[ProfileDetails getProfileDetails];
     if([helper isNetworkAvailable])
    {
        NSDictionary *postobject = [NSDictionary dictionaryWithObjectsAndKeys:
                                    profile.latitude,POST_LATITUDE,
                                    profile.latitude,POST_LOGITUDE,
                                    profile.GeofenceArea,POST_GEOFENCE_AREA,
                                    nil];
        
        [[VoyageUpAPIManager sharedManager] GetAllSharesInMyArea:postobject loader:loader WithCompletionblock:^(NSDictionary*result,NSError *error)
         {
             @try {
                 
                 if ([[result valueForKeyPath:@"status"] isEqualToString:@"success"])
                 {
                     NSArray *questionsArrayTemp=[result valueForKeyPath:@"result"];
                     NSMutableArray *qnArray = [NSMutableArray new];
                     for (NSDictionary *pack in questionsArrayTemp)
                     {
                         [qnArray addObject:[Sharing shareDetails:pack]];
                     }
                     [[DataStoreManager sharedDataStoreManager] setshareArray:qnArray];
                     allSharesArray=[[DataStoreManager sharedDataStoreManager]getshareArray];
                     CurrentListArray=allSharesArray;
                     
                     
                     [self.tableView reloadData];
                 }
                 
             }
             @catch (NSException *exception){
                 
             }
             
         }];
        
        
        
    }else{
        
        [helper alertErrorWithTitle:nil message:NO_NETWORK_AVAILABLE delegate:self];
        [SVProgressHUD dismiss];
        
    }

}
-(void)GetMyShares:(BOOL)loader
{
    
    [[VoyageUpAPIManager sharedManager] GEtMyShares:loader  :^(NSDictionary*result,NSError *error) {
        
        if ([[result valueForKeyPath:@"status"] isEqualToString:@"success"])
        {
            
            NSArray *questionsArrayTemp=[result valueForKeyPath:@"result"];
            NSMutableArray *qnArray = [NSMutableArray new];
            for (NSDictionary *pack in questionsArrayTemp)
            {
                 [qnArray addObject:[Sharing shareDetails:pack]];
            }
            [[DataStoreManager sharedDataStoreManager] setmyShareArray:qnArray];
            allMySharesArray=[[DataStoreManager sharedDataStoreManager]getmyShareArray];
            if (myshare) 
                [self myShares:nil];
           // [self.tableView reloadData];
        
        }
    }];
    
    
}
-(void)shareNewItem:(NSString*)item messsage:(NSString*)message
{
    ProfileDetails* profile=[ProfileDetails getProfileDetails];
    if (item.length<1)
        [self makeMyshare:SHARE_ITEM_VALIDATION item:item message:message];
    else if ((message.length<1))
        [self makeMyshare:SHARE_ITEM_VALIDATION_MSG item:item message:message];
    else
    {
        
        NSDictionary *postobject = [NSDictionary dictionaryWithObjectsAndKeys:
                                    profile.latitude,@"Latitude",
                                    profile.latitude,@"Longitude",
                                    profile.GeofenceArea,@"FenceArea",
                                    item,POST_ITEM_NAME,
                                    message,POST_SHARE_MESSAGE,
                                    nil];
        
        [[VoyageUpAPIManager sharedManager] ShareMyItem:postobject WithCompletionblock:^(NSDictionary*result,NSError *error)
         {
             if (result != nil)
             {
                 
                 NSString *title = [result objectForKey:@"title"];
                 NSString *message = [result objectForKey:@"message"];
                 
                 if ([[result valueForKeyPath:@"status"] isEqualToString:@"success"])
                 {
                     [helper ShowSuccessAlert:self withTitle:title withMessage:message];
                     [self GetMyShares:NO];
                     
                 }
                 else
                 {
                     [[[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
                 }
             }
             
         }];
    }
    
}


#pragma mark button Action Methods
- (IBAction)SharedItems_Clicked:(id)sender {
    myshare=false;
    [btn_otherShares setBackgroundColor:[UIColor colorWithRed:58.0/255.0 green:55.0/255.0 blue:55.0/255.0 alpha:1.0]];
    [btn_otherShares setTitleColor:[UIColor colorWithRed:236.0/255.0 green:240.0/255.0 blue:241.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [btn_myShare setBackgroundColor:[UIColor colorWithRed:236.0/255.0 green:240.0/255.0 blue:241.0/255.0 alpha:1.0]];
    [btn_myShare setTitleColor:[UIColor colorWithRed:86.0/255.0 green:55.0/255.0 blue:67.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    CurrentListArray=allSharesArray;
    [self.tableView reloadData];
  }

- (IBAction)myShares:(id)sender {
    myshare=true;
    [btn_myShare setBackgroundColor:[UIColor colorWithRed:58.0/255.0 green:55.0/255.0 blue:55.0/255.0 alpha:1.0]];
    [btn_myShare setTitleColor:[UIColor colorWithRed:236.0/255.0 green:240.0/255.0 blue:241.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [btn_otherShares setBackgroundColor:[UIColor colorWithRed:236.0/255.0 green:240.0/255.0 blue:241.0/255.0 alpha:1.0]];
    [btn_otherShares setTitleColor:[UIColor colorWithRed:86.0/255.0 green:55.0/255.0 blue:67.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    CurrentListArray=allMySharesArray;
    [self.tableView reloadData];

}
-(IBAction)newShare:(id)sender
{
     [self makeMyshare:nil item:nil message:nil];
   }
-(void)makeMyshare:(NSString*)title item:(NSString*)name  message:(NSString*)msg
{
    NSString *kInfoTitle =@"Share your Item";
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    alert.shouldDismissOnTapOutside = YES;
    alert.showAnimationType = SlideInToCenter;
    UITextField* item = [alert addTextField:@"Enter item name"];
    item.autocorrectionType = UITextAutocorrectionTypeNo;
    item.delegate = self;
    item.tag=1;
    alert.backgroundViewColor=COLOR_MAIN_BG;
    UITextField* itemMessage = [alert addTextField:@"Leave a share message"];
    itemMessage.autocorrectionType = UITextAutocorrectionTypeNo;
    itemMessage.delegate = self;
    itemMessage.tag=2;
    
    if (name.length>0)
        item.text=name;
    if (msg.length>0)
        itemMessage.text=name;
    [alert addButton:@"Done" actionBlock:^(void) {
        
        [self shareNewItem:item.text messsage:itemMessage.text];
        
    }];
    [alert addButton:@"Cancel" actionBlock:^(void) {
        
    }];
    [alert showEdit:self title:kInfoTitle subTitle:title closeButtonTitle:Nil duration:0.0f];
    
    
}


#pragma mark - UITableViewDatasourse Methods
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    // This will create a "invisible" footer
    return 0.01f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==0)
        return 82;
    else
        return 49;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    if (section==0)
        return CurrentListArray.count;
    else
        if (CurrentListArray.count>0)
            return 0;
        else
            return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
    if (myshare) {
        static NSString *mainMenuCellIdentifier = @"mycell";
        SharingHelpingCell *cell = [tableView dequeueReusableCellWithIdentifier:mainMenuCellIdentifier];
        Sharing *share=[CurrentListArray objectAtIndex:indexPath.row];
        if (cell == nil)
            cell = [[SharingHelpingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mainMenuCellIdentifier];
        cell.lbl_itemName.text=share.itemName;
        cell.lbl_itemText.text=share.shareMessage;
        cell.imageView_item.image=nil;
        [cell.imageView_item setImageWithURL:[helper getImageUrl:share.SharedUserPhoto] placeholderImage:nil];
        
        return cell;
    }
    else
    {
    static NSString *mainMenuCellIdentifier = @"cell";
    SharingHelpingCell *cell = [tableView dequeueReusableCellWithIdentifier:mainMenuCellIdentifier];
    Sharing *share=[CurrentListArray objectAtIndex:indexPath.row];
    if (cell == nil)
        cell = [[SharingHelpingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mainMenuCellIdentifier];
    cell.lbl_itemName.text=share.itemName;
    cell.lbl_itemText.text=share.shareMessage;
    cell.imageView_item.image=nil;
    [cell.imageView_item setImageWithURL:[helper getImageUrl:share.SharedUserPhoto] placeholderImage:nil];
    
      return cell;
    }
    }
    else
    {
        static NSString *mainMenuCellIdentifier = @"empty";
        SharingHelpingCell *cell = [tableView dequeueReusableCellWithIdentifier:mainMenuCellIdentifier];
        return cell;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!myshare)
        [self showContact:indexPath];
}
#pragma mark show contact
-(void)showContact:(NSIndexPath*)indexPath
{
   Sharing *share=[CurrentListArray objectAtIndex:indexPath.row];
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    alert.shouldDismissOnTapOutside = YES;
    alert.showAnimationType = SlideInToCenter;
//    txt_shareMytable = [alert addTextField:@"Leave a message here"];
//    txt_shareMytable.delegate = self;
    alert.backgroundViewColor=COLOR_MAIN_BG;
    [alert addButton:@"Open chat" actionBlock:^(void) {
        
        [self openChat:share];
        
    }];
    [alert addButton:@"Cancel" actionBlock:^(void) {
        
        
        
    }];
    UIImageView *imageV=[UIImageView new];
    [imageV setImageWithURL:[helper getImageUrl:share.SharedUserPhoto]];
    UIImage *image=imageV.image;
    NSString *msg=[NSString stringWithFormat:@"This item belongs to %@, Would you like to send a message to %@ ?",share.FullName,share.FullName];
    
    [alert showCustom:self image:image color:COLOR_TEXT title:nil subTitle:msg closeButtonTitle:nil duration:0.0f];
}
-(void)openChat:(Sharing*)user
{
    ProfileDetails *profile=[ProfileDetails new];
    profile.FullName=user.FullName;
    profile.ProfilePhoto=user.SharedUserPhoto;
    profile.UserId=user.SharedUserId;
    
    VUChatMessageViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:SB_ID_Chat];
    vc.userProfile=profile;
    //vc.modalPresentationStyle= UIModalPresentationCustom;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - textfiled delegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSInteger nextTag = textField.tag + 1;
    // Try to find next responder
    UIResponder *nextResponder = [textField.superview viewWithTag:nextTag];
     if (nextResponder)
    {
        [textField resignFirstResponder];
        [nextResponder becomeFirstResponder];
    }
    else
    {
        [textField resignFirstResponder];
        
        return YES;
    }
    return YES;
}
- (void)dismissKeyboard {
    
    [self.view endEditing:YES];
}
@end
