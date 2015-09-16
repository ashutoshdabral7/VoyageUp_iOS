//
//  ChatMessageTableViewCell.h
//  SampleChat
//
//  Created by DebutMac3 on 03/09/14.
//  Copyright (c) 2014 Sky. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "LIMessage.h"
@protocol ChatMessageTableViewCellDelegate<NSObject>
-(void)downloadRecording:(UITableViewCell*)cell;

@end

@interface ChatMessageTableViewCell : UITableViewCell
@property (nonatomic, strong) UITextView  *messageTextView;
@property (nonatomic, strong) UILabel     *dateLabel;
@property (nonatomic, strong) UIImageView *msgSeenImageView;

@property (nonatomic, strong) NSString *isMsgSeen;
@property (nonatomic, strong) UIImageView *backgroundImageView;

@property (nonatomic, strong) UIImageView *recordingImageView;
@property (nonatomic, strong) UIButton *recordingButton;



@property(unsafe_unretained)id<ChatMessageTableViewCellDelegate>delegate;


+ (CGFloat)heightForCellWithMessage2:(LIMessage *)messageInfo;

- (void)configureCellWithMessage2:(LIMessage *)messageInfo senderName:(NSString*)senderName row:(NSInteger)rowNo mymessage:(BOOL)sender;


@end
