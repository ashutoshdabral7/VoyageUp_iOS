//
//  VUChatMessageViewController.m
//  VoyageUp
//
//  Created by Deepak on 16/05/15.
//  Copyright (c) 2015 Deepak. All rights reserved.
//

#import "VUChatMessageViewController.h"

#import "LIMessage.h"


@interface VUChatMessageViewController ()

@end

@implementation VUChatMessageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
     [self deleteMessageAutomatic];
    ProfileDetails *profile=[ProfileDetails getProfileDetails];
    myName=profile.FullName;
    myImage=profile.ProfilePhoto;
  UITapGestureRecognizer*  tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.chatListTableView addGestureRecognizer:tap];
    self.msgTextView.layer.borderColor = [UIColor colorWithRed:210.0/255.0 green:210.0/255.0 blue:210.0/255.0 alpha:1.0].CGColor;
    self.msgTextView.layer.borderWidth = 1.0f;
    // Do any additional setup after loading the view.
}
- (void)dismissKeyboard {
    
    [self.view endEditing:YES];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter   defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter   defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
    [repeatTimer invalidate];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [self getAllMessages];
    repeatTimer = [NSTimer scheduledTimerWithTimeInterval:10.0
                                                   target:self
                                                 selector:@selector(getAllMessages)
                                                 userInfo:nil
                                                  repeats:YES];
}
- (void)viewDidAppear:(BOOL)animated{
    [self.msgTextView setDelegate:self];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector (keyboardWillShow:)
                                                 name: UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector (keyboardWillHide:)
                                                 name: UIKeyboardWillHideNotification
                                               object:nil];
    
    //------------****** navigation bar settings ---------
    self.navigationController.navigationBar.tintColor = COLOR_MAIN_BG_DARK;
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil]
     setTitleTextAttributes:
     @{NSForegroundColorAttributeName:COLOR_MAIN_BG_DARK,
       NSFontAttributeName:BARBUTTON_FONT
       }
     forState:UIControlStateNormal];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.titleView = [helper SetNavTitle:self.userProfile.FullName];
    //------------****** --------
    //------------****** --------
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
   
}
-(void) keyboardWillHide: (NSNotification *)notif
{
    _bottomPositionViewConstraint.constant = 0.0f;
    
}
-(void) keyboardWillShow: (NSNotification *)notif
{
    
    NSDictionary* keyboardInfo = [notif userInfo];
    NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    _bottomPositionViewConstraint.constant = keyboardFrameBeginRect.size.height-49;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - event handlers
- (IBAction)sendNewMessage:(id)sender
{
   
    if (self.msgTextView.text.length>0){
        LIMessage *message1 = [[LIMessage alloc] init];
        message1.messageText =self.msgTextView.text;
        message1.messageMode = LIMESSAGE_MODE_SENT;
        [_arrayChatMessages addObject:message1];
        [_chatListTableView reloadData];
        [self SendMessage:self.msgTextView.text];
        @try {
            if (_arrayChatMessages.count>0) {
                       NSIndexPath* ipath = [NSIndexPath indexPathForRow:0 inSection:_arrayChatMessages.count-1];
            [_chatListTableView scrollToRowAtIndexPath: ipath atScrollPosition: UITableViewScrollPositionTop animated: YES];
            }
        }
        @catch (NSException *exception) {
            
        }
       
           }
}
- (IBAction)clearConversation:(id)sender
{
    
     UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Delete" message:@"Are you sure want to delete this conversation?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
     
     [alert show];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex==0) {
       
    }
    else if(buttonIndex==1)
    {
         [self deleteMessage];
    }
}
#pragma mark api calls
-(void)getAllMessages{
    NSDictionary *postobject = [NSDictionary dictionaryWithObjectsAndKeys:
                                self.userProfile.UserId,USER_ID,
                                nil];
    
    [[VoyageUpAPIManager sharedManager] getAllMessagesFromSingleUser:postobject WithCompletionblock:^(NSDictionary*result,NSError *error)
     {
         // @try {
         
         
         if ([[result valueForKeyPath:@"status"] isEqualToString:@"success"])
         {
             NSArray *questionsArrayTemp=[result valueForKeyPath:@"result"];
             NSMutableArray *qnArray = [NSMutableArray new];
             for (NSDictionary *pack in questionsArrayTemp)
             {
                 [qnArray addObject:[LIMessage latestMessagesDictonery:pack]];
             }
             // [[DataStoreManager sharedDataStoreManager] setuserMatchesArray:qnArray
             
             LIMessage *lastmsg=[_arrayChatMessages objectAtIndex:_arrayChatMessages.count-1];
             _arrayChatMessages=[[[qnArray reverseObjectEnumerator] allObjects]mutableCopy];
             LIMessage *lastmsg1=[_arrayChatMessages objectAtIndex:_arrayChatMessages.count-1];
             // _arrayChatMessages=qnArray;
             @try {
                 if (![lastmsg.messageId isEqualToString:lastmsg1.messageId])
                     [self.chatListTableView reloadData];
                 NSIndexPath* ipath = [NSIndexPath indexPathForRow:0 inSection:_arrayChatMessages.count-1];
                 [_chatListTableView scrollToRowAtIndexPath: ipath atScrollPosition: UITableViewScrollPositionTop animated: YES];
                 
             }
             @catch (NSException *exception) {
                 [self.chatListTableView reloadData];
                 
             }
             
             
             
         }
         else if ([[result valueForKeyPath:@"status"] isEqualToString:@"failed"])
         {
             _arrayChatMessages=nil;
             [self.chatListTableView reloadData];
         }
         //         }
         //         @catch (NSException *exception){
         //
         //
         //         }
         
     }];
}
-(void)SendMessage:(NSString*)message
{
    NSString *uniText = [NSString stringWithUTF8String:[message UTF8String]];
    NSData *msgData = [uniText dataUsingEncoding:NSNonLossyASCIIStringEncoding];
    NSString *goodMsg = [[NSString alloc] initWithData:msgData encoding:NSUTF8StringEncoding];
    
    self.msgTextView.text=@"";
    NSDictionary *postobject = [NSDictionary dictionaryWithObjectsAndKeys:
                                self.userProfile.UserId,POST_CHAT_RECEIVER_ID,
                                goodMsg,POST_CHAT_MESSAGE,
                                nil];
    
    [[VoyageUpAPIManager sharedManager] sendMessage:postobject WithCompletionblock:^(NSDictionary*result,NSError *error)
     {
         @try {
             
             if (result != nil)
             {
                 
                 
             }
             
         }
         @catch (NSException *exception){
             
             
         }
         
     }];
}
-(void)deleteMessage{
    NSDictionary *postobject = [NSDictionary dictionaryWithObjectsAndKeys:
                                self.userProfile.UserId,USER_ID,
                                nil];
    
    [[VoyageUpAPIManager sharedManager] deleteMessage:postobject WithCompletionblock:^(NSDictionary*result,NSError *error)
     {
         @try {
             
             if (result != nil)
             {
               
                   [self getAllMessages];
             }
             
         }
         @catch (NSException *exception){
             
             
         }
        
     }];
}
-(void)deleteMessageAutomatic{
    NSDictionary *postobject = [NSDictionary dictionaryWithObjectsAndKeys:
                                self.userProfile.UserId,USER_ID,
                                nil];
    
    [[VoyageUpAPIManager sharedManager] deleteMessageAutomatic:postobject WithCompletionblock:^(NSDictionary*result,NSError *error)
     {
         @try {
             
             if (result != nil)
             {
                 
                
             }
             
         }
         @catch (NSException *exception){
             
             
         }
         
     }];
}

