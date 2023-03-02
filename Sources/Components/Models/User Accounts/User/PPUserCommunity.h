//
//  PPUserCommunity.h
//  Peoplepower
//
//  Created by Destry Teeter on 12/31/19.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPLocationCommunity.h"
NS_ASSUME_NONNULL_BEGIN

@interface PPUserCommunity : PPBaseModel

@property (nonatomic) PPCommunityId communityId;
@property (nonatomic, strong) NSString *communityName;

- (id)initWithCommunityId:(PPCommunityId)communityId communityName:(NSString *)communityName;
+ (PPUserCommunity *)initWithDictionary:(NSDictionary *)communityDict;

@end

NS_ASSUME_NONNULL_END
