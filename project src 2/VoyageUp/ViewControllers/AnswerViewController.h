//
//  AnswerViewController.h
//  VoyageUp
//
//  Created by Deepak on 22/05/15.
//  Copyright (c) 2015 Deepak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnswerViewController : UIViewController
{
      NSArray *answerArray;
      UITapGestureRecognizer *tap;
   
}
@property (strong, nonatomic) NSString *questionid;
@property (strong, nonatomic) NSString *question;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UITextField *txt_answer;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *txtFieldView_bottom;
-(IBAction)postAnswer:(id)sender;
@end
