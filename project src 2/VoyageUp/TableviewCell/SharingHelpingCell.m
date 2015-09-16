//
//  SharingHelpingCell.m
//  VoyageUp
//
//  Created by Deepak on 10/05/15.
//  Copyright (c) 2015 Deepak. All rights reserved.
//

#import "SharingHelpingCell.h"

@implementation SharingHelpingCell

- (void)awakeFromNib {
    // Initialization code
    self.imageView_item.layer.cornerRadius = self.imageView_item.frame.size.width/2;
    self.imageView_item.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
