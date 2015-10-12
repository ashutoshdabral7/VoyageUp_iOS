//
//  ContactsListViewController.h
//  VoyageUp
//
//  Created by Deepak on 11/05/15.
//  Copyright (c) 2015 Erbauen Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactListCell.h"
#import "UserDetailsViewController.h"
#import "LoginViewController.h"
@interface ContactsListViewController : UIViewController<loginSuccessDelegate>
{
    NSArray *userListArray;
    NSTimer *loadUsers;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *view_emptyList;
-(IBAction)reloadList:(id)sender;
@end
