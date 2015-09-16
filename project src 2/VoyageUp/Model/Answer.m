//
//  Answer.m
//  AskBaaghil
//
//  Created by Reflections\Reflections mac pro on 27/04/15.
//  Copyright (c) 2015 Reflections Info Systems. All rights reserved.
//

#import "Answer.h"

@implementation Answer
+(Answer *)answerDictionary:(NSDictionary *)dict
{
    Answer *answer = [Answer new];
    answer.answer= [dict valueForKeyPath:@"Answer"];
  
    
    answer.answerUserId= [dict valueForKeyPath:@"UserId"];
    answer.answerUserFirstName= [dict valueForKeyPath:@"answer_type"];
    answer.answerUserLastNAme= [dict valueForKeyPath:@"answer_type"];
    answer.answerUserPhoto= [dict valueForKeyPath:@"answer_type"];
    answer.QuestionId= [dict valueForKeyPath:@"answer_type"];
    answer.Question_userId= [dict valueForKeyPath:@"answer_type"];
    answer.FirstName = [dict valueForKeyPath:@"FirstName"];
    answer.LastName = [dict valueForKeyPath:@"LastName"];
    answer.ProfilePhoto = [dict valueForKeyPath:@"ProfilePhoto"];
    answer.FullName=[NSString stringWithFormat:@"%@ %@",answer.FirstName,answer.LastName];
    return answer;
}
@end
