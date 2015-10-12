//
//  MyConnectionsViewController.m
//  VoyageUp
//
//  Created by Deepak on 02/05/15.
//  Copyright (c) 2015 Erbauen Labs. All rights reserved.
//

#import "MyConnectionsViewController.h"

@interface MyConnectionsViewController ()

@end

@implementation MyConnectionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   [self getMyConnections];
    //connectionArray=[[DataStoreManager sharedDataStoreManager]getAllconnectionsArray];
   // myConnectionArray=[[DataStoreManager sharedDataStoreManager]getAllmyConnectionsArray];

}
-(void)getMyConnections
{
    
  
        [[VoyageUpAPIManager sharedManager] GetConnectionList:^(NSDictionary*result,NSError *error) {
            
            
                NSArray *questionsArrayTemp=[result valueForKeyPath:@"all_connections"];
                NSMutableArray *myConnectionsArray=[result valueForKeyPath:@"my_connections"];
                NSMutableArray *qnArray = [NSMutableArray new];
                for (NSDictionary *pack in questionsArrayTemp)
                {
                    [qnArray addObject:[connectionItems connectionDictionary:pack]];
                }
            [[DataStoreManager sharedDataStoreManager] setAllmyConnectionsArrayFrom:myConnectionsArray];
                [[DataStoreManager sharedDataStoreManager] setAllconnectionsArrayFrom:qnArray];
                connectionArray=[[DataStoreManager sharedDataStoreManager]getAllconnectionsArray];
                myConnectionArray=[[DataStoreManager sharedDataStoreManager]getAllmyConnectionsArray];
           
             myConnectionArray=[helper intToStringArray:myConnectionArray];
                [self.tableView reloadData];
            
        }];
        
   
    
}
-(void)UpdateConnections:(NSArray*)connectionId
{
    NSArray *array= [[NSArray alloc]initWithObjects:@"3",@"1", nil];
    NSString * connectionIds = [array componentsJoinedByString:@","];
    NSDictionary *postobject = [NSDictionary dictionaryWithObjectsAndKeys:
                                connectionIds,POST_CONNECTIONTYPE_ID,
                                nil];
    
    [[VoyageUpAPIManager sharedManager] UpdateConnectionTypes:postobject WithCompletionblock:^(NSDictionary*result,NSError *error)
     {
         
         if (result != nil)
         {
           
         }
         else
         {
             
         }
         
     }];
    
}

-(IBAction)dismiss:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
    self.navigationItem.titleView = [helper SetNavTitle:SCREEN_CONNECTIONS];
    //------------****** ---------
   
}
-(void)viewWillDisappear:(BOOL)animated
{
     [super viewWillDisappear:animated];
    [self UpdateConnections:nil];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
   [self.tableView setSeparatorColor:COLOR_LINE_SEPARATOR];
    
    
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
    return connectionArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *mainMenuCellIdentifier = @"cell";
    ConnectionCell *cell = [tableView dequeueReusableCellWithIdentifier:mainMenuCellIdentifier];
    
    if (cell == nil)
        cell = [[ConnectionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mainMenuCellIdentifier];
  
    connectionItems *conection=[connectionArray objectAtIndex:indexPath.row];
    cell.lbl_connectionType.text=conection.ConnectionType;
    cell.lbl_connectionType.textColor=COLOR_TEXT;
    cell.lbl_connectionType.font = [UIFont fontWithName:FONT_NAME size:16];
    if ([myConnectionArray containsObject:conection.Connection_id])
        [cell.switch_connection setOn:YES animated:YES];
   else
        [cell.switch_connection setOn:NO animated:YES];
//    for (NSString *str in myConnectionArray) {
//        if ([str isEqualToString:conection.Connection_id])
//         [cell.switch_connection setOn:YES animated:YES];
//        else
//           [cell.switch_connection setOn:NO animated:YES];
//            }

      return cell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
