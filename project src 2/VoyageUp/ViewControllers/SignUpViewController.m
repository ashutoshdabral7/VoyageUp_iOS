//
//  SignUpViewController.m
//  VoyageUp
//
//  Created by Deepak on 09/05/15.
//  Copyright (c) 2015 Deepak. All rights reserved.
//

#import "SignUpViewController.h"

@interface SignUpViewController ()

@end
static NSString * const kClientId = @"349188679231-3g830iqsnh658js9a3dqajcrfoogtd19.apps.googleusercontent.com";
@implementation SignUpViewController
#pragma mark -initial view setup methods
- (void)viewDidLoad {
    
    [super viewDidLoad];
    tap = [[UITapGestureRecognizer alloc]
           initWithTarget:self
           action:@selector(dismissKeyboard)];
    // Do view setup here.
    GPPSignIn *signIn = [GPPSignIn sharedInstance];
    signIn.shouldFetchGooglePlusUser = YES;
   // signIn.scopes= [NSArray arrayWithObjects:kGTLAuthScopePlusLogin, nil];
    signIn.shouldFetchGoogleUserID=YES;
    signIn.shouldFetchGoogleUserEmail=YES;
    signIn.shouldFetchGooglePlusUser=YES;
    //signIn.shouldFetchGoogleUserEmail = YES;  // Uncomment to get the user's email
    
    // You previously set kClientId in the "Initialize the Google+ client" step
    signIn.clientID = kClientId;
    
    // Uncomment one of these two statements for the scope you chose in the previous step
   // signIn.scopes = @[ kGTLAuthScopePlusLogin ];  // "https://www.googleapis.com/auth/plus.login" scope
    //signIn.scopes = @[ @"profile" ];            // "profile" scope
    
    // Optional: declare signIn.actions, see "app activities"
    signIn.delegate = self;
    [self.signInButton setImage:nil forState:UIControlStateNormal];
    self.signInButton.enabled=false;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setView];
    //  self.ScrollView.contentSize=CGSizeMake(220, 500);
}
- (void)scrollViewDidScroll:(UIScrollView *)sender {
    if (sender.contentOffset.x != 0) {
        CGPoint offset = sender.contentOffset;
        offset.x = 0;
        sender.contentOffset = offset;
    }
}
-(void)setView{
    
    [txt_firstName leftViewRectForBounds];
    [txt_secondName leftViewRectForBounds];
    [txt_email leftViewRectForBounds];
    [txt_password leftViewRectForBounds];
    [txt_confirmPassword leftViewRectForBounds];
    [txt_age leftViewRectForBounds];
    
}
#pragma mark api call
-(void)signUpWithFaceBook:(NSString*)firstName lastName:(NSString*)lastname email:(NSString*)email
{
    NSDictionary *postobject = [NSDictionary dictionaryWithObjectsAndKeys:
                                firstName,POST_FIRSTNAME,
                                lastname,POST_LASTNAME,
                               email,POST_EMAIL,
                                @"",POST_COUNTRY,
                                @"123",POST_PASSWORD,
                                @"F",POST_LOGINTYPE,
                                @"",POST_DOB,
                                @"M",POST_GENDER,
                                nil];
    
    [[VoyageUpAPIManager sharedManager] Signup:postobject WithCompletionblock:^(NSDictionary*result,NSError *error)
     {
     
         @try {
             
             if (result != nil)
             {
                 NSLog(@"result=%@",result);
                 NSString *title = [result objectForKey:@"title"];
                 NSString *message = [result objectForKey:@"message"];
                 
                 if ([[result valueForKeyPath:@"status"] isEqualToString:@"success"])
                 {
                     [self showSuccess:title msg:message];
                     
                 }
                 else
                 {
                     [[[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
                 }
             }
             
         }
         @catch (NSException *exception) {
             
         }
         @finally {
             
         }
     }];
}
#pragma mark - button action methods

- (IBAction)signUp_Clicked:(id)sender {
    if ([self validate])
    {
        NSDictionary *postobject = [NSDictionary dictionaryWithObjectsAndKeys:
                                    txt_firstName.text,POST_FIRSTNAME,
                                    txt_secondName.text,POST_LASTNAME,
                                    txt_email.text,POST_EMAIL,
                                    @"NA",POST_COUNTRY,
                                    txt_password.text,POST_PASSWORD,
                                    @"N",POST_LOGINTYPE,
                                    @"NA",POST_DOB,
                                    @"M",POST_GENDER,
                                    nil];
 
        [[VoyageUpAPIManager sharedManager] Signup:postobject WithCompletionblock:^(NSDictionary*result,NSError *error)
         {
     
             @try {
                 
                 if (result != nil)
                 {
                
                     NSString *title = [result objectForKey:@"title"];
                     NSString *message = [result objectForKey:@"message"];
                    
                     if ([[result valueForKeyPath:@"status"] isEqualToString:@"success"])
                     {
                         [self showSuccess:title msg:message];
                         
                     }
                     else
                     {
                          [[[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
                     }
                 }
                 
             }
             @catch (NSException *exception) {
                 
             }
             @finally {
                 
             }
         }];
    
        
    }
}

- (IBAction)signUpWithFB:(id)sender {
    [FBSession openActiveSessionWithReadPermissions:@[@"email",@"user_location",@"user_birthday",@"user_hometown"]
                                       allowLoginUI:YES
                                  completionHandler:^(FBSession *session, FBSessionState state, NSError *error)
     {
         
         switch (state) {
             case FBSessionStateOpen:
             {
                 [[FBRequest requestForMe] startWithCompletionHandler:^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
                     if (error)
                     {
                         
                         // error code
                         
                     }
                     else
                     {
                         // retrive user's details at here as shown below
                      
                         autoLogin=true;
                         [FBSession.activeSession closeAndClearTokenInformation];
                         fbEmail=[user valueForKeyPath:@"email"];
                         [self signUpWithFaceBook:user.first_name lastName:user.last_name email:[user valueForKeyPath:@"email"]];
                     }
                 }];
                 break;
             }
             case FBSessionStateClosed:
                 NSLog(@"FBSessionStateClosed:%@",error);
                 break;
             case FBSessionStateClosedLoginFailed:
                 NSLog(@"FBSessionStateClosedLoginFailed:%@",error);
                 break;
                 [FBSession.activeSession closeAndClearTokenInformation];
                 break;
             default:
                 break;
         }
         
     }];
}

- (IBAction)signUpWithGoogle:(id)sender {
    NSLog(@"result");
}
- (IBAction)dismissView:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)dismissWithDelegate:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.signUp=true;
    if (autoLogin)
        [self.delegate signUpSuccess:fbEmail pswd:@"123" autologin:YES];
    else
        [self.delegate signUpSuccess:txt_email.text pswd:txt_password.text autologin:NO];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)showSuccess:(NSString*)title msg:(NSString*)msg
{
 msg= @"Registered Successfully. Verification mail send to your registered email id. Go to your inbox and activate your account";
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    alert.shouldDismissOnTapOutside = YES;
    alert.showAnimationType = SlideInToCenter;
    
    
    
    
    [alert addButton:@"Done" actionBlock:^(void) {
        
        [self dismissWithDelegate:nil];
        
        
    }];
    [alert showSuccess:self title:title subTitle:msg closeButtonTitle:nil  duration:0.0f];
}
#pragma mark - textfiled delegate methods
- (void)countryController:(id)sender didSelectCountry:(EMCCountry *)chosenCity
{
    txt_country.text = chosenCity.countryName;
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)dismissPickerView:(id)sender
{
    
    [toolBar removeFromSuperview];
     //[txt_email becomeFirstResponder];
}
- (void)updateDateField:(id)sender
{
  
    UIDatePicker *picker = (UIDatePicker*)txt_age.inputView;
    txt_age.text = [self formatDate:picker.date];
}
- (NSString *)formatDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *formattedDate = [dateFormatter stringFromDate:date];
    return formattedDate;
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self dismissPickerView:nil];
    [self.view addGestureRecognizer:tap];
    if (textField==txt_password)
        [self.ScrollView setContentOffset:CGPointMake(0, textField.frame.origin.x+260)];
    if (textField.tag>3)
        [self.ScrollView setContentOffset:CGPointMake(0, textField.frame.origin.x+160)];
    if (textField==txt_age) {
        UIDatePicker*  datePicker = [[UIDatePicker alloc]init];
        datePicker = [[UIDatePicker alloc]init];
        datePicker.datePickerMode = UIDatePickerModeDate;
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDate *currentDate1 = [NSDate date];
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        [comps setYear:-14];
        NSDate *maxDate = [calendar dateByAddingComponents:comps toDate:currentDate1 options:0];
        [comps setYear:-100];
        NSDate *minDate = [calendar dateByAddingComponents:comps toDate:currentDate1 options:0];
        [datePicker setMinimumDate:minDate];
        [datePicker setMinimumDate:minDate];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yyyy-MM-dd";
        
        [datePicker setMaximumDate:maxDate];
        
        // [datePicker setDate:[NSDate date]];
        [datePicker addTarget:self action:@selector(updateDateField:) forControlEvents:UIControlEventValueChanged];
        txt_age.inputView = datePicker;
        txt_age.text = [self formatDate:datePicker.date];
        [helper addDoneButtonForTextFiled:txt_age];
    }
    if (textField==txt_country) {
       
        EMCCountryPickerController *countryPicker1   = [self.storyboard instantiateViewControllerWithIdentifier:@"EMCCountryPickerController"];
        countryPicker1.showFlags = true;
        countryPicker1.countryDelegate = self;
        countryPicker1.drawFlagBorder = true;
        countryPicker1.flagBorderColor = [UIColor grayColor];
        countryPicker1.flagBorderWidth = 0.5f;
         [self presentViewController:countryPicker1 animated:YES completion:nil];
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
    [self.view removeGestureRecognizer:tap];
    [self.ScrollView setContentOffset:CGPointMake(0,0)];
    if(textField==txt_country){
        [self dismissPickerView:nil];
        [txt_email becomeFirstResponder];
    }
    if(textField==txt_age){
        [txt_password becomeFirstResponder];
    }
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

#pragma mark - validation
-(BOOL)validate{
    
    if (![InputValidator validateMandatoryFields:txt_firstName.text]){
        
        [helper alertWarningWithTitle:nil message:VALIDATION_FIRST_NAME delegate:self];
        return NO;
    }
    else if (![InputValidator validateMandatoryFields:txt_secondName.text]){
        
        [helper alertWarningWithTitle:nil message:VALIDATION_LAST_NAME delegate:self];
        return NO;
    }
//    else if (![InputValidator validateMandatoryFields:txt_country.text]){
//        
//        [helper alertWarningWithTitle:nil message:VALIDATION_COUNTRY delegate:self];
//        return NO;
//    }
    else if (![InputValidator validateEmail:txt_email.text]){
        
        [helper alertWarningWithTitle:nil message:VALIDATION_EMAIL delegate:self];
        return NO;
    }
//    else if (![InputValidator validateMandatoryFields:txt_age.text]){
//        
//        [helper alertWarningWithTitle:nil message:VALIDATION_DOB delegate:self];
//        return NO;
//    }
    else if (![InputValidator validatePassword:txt_password.text]){
        
        [helper alertWarningWithTitle:nil message:VALIDATION_PASSWORD delegate:self];
        return NO;
    }
    
    else if (![InputValidator validatePassword:txt_password.text andConfirm:txt_confirmPassword.text]){
        [helper alertWarningWithTitle:nil message:VALIDATION_CONFIRM_PASSWORD delegate:self];
        return NO;
    }
    else
        return YES;
    
}

@end
