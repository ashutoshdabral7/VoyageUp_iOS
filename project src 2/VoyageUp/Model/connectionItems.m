//
//  connectionItems.m
//  VoyageUp
//
//  Created by Deepak on 22/05/15.
//  Copyright (c) 2015 Deepak. All rights reserved.
//

#import "connectionItems.h"

@implementation connectionItems
+(connectionItems *)connectionDictionary:(NSDictionary *)dict
{
    connectionItems *connection = [connectionItems new];
    connection.Connection_id=[NSString stringWithFormat:@"%@",[dict valueForKeyPath:@"ConnectionId"]];
    connection.ConnectionType= [dict valueForKeyPath:@"ConnectionType"];
    return connection;
}
@end
