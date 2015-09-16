//
//  VUContactsViewController.h
//  VoyageUp
//
//  Created by Deepak on 26/04/15.
//  Copyright (c) 2015 Deepak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactsCell.h"
#import "ContactsListViewController.h"
//#import "DemoViewController.h"
@interface VUContactsViewController : UIViewController
{
    NSMutableArray *arr;
    NSMutableArray * exampleCardLabels;
    NSArray *latestMessagesArray;
    
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
