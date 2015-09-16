//
//  AppSettingViewController.m
//  VoyageUp
//
//  Created by Deepak on 10/05/15.
//  Copyright (c) 2015 Deepak. All rights reserved.
//

#import "AppSettingViewController.h"

@interface AppSettingViewController () 

@end

@implementation AppSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
    -(IBAction)dismiss:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
    self.navigationItem.titleView = [helper SetNavTitle:SCREEN_SETTINGS_TITLE];
    //------------****** ---------
    ProfileDetails *profile=[ProfileDetails getProfileDetails];
    self.txt_fenceArea.text=profile.GeofenceArea;
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.geofenceArea=self.txt_fenceArea.text;
}
-(void)viewDidAppear:(BOOL)animated
{
   
    [super viewDidAppear:YES];
    [UIView animateWithDuration:5.0 animations:^{
        self.slider_fence.value = [self.txt_fenceArea.text floatValue];
    }];
    
}
-(void)viewDidDisappear:(BOOL)animated
{
        [self.navigationController popToRootViewControllerAnimated:YES];
    
}
-(IBAction)changeSlider1:(id)sender
{
    UISlider *slider=(UISlider*)sender;
    self.txt_fenceArea.text= [[NSString alloc] initWithFormat:@"%dm", (int)slider.value];
     ProfileDetails *profile=[ProfileDetails getProfileDetails];
    profile.GeofenceArea=self.txt_fenceArea.text;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
