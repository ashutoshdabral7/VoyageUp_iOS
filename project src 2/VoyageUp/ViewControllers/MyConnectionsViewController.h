//
//  MyConnectionsViewController.h
//  VoyageUp
//
//  Created by Deepak on 02/05/15.
//  Copyright (c) 2015 Deepak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConnectionCell.h"
@interface MyConnectionsViewController : UIViewController
{
    NSArray *menuItems;
    NSArray *connectionArray;
    NSArray *myConnectionArray;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
