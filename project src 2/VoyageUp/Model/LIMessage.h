//
//  LIMessage.h
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LIMessage : NSObject

typedef enum
{
    LIMESSAGE_TEXTMESSAGE_MODE_SENT       = 0,
    LIMESSAGE_TEXTMESSAGE_MODE_RECEIVED   = 1,
    LIMESSAGE_MONEYMESSAGE_MODE_SENT      = 2,
    LIMESSAGE_MONEYMESSAGE_MODE_RECEIVED  = 3,
}
LIMESSAGE_CONTENT_MODE;

typedef enum
{
    LIMESSAGE_MODE_SENT       = 0,
    LIMESSAGE_MODE_RECEIVED   = 1,
}
LIMESSAGE_MODE;

//binding from LIMessageParser
@property (nonatomic, strong) NSString *messageId;
@property (nonatomic, strong) NSString *messageType;
@property (nonatomic, strong) NSString *messageText;
@property (nonatomic, strong) NSString *messageReceivedDate;
@property (nonatomic, strong) NSString *messageSentDate;
@property (nonatomic, strong) NSString *messageTo;
@property (nonatomic, strong) NSString *messageFrom;
@property (nonatomic, assign) CGFloat   messageHeight;




@property (nonatomic, strong) NSString *messageReadDate;

@property (nonatomic, strong) NSString *messageReceivedDisplayTime;

@property (nonatomic, assign) BOOL      hasImage;
@property (nonatomic, assign) BOOL      hasAmount;
@property (nonatomic, assign) BOOL      hasDeal;
@property (nonatomic, assign) BOOL      isConfirmed;
@property (nonatomic, assign) BOOL      isDeclined;



@property (nonatomic, strong) NSString *messageReceiver;
@property (nonatomic, strong) NSString *messageOwner;
@property (nonatomic, strong) NSString *messageTitle;
@property (nonatomic, strong) NSString *messageUnformattedTitle;

@property (nonatomic, strong) NSString *messageDealIdentifier;
@property (nonatomic, strong) NSString *messageHeaderTime;
@property (nonatomic, strong) NSString *messageFooterStatus;


@property (nonatomic, assign) BOOL      isMessageAccepted;
@property (nonatomic, assign) BOOL      isMessageDelivered;
@property (nonatomic, strong) UIImage  *messageProfileImage;



@property (nonatomic, assign) LIMESSAGE_MODE messageMode;
@property (nonatomic, assign) LIMESSAGE_CONTENT_MODE messageContentMode;

//@property (nonatomic, strong) NSString *validPin;
//@property (nonatomic, strong) NSString *messageImage;
//@property (nonatomic, strong) NSString *messageAmount;
//@property (nonatomic, assign) BOOL      isSendMoneyMessage;
//@property (nonatomic, assign) BOOL      isServiceMessage;
//@property (nonatomic, assign) BOOL      isShowMessageTime;
//@property (nonatomic, strong) UIImage  *messageAttachmentImage;


+(LIMessage *)latestMessagesDictonery:(NSDictionary *)dict;

+ (CGFloat)manageMessageCellHeightWithMessage :(LIMessage *)message;









@end
