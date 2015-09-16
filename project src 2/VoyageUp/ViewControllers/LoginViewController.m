//
//  LoginViewController.m
//  VoyageUp
//
//  Created by Deepak on 03/05/15.
//  Copyright (c) 2015 Deepak. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end
static NSString * const kClientId = @"349188679231-3g830iqsnh658js9a3dqajcrfoogtd19.apps.googleusercontent.com";

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //**************** google   -------
    //    GPPSignIn *signIn = [GPPSignIn sharedInstance];
    //    signIn.shouldFetchGooglePlusUser = YES;
    //    signIn.scopes= [NSArray arrayWithObjects:kGTLAuthScopePlusLogin, nil];
    //    signIn.shouldFetchGoogleUserID=YES;
    //    signIn.shouldFetchGoogleUserEmail=YES;
    //    signIn.shouldFetchGooglePlusUser=YES;
    //    //signIn.shouldFetchGoogleUserEmail = YES;  // Uncomment to get the user's email
    //
    //    // You previously set kClientId in the "Initialize the Google+ client" step
    //    signIn.clientID = kClientId;
    //
    //    // Uncomment one of these two statements for the scope you chose in the previous step
    //    signIn.scopes = @[ kGTLAuthScopePlusLogin ];  // "https://www.googleapis.com/auth/plus.login" scope
    //    //signIn.scopes = @[ @"profile" ];            // "profile" scope
    //
    //    // Optional: declare signIn.actions, see "app activities"
    //    signIn.delegate = self;
    //    [self.signInButton setImage:nil forState:UIControlStateNormal];
    //    [self.signInButton setImage:nil forState:UIControlStateSelected];
    //****************    -------
    
    
    tap = [[UITapGestureRecognizer alloc]
           initWithTarget:self
           action:@selector(dismissKeyboard)];
    view_loginBg.layer.borderColor = COLOR_LINE_SEPARATOR.CGColor;
    view_loginBg.layer.borderWidth = 0.5;
    // Do any additional setup after loading the view.
    if ([UIScreen mainScreen].bounds.size.height<667)
        constrain_view=20;
    else
        constrain_view=78;
    self.verticalconstraint.constant=constrain_view;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
#ifdef DEBUG
    //txt_userName.text=@"john@yopmail.com";  txt_passWord.text=@"123456";
    
#endif
    @try {
        
        
        
        NSString  *username =[DataStoreManager getUserName];// [SSKeychain passwordForService:@"username" account:@"VoyageUp"];
        NSString  *password =[DataStoreManager getPassword];// [SSKeychain passwordForService:@"password" account:@"VoyageUp"];
        if (password.length>0) {
            txt_userName.text=username;
            [self login:username Password:password validate:YES];
        }
    }
    @catch (NSException *exception) {
        
    }
}
#pragma mark - api calls
-(void)forgotPasswordCall:(NSString*)email{
    
    NSDictionary *postobject = [NSDictionary dictionaryWithObjectsAndKeys:
                                email,POST_EMAIL,
                                nil];
    
    [[VoyageUpAPIManager sharedManager] Forgotpassword:postobject WithCompletionblock:^(NSDictionary*result,NSError *error)
     {
         @try {
             
             if (result != nil)
             {
                 NSString *title = [result objectForKey:@"title"];
                 NSString *message = [result objectForKey:@"message"];
                 [helper ShowSuccessAlert:self withTitle:title withMessage:message];
                 
             }
             
         }
         @catch (NSException *exception) {
             
         }
     }];
}
-(void)login:(NSString*)loginType Password:(NSString*)password validate:(BOOL)state
{
    [self.view endEditing:YES];
    if (state) {
        
        NSDictionary *postobject = [NSDictionary dictionaryWithObjectsAndKeys:
                                    loginType,POST_EMAIL,
                                    password,POST_PASSWORD,
                                    
                                    nil];
        
        [[VoyageUpAPIManager sharedManager] Login:postobject WithCompletionblock:^(NSDictionary*result,NSError *error)
         {
             //             @try {
             
             if (result != nil)
             {
                 NSString *title = [result objectForKey:@"status"];
                 NSString *message = [result objectForKey:@"message"];
                 
                 if ([[result valueForKeyPath:@"status"] isEqualToString:@"success"])
                 {
                     [[ProfileDetails getProfileDetails] saveUserDetails:[result objectForKey:@"result"]];
                     AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                     appDelegate.Islogin=TRUE;
                     [SSKeychain setPassword:loginType forService:@"username" account:@"VoyageUp"];
                     [SSKeychain setPassword:password forService:@"password" account:@"VoyageUp"];
                     [DataStoreManager saveUserName:loginType password:password];
                     appDelegate.firstTime=true;
                     [self.delegate LoginSuccess];
                     [self dismissViewControllerAnimated:YES completion:nil];
                     
                 }
                 else
                 {
                     
                     [helper alertErrorWithTitle1:title message:message delegate:self];
                 }
             }
             
             //             }
             //             @catch (NSException *exception) {
             //
             //             }
         }];
    }
    
}

