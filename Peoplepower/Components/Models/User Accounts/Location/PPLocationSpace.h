//
//  PPLocationSpace.h
//  PPiOSCore
//
//  Created by Destry Teeter on 8/28/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

typedef NS_OPTIONS(NSInteger, PPLocationSpaceId) {
    PPLocationSpaceIdNone = -1
};

typedef NS_OPTIONS(NSInteger, PPLocationSpaceType) {
    PPLocationSpaceTypeNone         = -1,
    PPLocationSpaceTypeUndefined    = 0,
    PPLocationSpaceTypeKitchen      = 1,
    PPLocationSpaceTypeBedroom      = 2,
    PPLocationSpaceTypeBathroom     = 3,
    PPLocationSpaceTypeHallway      = 4,
    PPLocationSpaceTypeLivingRoom   = 5,
    PPLocationSpaceTypeDiningRoom   = 6,
    PPLocationSpaceTypeFamilyRoom   = 7,
    PPLocationSpaceTypeLaundryRoom  = 8,
    PPLocationSpaceTypeOffice       = 9,
    PPLocationSpaceTypeStairs       = 10,
    PPLocationSpaceTypeGarage       = 11,
    PPLocationSpaceTypeBasement     = 12,
    PPLocationSpaceTypeOther        = 13,
    PPLocationSpaceTypeCouch        = 14,
    PPLocationSpaceTypeChair        = 15,
};

@interface PPLocationSpace : NSObject

@property (nonatomic) PPLocationSpaceId spaceId;
@property (nonatomic) PPLocationSpaceType type;
@property (nonatomic, strong) NSString *name;

- (id)initWithId:(PPLocationSpaceId)spaceId type:(PPLocationSpaceType)type name:(NSString *)name;

+ (PPLocationSpace *)initWithDictionary:(NSDictionary *)spaceDict;

+ (NSString *)stringify:(PPLocationSpace *)space;
+ (NSDictionary *)data:(PPLocationSpace *)space;

+ (NSString *)localizedNameForSpaceType:(PPLocationSpaceType)spaceType;

@end
