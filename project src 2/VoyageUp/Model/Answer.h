//
//  Answer.h
//  AskBaaghil
//
//  Created by Reflections\Reflections mac pro on 27/04/15.
//  Copyright (c) 2015 Reflections Info Systems. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Answer : NSObject
@property  NSString *answer;
@property  NSString *answerUserId;
@property  NSString *answerUserFirstName;
@property  NSString *answerUserLastNAme;
@property  NSString *answerUserPhoto;
@property  NSString *QuestionId;
@property  NSString *Question_userId;
@property  NSString * FirstName;
@property  NSString * LastName;
@property  NSString *ProfilePhoto;
@property  NSString *FullName;
+(Answer *)answerDictionary:(NSDictionary *)dict;


@end
