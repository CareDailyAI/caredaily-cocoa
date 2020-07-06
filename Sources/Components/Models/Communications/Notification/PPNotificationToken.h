//
//  PPNotificationToken.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/23/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

typedef NS_OPTIONS(NSInteger, PPNotificationSubscriptionSupportsBadgeIcons) {
    PPNotificationSubscriptionSupportsBadgeIconsNone = -1,
    PPNotificationSubscriptionSupportsBadgeIconsFalse = 0,
    PPNotificationSubscriptionSupportsBadgeIconsTrue = 1
};

@interface PPNotificationToken : NSObject

@property (nonatomic, strong) NSString *token;
@property (nonatomic) PPNotificationSubscriptionSupportsBadgeIcons badges;

- (id)initWithToken:(NSString *)token badges:(PPNotificationSubscriptionSupportsBadgeIcons)badges;

#pragma mark - Helper Methods

- (BOOL)isEqualToToken:(PPNotificationToken *)token;

@end
