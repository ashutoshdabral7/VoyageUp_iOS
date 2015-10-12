//
//  VUChatMessageViewController.h
//  VoyageUp
//
//  Created by Deepak on 16/05/15.
//  Copyright (c) 2015 Erbauen Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileDetails.h"
#import "ChatMessageTableViewCell.h"
@interface VUChatMessageViewController : UIViewController<UITextViewDelegate,ChatMessageTableViewCellDelegate,UIScrollViewDelegate>
{
    NSString *myName;
    NSString *myImage;
    CGRect previousRect;
    NSTimer *repeatTimer;
}

@property(nonatomic ,retain) NSMutableArray *arrayChatMessages;
@property(nonatomic ,retain) IBOutlet UITableView *chatListTableView;
@property(nonatomic ,retain) IBOutlet UITextView *msgTextView;

- (IBAction)sendNewMessage:(id)sender;
@property (strong, nonatomic)ProfileDetails *userProfile;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomPositionViewConstraint;
@property (strong, nonatomic) NSString *user_id;
@end
