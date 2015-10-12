//
//  VUHomeViewController.m
//  VoyageUp
//
//  Created by Deepak on 26/04/15.
//  Copyright (c) 2015 Erbauen Labs. All rights reserved.
//

#import "VUHomeViewController.h"

@interface VUHomeViewController ()

@end

@implementation VUHomeViewController
#pragma mark loading methods
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
#pragma mark inital methodss------
- (void)viewWillLayoutSubviews
{
//    CGRect tabFrame = self.tabBarController.tabBar.frame;
//    tabFrame.size.height = 29;
//    //tabFrame.origin.y = self.tabBarController.tabBar.frame.origin.y+20;
//    self.tabBarController.tabBar.frame = tabFrame;
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    AppDelegate*  appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (appDelegate.Islogin)
        [appDelegate locationUpdate:nil];
    
}
-(void)viewDidappear:(BOOL)animated{
    [super viewDidAppear:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (!appDelegate.Islogin)
        [self ShowLogin];
    else
        [self LoadUsers];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self ShowUsers];
    
}
//**************************************
-(void)ShowUsers
{
    index=0;
    [self.swipeableView discardAllSwipeableViews];
    [self.swipeableView loadNextSwipeableViewsIfNeeded];
}
#pragma mark api call
- (void)LoadUsers
{
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
                     NSArray *questionsArrayTemp=[result valueForKeyPath:@"result"];
                     NSMutableArray *qnArray = [NSMutableArray new];
                     for (NSDictionary *pack in questionsArrayTemp)
                     {
                         [qnArray addObject:[ProfileDetails profileDetails:pack]];
                     }
                     [[DataStoreManager sharedDataStoreManager] setuserMatchesArray:qnArray];
                     userListArray=[[DataStoreManager sharedDataStoreManager]getuserMatchesArray];
                     [self ShowUsers];
                     [self stopCircleLoader];
                 }
                 else
                 {
                     [helper alertErrorWithTitle:title message:message delegate:self];
                     [self stopCircleLoader];
                 }
             }
             
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
   // vc.delegate=self;
    vc.modalPresentationStyle= UIModalPresentationCustom;
    [self presentViewController:vc animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark login success delegate

#pragma mark loading methods
-(void)startLoader
{
    
    [GMDCircleLoader setOnView:self.view withTitle:@"Loading..." animated:YES];
    
}
- (void)stopCircleLoader {
    [GMDCircleLoader hideFromView:self.view animated:YES];
}
#pragma mark - ZLSwipeableViewDelegate

- (void)swipeableView:(ZLSwipeableView *)swipeableView
         didSwipeView:(UIView *)view
          inDirection:(ZLSwipeableViewDirection)direction {
    NSLog(@"did swipe in direction: %zd", direction);
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView
       didCancelSwipe:(UIView *)view {
    NSLog(@"did cancel swipe");
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView
  didStartSwipingView:(UIView *)view
           atLocation:(CGPoint)location {
    NSLog(@"did start swiping at location: x %f, y %f", location.x, location.y);
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView
          swipingView:(UIView *)view
           atLocation:(CGPoint)location
          translation:(CGPoint)translation {
    NSLog(@"swiping at location: x %f, y %f, translation: x %f, y %f",
          location.x, location.y, translation.x, translation.y);
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView
    didEndSwipingView:(UIView *)view
           atLocation:(CGPoint)location {
    NSLog(@"did end swiping at location: x %f, y %f", location.x, location.y);
}
#pragma mark - ZLSwipeableViewDataSource

- (UIView *)nextViewForSwipeableView:(ZLSwipeableView *)swipeableView {
    
    if (index<userListArray.count) {
        ProfileDetails *profile=[userListArray objectAtIndex:index];
        CardView *view = [[CardView alloc] initWithFrame:CGRectMake(0, 0, swipeableView.frame.size.width, swipeableView.frame.size.height)];
        view.backgroundColor = COLOR_MAIN_BG;
        UIImageView *imageview=[UIImageView new];
        imageview.frame=CGRectMake(5, 5, view.frame.size.width-10, view.frame.size.height-60);
        // imageview.image=[userImageArray objectAtIndex:index];
        imageview.image=nil;
        [imageview setImageWithURL:[helper getImageUrl:profile.ProfilePhoto] placeholderImage:[UIImage imageNamed:@"noimagebig.png"]];
        CALayer * l = [imageview layer];
        [l setMasksToBounds:YES];
        [l setCornerRadius:(imageview.frame.size.width/2.2)];
        [view addSubview:imageview];
        UILabel *title=[customLabel customLabelWithFrame:CGRectMake(0, view.frame.size.height-40, view.frame.size.width, 20) withText:profile.FullName withColor:COLOR_TEXT];
        [title setFont:[UIFont fontWithName:FONT_MONT_REGULAR size:20]];
        title.textAlignment = NSTextAlignmentCenter;
        [view addSubview:title];
        index++;
        
        return view;
    }
    else
        return nil;
}
#pragma mark - Action

- (IBAction)swipeLeftButtonAction:(UIButton *)sender {
    [self.swipeableView swipeTopViewToLeft];
}

- (IBAction)swipeRightButtonAction:(UIButton *)sender {
    [self.swipeableView swipeTopViewToRight];
}

- (IBAction)reloadButtonAction:(UIButton *)sender {
    [self.swipeableView discardAllSwipeableViews];
    [self.swipeableView loadNextSwipeableViewsIfNeeded];
}
-(IBAction)reloadUsers:(id)sender
{
    [self LoadUsers];
}
@end
