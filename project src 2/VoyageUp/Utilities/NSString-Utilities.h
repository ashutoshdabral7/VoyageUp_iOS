//
//  NSString-Utilities.h
//  Refl_Utilities
//
//  Created by Reflections\Reflections mac pro on 02/04/15.
//  Copyright (c) 2015 Reflections\Reflections mac pro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString_Utilities : NSObject
+ (NSString *)trim:(NSString *)string;
+ (BOOL)isNumber:(NSString *)string;
+(NSString*)CapitalizeFirstLetter:(NSString*)string;
+(NSString*)CapitalizeString:(NSString*)string;
+ (BOOL)validateEmailIDForString:(NSString*)emailid;
+ (BOOL)validateEmptyString:(NSString*)string;
+ (BOOL)validatePasswordString:(NSString*)string;
/**
 *  check two given strings are equal
 *
 *  @param string1
 *  @param string2
 *
 *  @return return a bool value
 */
+(BOOL)validateStringEqual:(NSString*)string1 :(NSString*)string2;
/**
 *  check string 1 contains string 2
 *
 *  @param string1
 *  @param string2
 *
 *  @return return a bool value
 */
+(BOOL)stringContains:(NSString*)string1 :(NSString*)string2;
/**
 *  round decimal value
 *
 *  @param value input value
 *
 *  @return rounded value
 */
+(NSString*) roundValues:(NSString*)value;
@end
