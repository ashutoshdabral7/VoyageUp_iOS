//
//  Sharing.m
//  VoyageUp
//
//  Created by Deepak on 16/05/15.
//  Copyright (c) 2015 Erbauen Labs. All rights reserved.
//

#import "Sharing.h"

@implementation Sharing
+(Sharing *)shareDetails:(NSDictionary *)result
{
    Sharing *share = [Sharing new];
    share.itemName = [result valueForKeyPath:@"ItemName"];
    share.itemID = [result valueForKeyPath:@"sh_id"];
    share.shareMessage = [result valueForKeyPath:@"share_message"];
      share.shareDate=[result valueForKeyPath:@"Date"];
    share.SharedUserId = [result valueForKeyPath:@"UserId"];
    share.sharedGeoFenceArea = [result valueForKeyPath:@"FenceArea"];
    share.SharedUserPhoto = [result valueForKeyPath:@"ProfilePhoto"];
    share.sharedLatitude = [result valueForKeyPath:@"Latitude"];
    share.sharedLongitude = [result valueForKeyPath:@"Longitude"];
  share.SharedUserFirstName=[result valueForKeyPath:@"FirstName"];
    share.SharedUserLastName=[result valueForKeyPath:@"LastName"];
    share.FullName=[NSString stringWithFormat:@"%@ %@",share.SharedUserFirstName,share.SharedUserLastName];
    return share;
}

@end

