//
//  ChatMessageTableViewCell.m
//  SampleChat
//
//  Created by DebutMac3 on 03/09/14.
//  Copyright (c) 2014 Sky. All rights reserved.
//

#import "ChatMessageTableViewCell.h"
#import "UIImageView+WebCache.h"
#define padding 20
#define myPad 8
#define extraHtForTimeLbl 10
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define messageWidth                        200
#define temp -10
@implementation ChatMessageTableViewCell
@synthesize delegate;
static NSDateFormatter *messageDateFormatter;
static UIImage *orangeBubble;
static UIImage *aquaBubble;
- (void)awakeFromNib
{
    // Initialization code
    
    // init bubbles
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


+ (CGFloat)heightForCellWithMessage2:(LIMessage *)messageInfo
{
    NSString *text = messageInfo.messageText;
    CGSize boundingSize = CGSizeMake(messageWidth-20, 10000000);
    
    CGRect itemText = [text  boundingRectWithSize:boundingSize
                                          options:NSStringDrawingUsesLineFragmentOrigin
                                       attributes:@{NSFontAttributeName:[UIFont fontWithName:FONT_MONT_LIGHT size:16]}
                                          context:nil];
    CGSize size = itemText.size;
    
    size.height += 30.0;
    return size.height;
    
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    orangeBubble = [[UIImage imageNamed:@"BlueCloud"] stretchableImageWithLeftCapWidth:25  topCapHeight:15];
    
    aquaBubble = [[UIImage imageNamed:@"GreyCloud"] stretchableImageWithLeftCapWidth:25  topCapHeight:15];
    
    if (self)
    {
        
        //        [self.contentView addSubview:self.dateLabel];
        
        self.backgroundImageView = [[UIImageView alloc] init];
        [self.backgroundImageView setFrame:CGRectZero];
        [self.contentView addSubview:self.backgroundImageView];
        
        
        self.msgSeenImageView = [[UIImageView alloc] init];
        [self.msgSeenImageView setFrame:CGRectZero];
        [self.msgSeenImageView setBackgroundColor:[UIColor clearColor]];
        
        self.msgSeenImageView.image=[UIImage imageNamed:@"sendIcon.png"];
        // [self.backgroundImageView addSubview:self.msgSeenImageView];
        
        self.messageTextView = [[UITextView alloc] init];
        [self.messageTextView setBackgroundColor:[UIColor clearColor]];
        [self.messageTextView setEditable:NO];
        self.messageTextView.selectable=NO;
        [self.messageTextView setScrollEnabled:NO];
          [self.messageTextView setFont:[UIFont fontWithName:FONT_MONT_LIGHT size:15.0f]];
        [self.messageTextView sizeToFit];
        [self.messageTextView setTextColor:[UIColor blackColor]];
         [self.contentView addSubview:self.messageTextView];
        [self setBackgroundColor:[UIColor clearColor]];
        
        
        
        
        
    }
    return self;
}


- (void)configureCellWithMessage2:(LIMessage *)messageInfo senderName:(NSString*)senderName row:(NSInteger)rowNo mymessage:(BOOL)sender
{
    NSString *msg=messageInfo.messageText;
    
    self.messageTextView.text=msg;
    
    
    CGSize boundingSize = CGSizeMake(messageWidth-20, 10000000);
    
    CGRect itemText = [msg  boundingRectWithSize:boundingSize
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:@{NSFontAttributeName:[UIFont fontWithName:FONT_MONT_LIGHT size:16]}
                                         context:nil];
    
    CGSize size = itemText.size;
    size.width += 10;
    // Left/Right bubble
    if (sender) //---- my messsages
    {
        
        
        [self.messageTextView setFrame:CGRectMake((SCREEN_WIDTH-size.width-padding/2-5), padding+temp, size.width, size.height+myPad)];
        
        
        //            [self.messageTextView sizeToFit];
        
        if (size.width+100 <= 260)
        {
            [self.messageTextView setFrame:CGRectMake(self.messageTextView.frame.origin.x-56, 5, size.width, size.height+myPad)];
            
            [self.backgroundImageView setFrame:CGRectMake((SCREEN_WIDTH-size.width-padding/2-5)-55, padding+temp,
                                                          self.messageTextView.frame.size.width+padding/2+55, self.messageTextView.frame.size.height+extraHtForTimeLbl)];
            
            
            
            [self.msgSeenImageView setFrame:CGRectMake(self.backgroundImageView.frame.size.width-18,self.backgroundImageView.frame.size.height- 19, 15, 15)];
        }
        else
        {
            
            [self.messageTextView setFrame:CGRectMake((SCREEN_WIDTH-size.width-padding/2-5), 3.5, size.width, size.height+myPad)];
            
            [self.backgroundImageView setFrame:CGRectMake(SCREEN_WIDTH-size.width-padding/2-5, padding+temp,
                                                          self.messageTextView.frame.size.width+padding/2, self.messageTextView.frame.size.height-4+extraHtForTimeLbl)];
            
            ;
            
            [self.msgSeenImageView setFrame:CGRectMake(self.backgroundImageView.frame.size.width-18,self.backgroundImageView.frame.size.height-19, 15, 15)];
        }
        
        
        if (self.backgroundImageView.frame.size.width<75) {
            [self.messageTextView setFrame:CGRectMake((SCREEN_WIDTH-80), padding+temp, size.width, size.height+myPad)];
            //                [self.messageTextView sizeToFit];
            [self.backgroundImageView setFrame:CGRectMake(SCREEN_WIDTH-80, padding+temp,
                                                          75, self.messageTextView.frame.size.height-4+extraHtForTimeLbl)];
            
            
            
            [self.msgSeenImageView setFrame:CGRectMake(self.backgroundImageView.frame.size.width-18,self.backgroundImageView.frame.size.height-19, 15, 15)];
        }
          self.backgroundImageView.image = orangeBubble;
        
        [ self.recordingButton removeFromSuperview];
        
  
    }
    else ///---- others messages
    {
        
        [self.messageTextView setFrame:CGRectMake(padding-15, padding+temp, size.width, size.height+myPad)];
        
        //            [self.messageTextView sizeToFit];
        
        if (size.width+54 < 200)
        {
            [self.messageTextView setFrame:CGRectMake(padding-15, 5, size.width, size.height+myPad)];
            [self.backgroundImageView setFrame:CGRectMake(padding/2-5, padding+temp,
                                                          self.messageTextView.frame.size.width+padding/2+40, self.messageTextView.frame.size.height+extraHtForTimeLbl)];
            
            [self.dateLabel setFrame:CGRectMake(self.backgroundImageView.frame.size.width-55, self.backgroundImageView.frame.size.height-20,50, 20)];
        }
        else
        {
            
            [self.messageTextView setFrame:CGRectMake(padding-15, 3.5, size.width, size.height+myPad)];
            
            [self.backgroundImageView setFrame:CGRectMake(padding/2-5, padding+temp,
                                                          self.messageTextView.frame.size.width+padding/2, self.messageTextView.frame.size.height+14)];

        }
        
        
        if (self.backgroundImageView.frame.size.width<50)
        {
            [self.backgroundImageView setFrame:CGRectMake(padding/2-5, padding+temp,
                                                          50, self.messageTextView.frame.size.height-4+extraHtForTimeLbl)];
   
        }
        
        
        self.backgroundImageView.image = aquaBubble;
        
        [ self.recordingButton removeFromSuperview];
    }
    
}

@end
