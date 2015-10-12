//
//  SharingHelpingCell.h
//  VoyageUp
//
//  Created by Deepak on 10/05/15.
//  Copyright (c) 2015 Erbauen Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SharingHelpingCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lbl_itemName;
@property (strong, nonatomic) IBOutlet UILabel *lbl_itemText;
@property (strong, nonatomic) IBOutlet UILabel *lbl_postDate;
@property (strong, nonatomic) IBOutlet UIImageView *imageView_item;

@end
