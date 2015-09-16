//
//  VUHomeViewController.h
//  VoyageUp
//
//  Created by Deepak on 26/04/15.
//  Copyright (c) 2015 Deepak. All rights reserved.
//
#import <SystemConfiguration/CaptiveNetwork.h>
#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "GMDCircleLoader.h"
#import "ZLSwipeableView.h"
#import "UIColor+FlatColors.h"
#import "CardView.h"
@interface VUHomeViewController : UIViewController<ZLSwipeableViewDataSource,
ZLSwipeableViewDelegate>
{
    NSArray *userListArray;
    NSArray *userImageArray;
    int index;
    NSArray *userNameArray;
   
}
//----- loading
@property (nonatomic, weak) IBOutlet ZLSwipeableView *swipeableView;
@property (strong, nonatomic) NSArray *arrTitile;
@property (strong, nonatomic) NSTimer *timer;
//--------------
@end
