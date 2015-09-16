//
//  ContactsCell.m
//  VoyageUp
//
//  Created by Deepak on 02/05/15.
//  Copyright (c) 2015 Deepak. All rights reserved.
//

#import "ContactsCell.h"

@implementation ContactsCell

- (void)awakeFromNib {
    self.imageView_userPhoto.layer.cornerRadius = self.imageView_userPhoto.frame.size.width/2;
    self.imageView_userPhoto.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
