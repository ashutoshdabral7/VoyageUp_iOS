//
//  ContactsListViewController.m
//  VoyageUp
//
//  Created by Deepak on 11/05/15.
//  Copyright (c) 2015 Deepak. All rights reserved.
//
#import "MyProfileViewController.h"
#import "ContactsListViewController.h"

@interface ContactsListViewController ()

@end

@implementation ContactsListViewController

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

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadList:) name:UIApplicationWillEnterForegroundNotification object:nil];
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate locationUpdate:nil];
    
    
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    if (loadUsers)
        [loadUsers invalidate];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    userListArray=[[DataStoreManager sharedDataStoreManager]getuserMatchesArray];
    [self.tableView reloadData];
    if (!appDelegate.Islogin)
        [self ShowLogin];
    else
    {
        if (userListArray.count>0)
            [self LoadUsers:NO];
        else
            [self LoadUsers:YES];
        
    }
    
    appDelegate.firstTime=false;
    loadUsers = [NSTimer scheduledTimerWithTimeInterval:60.0
                                                 target:self
                                               selector:@selector(loadUsersTimer)
                                               userInfo:nil
                                                repeats:YES];
    
}
-(IBAction)reloadList:(id)sender
{
    [self LoadUsers:YES];
}
-(void)loadUsersTimer
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
     if (appDelegate.Islogin)
    [self LoadUsers:NO];
}
#pragma mark api call
- (void)LoadUsers:(BOOL)loader
{
    if (loader)
        [self startLoader];
    NSDictionary *postobject = [NSDictionary dictionaryWithObjectsAndKeys:
                                POST_LATITUDE,POST_LATITUDE,
                                POST_LOGITUDE,POST_LOGITUDE,
                                POST_GEOFENCE_AREA,POST_GEOFENCE_AREA,
                                nil];
    
    [[VoyageUpAPIManager sharedManager] getUsers:postobject WithCompletionblock:^(NSDictionary*result,NSError *error)
     {
         @try {
             
             if (result != nil)
             {
                 NSString *title = [result objectForKey:@"title"];
                 NSString *message = [result objectForKey:@"message"];
                 
                 if ([[result valueForKeyPath:@"status"] isEqualToString:@"success"])
                 {
                     AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                     NSString *netWorkID=appDelegate.network_token;
                     NSArray *questionsArrayTemp=[result valueForKeyPath:@"result"];
                     NSMutableArray *qnArray = [NSMutableArray new];
                     for (NSDictionary *pack in questionsArrayTemp)
                     {
                         ProfileDetails *profile=[ProfileDetails profileDetails:pack];
                         //#ifdef DEBUG
                         
                         // [qnArray addObject:[ProfileDetails profileDetails:pack]];
                         
                         //#else
                         if ([profile.network_ID isEqualToString:netWorkID]) {
                             [qnArray addObject:[ProfileDetails profileDetails:pack]];
                         }
                         //#endif
                         
                         
                         
                     }
                     [[DataStoreManager sharedDataStoreManager] setuserMatchesArray:qnArray];
                     userListArray=[[DataStoreManager sharedDataStoreManager]getuserMatchesArray];
                     [self.tableView reloadData];
                     [self stopCircleLoader];
                 }
                 else
                 {
                     //[helper alertErrorUserLoad:title message:message delegate:self];
                     [self stopCircleLoader];
                 }
             }
             if (userListArray.count<1)
                 [self showEmptyList:false];
             
             else
                 [self showEmptyList:true];
         }
         @catch (NSException *exception) {
             
         }
         @finally {
             
         }
     }];
    
    
    
}


-(void)ShowLogin{
    UIStoryboard *sb;
    if (SCREEN_HEIGHT<=480)
        sb= [UIStoryboard storyboardWithName:@"storyBoard4" bundle:nil];
    else
        sb=self.storyboard;
    LoginViewController *vc = [sb instantiateViewControllerWithIdentifier:SB_ID_LOGIN];
    vc.delegate=self;
    vc.modalPresentationStyle= UIModalPresentationCustom;
    [self presentViewController:vc animated:YES completion:nil];
}
#pragma mark login success delegate
-(void)LoginSuccess
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate locationUpdate:nil];
    UITabBarController *tabBarController = (UITabBarController *)appDelegate.window.rootViewController;
    if (appDelegate.signUp) {
        appDelegate.signUp=false;
        tabBarController.selectedIndex =2;
    }
    [self LoadUsers:YES];
    
}
#pragma mark loading methods
-(void)startLoader
{
    
    [GMDCircleLoader setOnView:self.view withTitle:@"Loading..." animated:YES];
    
}
- (void)stopCircleLoader {
    [GMDCircleLoader hideFromView:self.view animated:YES];
}
#pragma mark - UITableViewDatasourse Methods
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    // This will create a "invisible" footer
//    return 0.01f;
//}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 69;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return userListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *mainMenuCellIdentifier = @"cell";
    ContactListCell *cell = [tableView dequeueReusableCellWithIdentifier:mainMenuCellIdentifier];
    
    if (cell == nil)
        cell = [[ContactListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mainMenuCellIdentifier];
    ProfileDetails *user=[userListArray objectAtIndex:indexPath.row];
    cell.lbl_userName.text=user.FullName;
    //cell.lbl_Country.text=user.Country;
    cell.imageView_userPhoto.image=PHOTO_NIL;
    [cell.imageView_userPhoto setImageWithURL:[helper getImageUrl:user.ProfilePhoto]];
    CALayer * l = [cell.imageView_userPhoto layer];
    [l setMasksToBounds:YES];
    [l setCornerRadius:28];
    return cell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProfileDetails *user=[userListArray objectAtIndex:indexPath.row];
    [self showUserDetailsWithUserId:user.UserId :user];
}
-(void)showUserDetailsWithUserId:(NSString*)userid :(ProfileDetails*)profile
{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.firstTime=false;
    MyProfileViewController *obj   = [self.storyboard instantiateViewControllerWithIdentifier:SB_ID_USER];
    obj.user_id=userid;
    obj.profileDetails=profile;
    [self.navigationController pushViewController:obj animated:YES ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)showEmptyList:(BOOL)status
{
    if (status) {
        self.view_emptyList.hidden=status;
        // [self.view bringSubviewToFront:self.view_emptyList];
    }
    else
    {
        self.view_emptyList.hidden=status;
        //[self.view sendSubviewToBack:self.view_emptyList];
    }
}

@end
