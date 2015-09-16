//
//  Q&A_ViewController.m
//  VoyageUp
//
//  Created by Deepak on 10/05/15.
//  Copyright (c) 2015 Deepak. All rights reserved.
//

#import "Q&A_ViewController.h"
#import "AnswerViewController.h"
@interface Q_A_ViewController ()

@end

@implementation Q_A_ViewController
#pragma mark initial view methods
- (void)viewDidLoad {
    [super viewDidLoad];
    ProfileDetails* profile=[ProfileDetails getProfileDetails];
    myName=profile.FullName;
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    //------------****** navigation bar settings ---------
    self.navigationController.navigationBar.tintColor = COLOR_MAIN_BG_DARK;
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil]
     setTitleTextAttributes:
     @{NSForegroundColorAttributeName:COLOR_MAIN_BG_DARK,
       NSFontAttributeName:BARBUTTON_FONT
       }
     forState:UIControlStateNormal];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.titleView = [helper SetNavTitle:SCREEN_Q_A];
    //------------****** ---------
    [self getAllQuestions];
    [self getAllMyQuestion];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [self.tableView setSeparatorColor:COLOR_MAIN_BG];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark button action methods
-(IBAction)postquestion:(id)sender{
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    alert.shouldDismissOnTapOutside = YES;
    alert.showAnimationType = SlideInToCenter;
    UITextField *txt = [alert addTextField:@"Enter Question"];
    txt.delegate = self;
    alert.backgroundViewColor=COLOR_MAIN_BG;
    
    [alert addButton:@"Send" actionBlock:^(void) {
        
        [self postQuestion:txt.text];
        
    }];
    [alert addButton:@"Cancel" actionBlock:^(void) {
        
        
        
    }];

    [alert showEdit:self title:@"Post your question" subTitle:nil closeButtonTitle:nil duration:0.0f];
    
}

- (IBAction)All_Qn_Clicked:(id)sender {
    myQ=false;
    [btn_allQn setBackgroundColor:[UIColor colorWithRed:58.0/255.0 green:55.0/255.0 blue:55.0/255.0 alpha:1.0]];
    [btn_allQn setTitleColor:[UIColor colorWithRed:236.0/255.0 green:240.0/255.0 blue:241.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [btn_myQn setBackgroundColor:[UIColor colorWithRed:236.0/255.0 green:240.0/255.0 blue:241.0/255.0 alpha:1.0]];
    [btn_myQn setTitleColor:[UIColor colorWithRed:86.0/255.0 green:55.0/255.0 blue:67.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    currentListArray=allQuestionArray;
    [self.tableView reloadData];
}

- (IBAction)myQn_clicked:(id)sender {
    myQ=true;
    [btn_myQn setBackgroundColor:[UIColor colorWithRed:58.0/255.0 green:55.0/255.0 blue:55.0/255.0 alpha:1.0]];
    [btn_myQn setTitleColor:[UIColor colorWithRed:236.0/255.0 green:240.0/255.0 blue:241.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [btn_allQn setBackgroundColor:[UIColor colorWithRed:236.0/255.0 green:240.0/255.0 blue:241.0/255.0 alpha:1.0]];
    [btn_allQn setTitleColor:[UIColor colorWithRed:86.0/255.0 green:55.0/255.0 blue:67.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    currentListArray=myQuestionsArray;
 
    [self.tableView reloadData];
}
#pragma mark api calls
-(void)postQuestion:(NSString*)question
{
    NSDictionary *postobject = [NSDictionary dictionaryWithObjectsAndKeys:
                                question,POST_QUESTION,
                                nil];
    
    [[VoyageUpAPIManager sharedManager] PostQuestion:postobject WithCompletionblock:^(NSDictionary*result,NSError *error)
     {
         @try {
             
             if (result != nil)
             {
                 
                 NSString *title = [result objectForKey:@"title"];
                 NSString *message = [result objectForKey:@"message"];
                 [helper ShowSuccessAlert:self withTitle:title withMessage:message];
                 [self getAllMyQuestion];
             }
             
         }
         @catch (NSException *exception){
             
             
         }
         
     }];
}

-(void)getAllQuestions
{
    
    if([helper isNetworkAvailable])
    {
        [[VoyageUpAPIManager sharedManager] GetAllQuestions:^(NSDictionary*result,NSError *error) {
            
            if ([[result valueForKeyPath:@"status"] isEqualToString:@"success"])
            {
                
                NSArray *questionsArrayTemp=[result valueForKeyPath:@"result"];
                NSMutableArray *qnArray = [NSMutableArray new];
                for (NSDictionary *pack in questionsArrayTemp)
                {
                    [qnArray addObject:[Questions questionsDictionary:pack]];
                }
                [[DataStoreManager sharedDataStoreManager] setAllQuestionsArrayFrom:qnArray];
                allQuestionArray=[[DataStoreManager sharedDataStoreManager]getAllQuestionsArray];
                currentListArray=allQuestionArray;
                myQ=false;
                [self.tableView reloadData];
            }
        }];
        
    }else{
        
        [helper alertErrorWithTitle:nil message:NO_NETWORK_AVAILABLE delegate:self];
        [SVProgressHUD dismiss];
        
    }
    
}
-(void)getAllMyQuestion
{
    
    if([helper isNetworkAvailable])
    {
        [[VoyageUpAPIManager sharedManager] GetMyQuestions:^(NSDictionary*result,NSError *error) {
            
            if ([[result valueForKeyPath:@"status"] isEqualToString:@"success"])
            {
                
                NSArray *questionsArrayTemp=[result valueForKeyPath:@"result"];
                NSMutableArray *qnArray = [NSMutableArray new];
                for (NSDictionary *pack in questionsArrayTemp)
                {
                    [qnArray addObject:[Questions questionsDictionary:pack]];
                }
                [[DataStoreManager sharedDataStoreManager] setallMyQuestionArray:qnArray];
                myQuestionsArray=[[DataStoreManager sharedDataStoreManager]getallMyQuestionArray];
            }
        }];
        
    }else{
        
        [helper alertErrorWithTitle:nil message:NO_NETWORK_AVAILABLE delegate:self];
        [SVProgressHUD dismiss];
        
    }
    
}

#pragma mark - UITableViewDatasourse Methods
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    // This will create a "invisible" footer
    return 0.01f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 77;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return currentListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *mainMenuCellIdentifier = @"cell";
    Q_A_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mainMenuCellIdentifier];
    
    if (cell == nil)
        cell = [[Q_A_TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mainMenuCellIdentifier];
     Questions *qn=[currentListArray objectAtIndex:indexPath.row];
    cell.lbl_qn.text=qn.Question;
    if (myQ)
        cell.lbl_userName.text=myName;
    else
       cell.lbl_userName.text=qn.FullName;
    cell.imageView_user.image=nil;
    [cell.imageView_user setImageWithURL:[helper getImageUrl:qn.ProfilePhoto] placeholderImage:nil];
      return cell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Questions *qn=[currentListArray objectAtIndex:indexPath.row];
    AnswerViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:SB_ID_ANSWER];
    vc.questionid=qn.qn_id;
    vc.question=qn.Question;
    //vc.modalPresentationStyle= UIModalPresentationCustom;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - textfiled delegate methods

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
@end
