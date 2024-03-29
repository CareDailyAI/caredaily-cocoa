//
//  PPInAppMessageRecipient.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPUser.h"
#import "PPOrganization.h"
#import "PPOrganizationGroup.h"

@interface PPInAppMessageRecipient : PPBaseModel

@property (nonatomic, strong) PPOrganization *organization;
@property (nonatomic, strong) PPUser *user;
@property (nonatomic, strong) NSString *userTag;
@property (nonatomic, strong) NSString *deviceTag;

- (id)initWithOrganization:(PPOrganization *)organization user:(PPUser *)user userTag:(NSString *)userTag deviceTag:(NSString *)deviceTag;

+ (PPInAppMessageRecipient *)initWithDictionary:(NSDictionary *)recipientDict;

+ (NSString *)stringify:(PPInAppMessageRecipient *)recipient;
+ (NSDictionary *)data:(PPInAppMessageRecipient *)recipient;

@end
