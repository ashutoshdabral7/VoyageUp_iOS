//
//  MyNotificationsViewController.h
//  VoyageUp
//
//  Created by Deepak on 13/05/15.
//  Copyright (c) 2015 Erbauen Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NotificationCell.h"
@interface MyNotificationsViewController : UIViewController
{
    NSArray *notificationArray;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@end
