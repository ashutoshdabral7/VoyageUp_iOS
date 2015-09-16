//
//  InputValidator.h
//  Doc Halo
//
//  Created by Adarsh V C on 23/05/11.
//  Copyright 2011 DBG. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface InputValidator : NSObject
    
+ (BOOL)validateEmail:(NSString *)email;

+ (BOOL)validatePassword:(NSString *)password; 

+ (BOOL)validatePassword:(NSString *)password andConfirm:(NSString *)confirmPassword; 

+ (BOOL)validateCellPhone:(NSString *)phone;

+ (BOOL)validateZipCode:(NSString *)zipCode;

+ (BOOL)validateState:(NSString *)state;

+ (BOOL)validateMandatoryFields:(NSString *)string;

+ (NSString *)nullValidate:(NSString *)string;

+ (NSString *)getFullNameWith:(NSString *)firstName andLastName:(NSString *)lastName;

+ (NSString *)trimNonDigitCharactersForThePhoneNumber:(NSString *)phoneNumberWithCharacters;

+(BOOL)validateNumberOnly:(NSString*)number;
@end
