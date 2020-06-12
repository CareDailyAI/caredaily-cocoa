//
//  PPCommunityLocation.h
//  Peoplepower
//
//  Created by Destry Teeter on 11/13/19.
//  Copyright © 2020 People Power Company. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN

@interface PPCommunityLocation : NSObject

@property (nonatomic) PPLocationId locationId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) PPTimezone *timezone;
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *longitude;

- (id)initWithLocationId:(PPLocationId)locationId name:(NSString *)name timezone:(PPTimezone *)timezone latitude:(NSString *)latitude longitude:(NSString *)longitude;


+ (PPCommunityLocation *)initWithDictionary:(NSDictionary *)locationDict;

@end

NS_ASSUME_NONNULL_END