#pragma mark - message manager methods -stop
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
   // [self.view endEditing:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LIMessage *message =[_arrayChatMessages objectAtIndex:indexPath.section];
    CGFloat cellHeight = [ChatMessageTableViewCell heightForCellWithMessage2:message];
    NSLog(@"cellHeight---%f",cellHeight);
    return cellHeight;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _arrayChatMessages.count;//( _conversationMessages.count != 0 ) ? _conversationMessages.count : 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;//_conversationMessages.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    LIMessage *messageInfo = [_arrayChatMessages objectAtIndex:indexPath.section];
    
    
    
    
    
    static NSString *ChatMessageCellIdentifier = @"ChatMessageCellIdentifier";
    
    //ChatMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ChatMessageCellIdentifier];
    //   if(cell == nil){
    ChatMessageTableViewCell *cell = [[ChatMessageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ChatMessageCellIdentifier];
    //    }
    cell.selectionStyle=NO;
    cell.delegate=self;
    cell.backgroundColor = [UIColor clearColor];
    
    
    
    // QBChatAbstractMessage *message = self.messages[indexPath.row];
    if (!_arrayChatMessages.count)
    {
        NSLog(@"empty save message info array");
        // cell=nil;
    }
    else
    {
        //  MessageInfo *messageInfo=[saveMessageInfoArray objectAtIndex:indexPath.row];
        
        if(messageInfo.messageMode == LIMESSAGE_MODE_RECEIVED)
            [cell configureCellWithMessage2:messageInfo senderName:nil row:indexPath.row mymessage:NO];
        else
            [cell configureCellWithMessage2:messageInfo senderName:nil row:indexPath.row mymessage:YES];
        
    }
    return cell;
    
      
}

#pragma mark - ITextView delegate

- (void)textViewDidEndEditing:(UITextView *)textView
{
    
    
}
- (void)textViewDidBeginEditing:(UITextView *)textView{
    
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
    
    
   }
@end
