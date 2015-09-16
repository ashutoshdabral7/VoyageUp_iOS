//
//  Q&A_TableViewCell.h
//  VoyageUp
//
//  Created by Deepak on 10/05/15.
//  Copyright (c) 2015 Deepak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Q_A_TableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lbl_qn;
@property (strong, nonatomic) IBOutlet UILabel *lbl_postDate;
@property (strong, nonatomic) IBOutlet UILabel *lbl_userName;
@property (strong, nonatomic) IBOutlet UIImageView *imageView_user;
@end
