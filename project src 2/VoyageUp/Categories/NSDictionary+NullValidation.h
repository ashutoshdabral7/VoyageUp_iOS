//
//  NSDictionary+NullValidation.h
//  InKit
//
//  Created by Vishnu K V on 20/01/15.
//  Copyright (c) 2015 Reflections. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (NullValidation)

- (NSDictionary *) dictionaryByReplacingNullsWithStrings;

@end
