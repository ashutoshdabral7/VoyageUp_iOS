//
//  Sharing&HelpingViewController.h
//  VoyageUp
//
//  Created by Deepak on 10/05/15.
//  Copyright (c) 2015 Erbauen Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharingHelpingCell.h"
@interface Sharing_HelpingViewController : UIViewController<UITextFieldDelegate>
{
    
    IBOutlet UIView *view_btns;
    IBOutlet UIButton *btn_otherShares;
    IBOutlet UIButton *btn_myShare;
    NSArray *allSharesArray;
    NSArray *allMySharesArray;
    NSArray *CurrentListArray;
    BOOL myshare;
}
- (IBAction)SharedItems_Clicked:(id)sender;
- (IBAction)myShares:(id)sender;
-(IBAction)newShare:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@end
