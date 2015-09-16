//
//  NSString-Utilities.m
//  Refl_Utilities
//
//  Created by Reflections\Reflections mac pro on 02/04/15.
//  Copyright (c) 2015 Reflections\Reflections mac pro. All rights reserved.
//

#import "NSString-Utilities.h"
#define PASSWORD_LENGTH    8
@implementation NSString_Utilities

+ (NSString *)trim:(NSString *)string //------- trim the string and return the value
{
    return [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
}

+ (BOOL)isNumber:(NSString *)string //---- check wheather the string is a number or not
{
    NSRange nond = [string rangeOfCharacterFromSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]];
    if (NSNotFound == nond.location) {
        return YES;
    } else {
        return NO;
    }
}

+(NSString*)CapitalizeFirstLetter:(NSString*)string //---- capitalize the first letter of the string
{
    NSString *str=[NSString_Utilities trim:string];
    return [str capitalizedString] ;
}

+(NSString*)CapitalizeString:(NSString*)string //---- convert to uppercase string
{
    NSString *str=[NSString_Utilities trim:string];
    return [str uppercaseString] ;
}

+ (BOOL)validateEmailIDForString:(NSString*)emailid
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:[NSString_Utilities trim:emailid]];
}

+ (BOOL)validateEmptyString:(NSString*)string
{
    if ([NSString_Utilities trim:string].length>0)
        return  YES;
    
    else
        return NO;
    
}

+ (BOOL)validatePasswordString:(NSString*)string
{
    if ([NSString_Utilities trim:string].length>PASSWORD_LENGTH)
        return  YES;
    
    else
        return NO;
    
}

+(BOOL)validateStringEqual:(NSString*)string1 :(NSString*)string2
{
    return ([[NSString_Utilities trim:string1] isEqualToString:[NSString_Utilities trim:string2]]);
    
}

+(BOOL)stringContains:(NSString*)string1 :(NSString*)string2
{
    return ([[NSString_Utilities trim:string1] containsString:[NSString_Utilities trim:string2]]);
    
}
+(NSString*) roundValues:(NSString*)value{
    @try{
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        
        [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
        [formatter setMinimumFractionDigits:0];//----- set minimum decimal points
        [formatter setMaximumFractionDigits:0];//----- set maximum decimal points
        [formatter setRoundingMode: NSNumberFormatterRoundFloor];
        NSString *numberString = [formatter stringFromNumber:[NSNumber numberWithFloat:[value floatValue]]];
        
 
        return numberString;
    }
    @catch (NSException *exception)
    {
        return nil;
    }
}
@end
