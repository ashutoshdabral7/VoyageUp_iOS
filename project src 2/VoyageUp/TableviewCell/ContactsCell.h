//
//  ContactsCell.h
//  VoyageUp
//
//  Created by Deepak on 02/05/15.
//  Copyright (c) 2015 Deepak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactsCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imageView_userPhoto;
@property (strong, nonatomic) IBOutlet UILabel *lbl_userName;
@property (strong, nonatomic) IBOutlet UILabel *lbl_lastMessage;
@end
