//
//  ConnectionCell.h
//  VoyageUp
//
//  Created by Deepak on 02/05/15.
//  Copyright (c) 2015 Erbauen Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConnectionCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *connectionType;
@property (strong, nonatomic) IBOutlet UISwitch *switch_connection;
@property (strong, nonatomic) IBOutlet UILabel *lbl_connectionType;
@end
