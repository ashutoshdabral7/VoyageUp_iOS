//
//  Questions.m
//  AskBaaghil
//
//  Created by Reflections\Reflections mac pro on 14/04/15.
//  Copyright (c) 2015 Reflections Info Systems. All rights reserved.
//

#import "Questions.h"

@implementation Questions
+(Questions *)questionsDictionary:(NSDictionary *)dict
{
    Questions *Question = [Questions new];
    
    Question.Question= [dict valueForKeyPath:@"Question"];;
    Question.qn_id= [NSString stringWithFormat:@"%@", [dict objectForKey:@"QuestionId"]];
    Question.user_id=[NSString stringWithFormat:@"%@", [dict objectForKey:@"userId"]];
    Question.FirstName = [dict valueForKeyPath:@"FirstName"];
    Question.LastName = [dict valueForKeyPath:@"LastName"];
    Question.ProfilePhoto = [dict valueForKeyPath:@"ProfilePhoto"];
   
    
 
    //Question.photo_url=[NSString_Utilities trim:[dict valueForKeyPath:@"photo"]];
    Question.FullName=[NSString stringWithFormat:@"%@ %@",Question.FirstName,Question.LastName];
    NSArray *answerArray = [dict objectForKey:@"answer"];
    NSMutableArray *answer = [NSMutableArray new];
    for (NSDictionary *an in answerArray)
    {
        [answer addObject:[Answer answerDictionary:[an dictionaryByReplacingNullsWithStrings]]];
    }
    Question.allAnswers=answer;
    
    return Question;
}
@end
