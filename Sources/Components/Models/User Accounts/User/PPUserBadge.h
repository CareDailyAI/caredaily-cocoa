//
//  PPUserBadge.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/6/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

/**
 * A badge is a red number that appears over an app's icon, indicating to the user that the app has something new to share. Like a ringtone alerts a person to pick up the phone, a badge alerts users to open the app.
 * In a normal scenario, the IoT Software Suite will send a push notification to the user's apps to automatically place a badge on top of the app's icon(s). The total badge counts can be manually obtain from the /user GET API. It is the app's responsibility to clear its own local badges, and to alert the server to reset the badge counter when the user finally responds.
 **/

@interface PPUserBadge : PPBaseModel <NSCopying>

@property (nonatomic) PPUserBadgeType type;
@property (nonatomic) PPUserBadgeCount count;

- (id)initWithType:(PPUserBadgeType)type count:(PPUserBadgeCount)count;

+ (PPUserBadge *)initWithDictionary:(NSDictionary *)badgeDict;

#pragma mark - Helper methods

- (void)sync:(PPUserBadge *)userBadge;

@end
