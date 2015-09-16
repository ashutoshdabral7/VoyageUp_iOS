

#import "InputValidator.h"


@implementation InputValidator

+ (BOOL)validateEmail:(NSString *)email 
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"; 
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex]; 
    
    return [emailTest evaluateWithObject:email];
}

+ (BOOL)validatePassword:(NSString *)password 
{
    if ([password length]>=6)
    {
        return YES;
    } 
    else
    {
        return NO;
    }
}

+ (BOOL)validatePassword:(NSString *)password andConfirm:(NSString *)confirmPassword 
{
    if ([password isEqualToString:confirmPassword])
    {
        return YES;
    } 
    else
    {
        return NO;
    }
}
+(BOOL)validateNumberOnly:(NSString *)number
{
    NSString *phoneRegex = @"[0-9]{0}";
    NSPredicate *phonePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    
    return [phonePredicate evaluateWithObject:number];
}
+ (BOOL)validateCellPhone:(NSString *)phone
{
    NSString *phoneRegex = @"[0-9]{5,12}";  
    NSPredicate *phonePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex]; 
    
    return [phonePredicate evaluateWithObject:phone];
}

+ (BOOL)validateZipCode:(NSString *)zipCode
{

    NSString *zipRegex = @"[0-9]{5}"; 
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",zipRegex]; 
        
    return [predicate evaluateWithObject:zipCode];    
    
}

+ (BOOL)validateState:(NSString *)state
{
    NSString *stateRegex = @"[A-Z]{2}"; 
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",stateRegex]; 
    
    return [predicate evaluateWithObject:state];    
}

+ (BOOL)validateMandatoryFields:(NSString *)string
{
    if ([string length]>0)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+ (NSString *)nullValidate:(NSString *)string
{
    if ([string length]>0)
    {
        return string;
    }
    else
    {
        return @"";
    }
    
}

+ (NSString *)getFullNameWith:(NSString *)firstName andLastName:(NSString *)lastName
{
    NSString *fullName = [NSString stringWithFormat:@"%@ %@",[InputValidator nullValidate:firstName],[InputValidator nullValidate:lastName]];
    if ([fullName length]>0)
    {
        return fullName;
    }
    else
    {
        return @"";
    }
    
}

//  This method will trim all non digit characters for phone number.
+ (NSString *)trimNonDigitCharactersForThePhoneNumber:(NSString *)phoneNumberWithCharacters
{
    NSString *phoneNumber = [[phoneNumberWithCharacters componentsSeparatedByCharactersInSet:
                              [[NSCharacterSet decimalDigitCharacterSet] invertedSet]]
                             componentsJoinedByString:@""];
    
    return phoneNumber;
    
}

@end