#pragma mark - textfiled delegate methods
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.view addGestureRecognizer:tap];
    view_loginBg.backgroundColor=[UIColor whiteColor];
    self.verticalconstraint.constant = constrain_view-88;
    //[self.subview1 setFrame:CGRectMake(0,200,self.view.window.frame.size.width,131)];
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    view_loginBg.backgroundColor=[UIColor clearColor];
    [self.view removeGestureRecognizer:tap];
    self.verticalconstraint.constant = constrain_view;
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
#pragma mark Button action methods
- (IBAction)signUp_clicked:(id)sender
{
    UIStoryboard* sb= [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SignUpViewController *obj   = [sb instantiateViewControllerWithIdentifier:SB_ID_SIGNUP];
    obj.modalPresentationStyle= UIModalPresentationCustom;
    obj.delegate=self;
    [self presentViewController:obj animated:YES completion:nil];
    
}

- (IBAction)login_clicked:(id)sender
{
    if ([self validateLoginCredentials])
        [self login:txt_userName.text Password:txt_passWord.text validate:YES];
    
}

- (IBAction)forgotPassword:(id)sender
{
    
    NSString *kInfoTitle = @"Forgot Password?";
    NSString *kSubtitle = @"Please enter your Email";
    NSString *kButtonTitle = @"Cancel";
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    alert.shouldDismissOnTapOutside = YES;
    alert.showAnimationType = SlideInToCenter;
    txt_forgotPassword = [alert addTextField:@"Enter your Email"];
    txt_forgotPassword.delegate = self;
    txt_forgotPassword.autocorrectionType = UITextAutocorrectionTypeNo;
    txt_forgotPassword.keyboardType = UIKeyboardTypeEmailAddress;
    alert.backgroundViewColor=COLOR_MAIN_BG;
    [alert addButton:@"Done" actionBlock:^(void) {
        
        [self forgotPasswordCall:txt_forgotPassword.text];
        
        
    }];
    [alert showEdit:self title:kInfoTitle subTitle:kSubtitle closeButtonTitle:kButtonTitle duration:0.0f];
    
    
}

- (IBAction)loginWithFacebook:(id)sender {
    
    
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
                         [FBSession.activeSession closeAndClearTokenInformation];
                         [self login:[user valueForKeyPath:@"email"] Password:@"123" validate:YES];
                         
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

#pragma mark signup success
- (void)signUpSuccess:(NSString *)usrName pswd:(NSString*)pswd autologin:(BOOL)status
{
    if (status) {
        [self login:usrName Password:pswd validate:YES];
    }
    else{
        txt_userName.text=usrName;
        txt_passWord.text=pswd;
    }
}
#pragma mark - validation
-(BOOL)validateLoginCredentials{
    
    if (![InputValidator validateMandatoryFields:txt_userName.text]){
        
        [helper alertWarningWithTitle:nil message:VALIDATION_USERNAME delegate:self];
        
        
        return NO;
    }
    else if (![InputValidator validatePassword:txt_passWord.text]){
        [helper alertWarningWithTitle:nil message:VALIDATION_PASSWORD delegate:self];
        return NO;
    }
    else
        return YES;
    
}
@end
#pragma mark google method
//- (void)finishedWithAuth: (GTMOAuth2Authentication *)auth
//                   error: (NSError *) error {
//    NSLog(@"Received error %@ and auth object %@",error, auth);
//
//    NSLog(@"Received  %@ , %@",auth.userEmail, auth.userID);
//    NSLog(@"Received Access Token:%@",auth);
//  //  NSLog(@"user google user id  %@",signIn.userEmail);
//    [self refreshInterfaceBasedOnSignIn];
//    GTLQueryPlus *query = [GTLQueryPlus queryForPeopleGetWithUserId:@"me"];
//    NSLog(@"email %@ ", [NSString stringWithFormat:@"Email: %@",[GPPSignIn sharedInstance].authentication.userEmail]);
//    NSLog(@"Received error %@ and auth object %@",error, auth);
//
//    // 1. Create a |GTLServicePlus| instance to send a request to Google+.
//    GTLServicePlus* plusService = [[GTLServicePlus alloc] init] ;
//    plusService.retryEnabled = YES;
//
//    // 2. Set a valid |GTMOAuth2Authentication| object as the authorizer.
//    [plusService setAuthorizer:[GPPSignIn sharedInstance].authentication];
//
//    // 3. Use the "v1" version of the Google+ API.*
//    plusService.apiVersion = @"v1";
//    [plusService executeQuery:query
//            completionHandler:^(GTLServiceTicket *ticket,
//                                GTLPlusPerson *person,
//                                NSError *error) {
//                if (error) {
//                    //Handle Error
//                } else {
//                    NSLog(@"Email= %@", [GPPSignIn sharedInstance].authentication.userEmail);
//                    NSLog(@"GoogleID=%@", person.identifier);
//                    NSLog(@"User Name=%@",person.name.givenName);
//                    NSLog(@"User Name=%@", [person.name.givenName stringByAppendingFormat:@" %@", person.name.familyName]);
//                    NSLog(@"Gender=%@", person.image);
//                    //[self setDetails_google:[GPPSignIn sharedInstance].authentication.userEmail :[person.name.givenName stringByAppendingFormat:@" %@", person.name.familyName] :person.identifier :person.image.url];
//                }
//            }];
//
//}
//
//-(void)refreshInterfaceBasedOnSignIn {
//    if ([[GPPSignIn sharedInstance] authentication]) {
//        // The user is signed in.
//        self.signInButton.enabled = NO;
//        // Perform other actions here, such as showing a sign-out button
//    } else {
//        self.signInButton.enabled = TRUE;
//        // Perform other actions here
//    }
//}
//- (IBAction)loginWithGoogle:(id)sender {
//}

