//
//  InKitHttpUtility.h
//  InKit
//
//  Created by Vishnu K V on 07/01/15.
//  Copyright (c) 2015 Reflections. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpUtility : NSObject

+ (NSString *)getUrlWithPath: (NSString *)url;
+ (NSString *)getMD5hashFromString: (NSString*)stringToEncrypt;
+ (NSString *)getImageUrl: (NSString *)url;
@end
