//
//  PPNotificationToken.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/23/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

@interface PPNotificationToken : PPBaseModel

@property (nonatomic, strong) NSString *token;
@property (nonatomic) PPNotificationSubscriptionSupportsBadgeIcons badges;

- (id)initWithToken:(NSString *)token badges:(PPNotificationSubscriptionSupportsBadgeIcons)badges;

#pragma mark - Helper Methods

- (BOOL)isEqualToToken:(PPNotificationToken *)token;

@end
