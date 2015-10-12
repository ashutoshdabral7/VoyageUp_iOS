//
//  VUContactsViewController.m
//  VoyageUp
//
//  Created by Deepak on 26/04/15.
//  Copyright (c) 2015 Erbauen Labs. All rights reserved.
//

#import "VUContactsViewController.h"
#import "VUChatMessageViewController.h"

@interface VUContactsViewController ()

@end

@implementation VUContactsViewController

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

#pragma mark inital methods-------
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [self.tableView setSeparatorColor:COLOR_TEXT];
    latestMessagesArray=[[DataStoreManager sharedDataStoreManager]getLatestMessagesArray];
    [self.tableView reloadData];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
   if (appDelegate.Islogin)
    [self GetLatestMessages];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
#pragma mark api call

-(void)GetLatestMessages
{
   
        [[VoyageUpAPIManager sharedManager] GetLatestMessages:^(NSDictionary*result,NSError *error) {
            
         if ([[result valueForKeyPath:@"status"] isEqualToString:@"success"])
            {
                
                NSArray *questionsArrayTemp=[result valueForKeyPath:@"result"];
                NSMutableArray *qnArray = [NSMutableArray new];
                AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                NSString *netWorkID=appDelegate.network_token;
                for (NSDictionary *pack in questionsArrayTemp)
                {
                    ProfileDetails *profile=[ProfileDetails profileDetails:pack];
                   
                   if ([profile.network_ID isEqualToString:netWorkID]) {
                       [qnArray addObject:[latestMessages latestMessagesDictonery:pack]];
                   }
                    
                   
                }
                [[DataStoreManager sharedDataStoreManager] setLatestMessagesArray:qnArray];
                latestMessagesArray=[[DataStoreManager sharedDataStoreManager]getLatestMessagesArray];
                [self.tableView reloadData];
            }
        }];
        
        
}

#pragma mark - UITableViewDatasourse Methods
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    // This will create a "invisible" footer
    return 0.01f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    return 80;
    else
        return 49;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
   
    if (section==0)
        return latestMessagesArray.count;
    else
        if (latestMessagesArray.count>0)
            return 0;
        else
            return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
      static NSString *mainMenuCellIdentifier = @"cell";
    ContactsCell *cell = [tableView dequeueReusableCellWithIdentifier:mainMenuCellIdentifier];
    
    if (cell == nil)
        cell = [[ContactsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mainMenuCellIdentifier];
    latestMessages *user=[latestMessagesArray objectAtIndex:indexPath.row];
    cell.lbl_userName.text=user.FullName;
    cell.lbl_lastMessage.text=user.messageText;
//    if (user.image_my!=nil)
        cell.imageView_userPhoto.image=PHOTO_NIL;
    [cell.imageView_userPhoto setImageWithURL:[helper getImageUrl:user.ProfilePhoto]];
//    cell.imageView_userPhoto.layer.borderColor = COLOR_MAIN_BG_DARK.CGColor;
//    cell.imageView_userPhoto.layer.borderWidth = .0f;
    CALayer * l = [cell.imageView_userPhoto layer];
    [l setMasksToBounds:YES];
    [l setCornerRadius:28];
      return cell;
    }
    else
    {
        static NSString *mainMenuCellIdentifier = @"empty";
        ContactsCell *cell = [tableView dequeueReusableCellWithIdentifier:mainMenuCellIdentifier];
        
        if (cell == nil)
            cell = [[ContactsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mainMenuCellIdentifier];
        return cell;
        
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProfileDetails *user=[latestMessagesArray objectAtIndex:indexPath.row];
   VUChatMessageViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:SB_ID_Chat];
  
    vc.userProfile=user;
 
    [self.navigationController pushViewController:vc animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
