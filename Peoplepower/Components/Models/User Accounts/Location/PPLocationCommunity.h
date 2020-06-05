//
//  PPLocationCommunity.h
//  PPiOSCore
//
//  Created by Destry Teeter on 12/18/19.
//  Copyright © 2019 People Power Company. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSInteger, PPCommunityId) {
    PPCommunityIdNone = -1
};

@interface PPLocationCommunity : NSObject

@property (nonatomic) PPCommunityId communityId;
@property (nonatomic, strong) NSString *communityName;
@property (nonatomic) PPLocationId locationId;

- (id)initWithCommunityId:(PPCommunityId)communityId communityName:(NSString *)communityName locationId:(PPLocationId)locationId;
+ (PPLocationCommunity *)initWithDictionary:(NSDictionary *)communityDict;

@end

NS_ASSUME_NONNULL_END
