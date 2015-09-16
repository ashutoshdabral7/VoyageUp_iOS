//
//  connectionItems.h
//  VoyageUp
//
//  Created by Deepak on 22/05/15.
//  Copyright (c) 2015 Deepak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface connectionItems : NSObject
@property (nonatomic,strong) NSString* ConnectionType;
@property (nonatomic,strong) NSString* Connection_id;
@property (nonatomic,strong) NSArray* my_connections;
+(connectionItems *)connectionDictionary:(NSDictionary *)dict;
@end
