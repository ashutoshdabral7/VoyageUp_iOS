//
//  NSDictionary+NullValidation.m
//  InKit
//
//  Created by Vishnu K V on 20/01/15.
//  Copyright (c) 2015 Reflections. All rights reserved.
//

#import "NSDictionary+NullValidation.h"

@implementation NSDictionary (NullValidation)

- (NSDictionary *) dictionaryByReplacingNullsWithStrings
{
    const NSMutableDictionary *replaced = [NSMutableDictionary dictionaryWithDictionary: self];
    const id nul = [NSNull null];
    const NSString *blank = @"";
    
    for (NSString *key in self) {
        const id object = [self objectForKey: key];
        if (object == nul) {
            [replaced setObject: blank forKey: key];
        }
        else if([object isKindOfClass:[NSString class]] &&  [object isEqualToString:@"<null>"]){
            [replaced setObject: blank forKey: key];
        }
        else if ([object isKindOfClass: [NSDictionary class]]) {
            [replaced setObject: [(NSDictionary *) object dictionaryByReplacingNullsWithStrings] forKey: key];
        }
    }
    return [NSDictionary dictionaryWithDictionary:(NSDictionary *)replaced];
}


@end
