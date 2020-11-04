//
//  PPLocationCommunity.h
//  Peoplepower
//
//  Created by Destry Teeter on 12/18/19.
//  Copyright © 2020 People Power Company. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN

@interface PPLocationCommunity : PPBaseModel

@property (nonatomic) PPCommunityId communityId;
@property (nonatomic, strong) NSString *communityName;
@property (nonatomic) PPLocationId locationId;

- (id)initWithCommunityId:(PPCommunityId)communityId communityName:(NSString *)communityName locationId:(PPLocationId)locationId;
+ (PPLocationCommunity *)initWithDictionary:(NSDictionary *)communityDict;

@end

NS_ASSUME_NONNULL_END
