//
//  AnswerViewController.m
//  VoyageUp
//
//  Created by Deepak on 22/05/15.
//  Copyright (c) 2015 Deepak. All rights reserved.
//

#import "AnswerViewController.h"
#import "AnswerCell.h"
@interface AnswerViewController ()

@end

@implementation AnswerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    tap = [[UITapGestureRecognizer alloc]
           initWithTarget:self
           action:@selector(dismissKeyboard)];
    // Do any additional setup after loading the view.
    [self GetQuestionById:self.questionid];
      self.navigationItem.titleView = [helper SetNavTitle:SCREEN_ANSWER];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
}
#pragma mark api calls
-(void)GetQuestionById:(NSString *)questionid{
    NSDictionary *postobject = [NSDictionary dictionaryWithObjectsAndKeys:
                                questionid,POST_QUESTION_ID,
                                nil];
    
    [[VoyageUpAPIManager sharedManager] GetQuestionById:postobject WithCompletionblock:^(NSDictionary*result,NSError *error)
     {
         @try {
             
             if ([[result valueForKeyPath:@"status"] isEqualToString:@"success"])
             {
                 
                 NSArray *questionsArrayTemp=[result valueForKeyPath:@"result"];
                 NSMutableArray *qnArray = [NSMutableArray new];
                 for (NSDictionary *pack in questionsArrayTemp)
                 {
                     [qnArray addObject:[Answer answerDictionary:pack]];
                 }
                 [[DataStoreManager sharedDataStoreManager] setanswerArray:qnArray];
                 answerArray=[[DataStoreManager sharedDataStoreManager]getanswerArray];
                
                 [self.tableview reloadData];
             }
             
         }
         @catch (NSException *exception){
             
             
         }
         
     }];
}
-(IBAction)postAnswer:(id)sender{
    [self.view endEditing:YES];
    if (self.txt_answer.text.length<1)
    {
        
    }
      else
      {
    NSDictionary *postobject = [NSDictionary dictionaryWithObjectsAndKeys:
                                self.txt_answer.text,POST_ANSWER,
                                self.questionid,POST_QUESTION_ID,
                                nil];
    
    [[VoyageUpAPIManager sharedManager] PostAnswer:postobject WithCompletionblock:^(NSDictionary*result,NSError *error)
     {
         @try {
             self.txt_answer.text=@"";
             NSString *title = [result objectForKey:@"title"];
             NSString *message = [result objectForKey:@"message"];
             
             if ([[result valueForKeyPath:@"status"] isEqualToString:@"success"])
             {
                 [helper ShowSuccessAlert:self withTitle:title withMessage:message];
                 [self GetQuestionById:self.questionid];
             }
             else
             {
                 [[[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
             }
         }
         @catch (NSException *exception){
             
             
         }
         
     }];
      }
}
#pragma mark table delegate Methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
       // return [helper textFrame:self.question fontSize:17 widthFactor:50].height+50;
        CGSize boundingSize = CGSizeMake(200, 10000000);
        CGRect itemText = [self.question  boundingRectWithSize:boundingSize
                                                             options:NSStringDrawingUsesLineFragmentOrigin
                                                          attributes:@{NSFontAttributeName:[UIFont fontWithName:FONT_MONT_LIGHT size:14]}
                                                             context:nil];
        itemText.size.height = (itemText.size.height < 40) ? 45 : itemText.size.height;
        return ( itemText.size.height + 50) ;
    }
    
    else{
    Answer *answer=[answerArray objectAtIndex:indexPath.row];
    return [helper textFrame:answer.answer fontSize:17 widthFactor:50].height+50;
       // return 100;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        static NSString *CellIdentifier = @"mycellqn";
        AnswerCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[AnswerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.img_questionicon.hidden = false;
        CGSize size= [helper textFrame:self.question fontSize:17 widthFactor:80];
        UILabel *lbl=[customLabel customLabelWithFrame:CGRectMake(20,5, size.width, size.height) withText:self.question withColor:COLOR_TEXT withline:5 ];
        [cell addSubview:lbl];
        return cell;
    }
    
  
        else
        {
            static NSString *CellIdentifier = @"mycell";
            AnswerCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[AnswerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            
            for (UIView *subview in cell.subviews) {
                [subview removeFromSuperview];
            }
            Answer *answer=[answerArray objectAtIndex:indexPath.row];
            cell.lbl_name.text=answer.FullName;
            CGSize size= [helper textFrame:answer.answer fontSize:17 widthFactor:50];
            [cell addSubview:[customLabel customLabelWithFrame:CGRectMake(30,15, 200, 25) withText:answer.FullName withColor:COLOR_MAIN_BG withline:5] ];
            [cell addSubview:[customLabel customLabelWithFrame:CGRectMake(30,40, size.width, size.height) withText:answer.answer withColor:[UIColor blackColor]withline:5] ];
            
            return cell;
        }
        
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0)
        return 1;
    else
        return answerArray.count;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - textfiled delegate methods
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.view addGestureRecognizer:tap];
   
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self.view removeGestureRecognizer:tap];
  
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSInteger nextTag = textField.tag + 1;
    // Try to find next responder
    UIResponder *nextResponder = [textField.superview viewWithTag:nextTag];
    
    
    if (nextResponder)
    {
        [textField resignFirstResponder];
        [nextResponder becomeFirstResponder];
    }
    
    else
    {
        
        [textField resignFirstResponder];
        
        return YES;
    }
    return YES;
}
- (void)dismissKeyboard {
    
    [self.view endEditing:YES];
}
- (void)keyboardWasShown:(NSNotification *)notification
{
    
    // Get the size of the keyboard.
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    //Given size may not account for screen rotation
    int height = MIN(keyboardSize.height,keyboardSize.width);
    self.txtFieldView_bottom.constant=height;
    
}
- (void)keyboardWasHide:(NSNotification *)notification
{
    self.txtFieldView_bottom.constant=0;
}
-(CGFloat)getHeight:(NSString*)text
{
    CGSize boundingSize = CGSizeMake(200, 10000000);
    CGRect itemText = [text  boundingRectWithSize:boundingSize
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                attributes:@{NSFontAttributeName:[UIFont fontWithName:FONT_MONT_LIGHT size:14]}
                                                   context:nil];
    itemText.size.height = (itemText.size.height < 40) ? 45 : itemText.size.height;
    return ( itemText.size.height + 20) ;
}
@end
