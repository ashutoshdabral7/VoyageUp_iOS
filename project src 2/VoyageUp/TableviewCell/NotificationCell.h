//
//  NotificationCell.h
//  VoyageUp
//
//  Created by Deepak on 13/05/15.
//  Copyright (c) 2015 Deepak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lbl_Notification;
@property (strong, nonatomic) IBOutlet UILabel *lbl_postDate;
@property (strong, nonatomic) IBOutlet UILabel *lbl_User;
@property (strong, nonatomic) IBOutlet UIImageView *imageView_item;
@end
