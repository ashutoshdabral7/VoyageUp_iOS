//
//  ContactListCell.h
//  VoyageUp
//
//  Created by Deepak on 11/05/15.
//  Copyright (c) 2015 Deepak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactListCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imageView_userPhoto;
@property (strong, nonatomic) IBOutlet UILabel *lbl_userName;
@property (strong, nonatomic) IBOutlet UILabel *lbl_Country;
@end
