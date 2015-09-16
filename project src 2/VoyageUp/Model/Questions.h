//
//  Questions.h
//  AskBaaghil
//
//  Created by Reflections\Reflections mac pro on 14/04/15.
//  Copyright (c) 2015 Reflections Info Systems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Answer.h"
@interface Questions : NSObject
@property  NSString *Question;
@property  NSString *qn_id;
@property  BOOL isanswered;
@property  NSNumber *date;
@property  NSString *questionType;
@property  NSString *answer;
@property  NSString *user_name;
@property  NSString *user_about;
@property  NSString *user_id;
@property  NSString *answer_count;
@property  NSString *photo_url;
@property NSMutableArray *allAnswers;
@property BOOL paymentType;
@property  NSString *FullName;
@property (nonatomic,strong) NSString* FirstName;
@property (nonatomic,strong) NSString* LastName;

@property (nonatomic,strong) NSString* ProfilePhoto;
@property (nonatomic,strong) NSString* UserId;
+(Questions *)questionsDictionary:(NSDictionary *)dict;
@end
