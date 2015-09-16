//
//  MyNotificationsViewController.m
//  VoyageUp
//
//  Created by Deepak on 13/05/15.
//  Copyright (c) 2015 Deepak. All rights reserved.
//

#import "MyNotificationsViewController.h"

@interface MyNotificationsViewController ()

@end

@implementation MyNotificationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    notificationArray=[[DataStoreManager sharedDataStoreManager]getmyNotificationArray];
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
    self.navigationItem.titleView = [helper SetNavTitle:SCREEN_NOTIFICATIONS];
    //------------****** ---------
//    if (notificationArray.count>0)
//        [self getallNotifications:NO];
//    else
//       [self getallNotifications:YES];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [self.tableView setSeparatorColor:COLOR_MAIN_BG];
    
    
}
-(void)viewDidDisappear:(BOOL)animated
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark api call
-(void)getallNotifications:(BOOL)loader
{
    
    if([helper isNetworkAvailable])
    {
        [[VoyageUpAPIManager sharedManager] GetAllNotifications:loader :^(NSDictionary*result,NSError *error) {
            
            if ([[result valueForKeyPath:@"status"] isEqualToString:@"success"])
            {
                
                NSArray *questionsArrayTemp=[result valueForKeyPath:@"result"];
                NSMutableArray *qnArray = [NSMutableArray new];
                for (NSDictionary *pack in questionsArrayTemp)
                {
                    [qnArray addObject:[Notification NotificationDictionary:pack]];
                }
                [[DataStoreManager sharedDataStoreManager] setmyNotificationArray:qnArray];
                notificationArray=[[DataStoreManager sharedDataStoreManager]getmyNotificationArray];
                               [self.tableView reloadData];
            }
        }];
        
    }else{
        
        [helper alertErrorWithTitle:nil message:NO_NETWORK_AVAILABLE delegate:self];
        [SVProgressHUD dismiss];
        
    }
    
}
#pragma mark - UITableViewDatasourse Methods
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    // This will create a "invisible" footer
    return 0.01f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    if (indexPath.section==0)
        return 97;
    else
        return 45;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0)
    return notificationArray.count;
    else
        if (notificationArray.count>0)
            return 0;
        else
            return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    if (indexPath.section==0) {
   
    static NSString *mainMenuCellIdentifier = @"cell";
    NotificationCell *cell = [tableView dequeueReusableCellWithIdentifier:mainMenuCellIdentifier];
    
    if (cell == nil)
        cell = [[NotificationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mainMenuCellIdentifier];
    Notification *user=[notificationArray objectAtIndex:indexPath.row];
        cell.lbl_Notification.text=user.NotificationMessage;
    cell.lbl_User.text=user.sendrFullName;
    cell.lbl_postDate.text=user.Date;
    cell.imageView_item.image=PHOTO_NIL;
     [cell.imageView_item setImageWithURL:[helper getImageUrl:user.senderProfilePhoto]];
    //    cell.imageView_userPhoto.layer.cornerRadius = cell.imageView_userPhoto.frame.size.width/2;
    //    cell.imageView_userPhoto.layer.masksToBounds = YES;
    CALayer * l = [cell.imageView_item layer];
    [l setMasksToBounds:YES];
    [l setCornerRadius:28];
      return cell;
        
    }
    else
    {
        static NSString *mainMenuCellIdentifier = @"empty";
        NotificationCell *cell = [tableView dequeueReusableCellWithIdentifier:mainMenuCellIdentifier];
        
        if (cell == nil)
            cell = [[NotificationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mainMenuCellIdentifier];
       
        return cell;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
