//
//  Q&A_ViewController.h
//  VoyageUp
//
//  Created by Deepak on 10/05/15.
//  Copyright (c) 2015 Erbauen Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Q&A_TableViewCell.h"
@interface Q_A_ViewController : UIViewController<UITextFieldDelegate>{
    
    IBOutlet UIButton *btn_allQn;
    IBOutlet UIButton *btn_myQn;
    NSArray *allQuestionArray;
    NSArray *myQuestionsArray;
    NSArray *currentListArray;
    BOOL myQ;
    NSString *myName;
    
}
- (IBAction)All_Qn_Clicked:(id)sender;
- (IBAction)myQn_clicked:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@end
