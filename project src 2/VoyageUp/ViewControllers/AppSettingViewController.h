//
//  AppSettingViewController.h
//  VoyageUp
//
//  Created by Deepak on 10/05/15.
//  Copyright (c) 2015 Deepak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppSettingViewController : UIViewController
@property (strong, nonatomic) IBOutlet UISwitch *switch_push;
@property (strong, nonatomic) IBOutlet UITextField *txt_fenceArea;
@property (strong, nonatomic) IBOutlet UISlider *slider_fence;

@end
