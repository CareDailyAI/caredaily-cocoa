//
//  PPLocationSpace.m
//  Peoplepower
//
//  Created by Destry Teeter on 8/28/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPLocationSpace.h"

@implementation PPLocationSpace

- (id)initWithId:(PPLocationSpaceId)spaceId type:(PPLocationSpaceType)type name:(NSString *)name {
    self = [super init];
    if(self) {
        self.spaceId = spaceId;
        self.type = type;
        self.name = name;
    }
    return self;
}

+ (PPLocationSpace *)initWithDictionary:(NSDictionary *)spaceDict {
    PPLocationSpaceId spaceId = PPLocationSpaceIdNone;
    if([spaceDict objectForKey:@"id"]) {
        spaceId = (PPLocationSpaceId)((NSString *)[spaceDict objectForKey:@"id"]).integerValue;
    }
    
    PPLocationSpaceType type = PPLocationSpaceTypeNone;
    if([spaceDict objectForKey:@"type"]) {
        type = (PPLocationSpaceType)((NSString *)[spaceDict objectForKey:@"type"]).integerValue;
    }
    
    NSString *name = [spaceDict objectForKey:@"name"];
    
    return [[PPLocationSpace alloc] initWithId:spaceId type:type name:name];
}

+ (NSString *)stringify:(PPLocationSpace *)space {
    NSMutableString *JSONString = [[NSMutableString alloc] initWithString:@"{"];
    BOOL appendComma = NO;
    if(space.type != PPLocationSpaceTypeNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"type\":%li", (long)space.type];
        appendComma = YES;
    }
    if(space.name) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"name\":\"%@\"", space.name];
    }
    [JSONString appendString:@"}"];
    return JSONString;
}

+ (NSDictionary *)data:(PPLocationSpace *)space {
    NSMutableDictionary *data = @{}.mutableCopy;
    
    if(space.type != PPLocationSpaceTypeNone) {
        data[@"type"] = @(space.type);
    }
    if(space.name) {
        data[@"name"] = space.name;
    }
    return data;
}

+ (NSString *)localizedNameForSpaceType:(PPLocationSpaceType)spaceType {
    switch (spaceType) {
        case PPLocationSpaceTypeUndefined:
            return NSLocalizedStringWithDefaultValue(@"location.space.name.undefined", nil, [PPBaseModel bundle], @"Undefined", @"Undefined");
            break;
        case PPLocationSpaceTypeKitchen:
            return NSLocalizedStringWithDefaultValue(@"location.space.name.kitchen", nil, [PPBaseModel bundle], @"Kitchen", @"Kitchen");
            break;
        case PPLocationSpaceTypeBedroom:
            return NSLocalizedStringWithDefaultValue(@"location.space.name.bedroom", nil, [PPBaseModel bundle], @"Bedroom", @"Bedroom");
            break;
        case PPLocationSpaceTypeBathroom:
            return NSLocalizedStringWithDefaultValue(@"location.space.name.bathroom", nil, [PPBaseModel bundle], @"Bathroom", @"Bathroom");
            break;
        case PPLocationSpaceTypeHallway:
            return NSLocalizedStringWithDefaultValue(@"location.space.name.hallway", nil, [PPBaseModel bundle], @"Hallway", @"Hallway");
            break;
        case PPLocationSpaceTypeLivingRoom:
            return NSLocalizedStringWithDefaultValue(@"location.space.name.livingroom", nil, [PPBaseModel bundle], @"Living Room", @"Living Room");
            break;
        case PPLocationSpaceTypeDiningRoom:
            return NSLocalizedStringWithDefaultValue(@"location.space.name.diningroom", nil, [PPBaseModel bundle], @"Dining Room", @"Dining Room");
            break;
        case PPLocationSpaceTypeFamilyRoom:
            return NSLocalizedStringWithDefaultValue(@"location.space.name.familyroom", nil, [PPBaseModel bundle], @"Family Room", @"Family Room");
            break;
        case PPLocationSpaceTypeLaundryRoom:
            return NSLocalizedStringWithDefaultValue(@"location.space.name.laundryroom", nil, [PPBaseModel bundle], @"Laundry Room", @"Laundry Room");
            break;
        case PPLocationSpaceTypeOffice:
            return NSLocalizedStringWithDefaultValue(@"location.space.name.office", nil, [PPBaseModel bundle], @"Office", @"Office");
            break;
        case PPLocationSpaceTypeStairs:
            return NSLocalizedStringWithDefaultValue(@"location.space.name.stairs", nil, [PPBaseModel bundle], @"Stairs", @"Stairs");
            break;
        case PPLocationSpaceTypeGarage:
            return NSLocalizedStringWithDefaultValue(@"location.space.name.garage", nil, [PPBaseModel bundle], @"Garage", @"Garage");
            break;
        case PPLocationSpaceTypeBasement:
            return NSLocalizedStringWithDefaultValue(@"location.space.name.basement", nil, [PPBaseModel bundle], @"Basement", @"Basement");
            break;
        case PPLocationSpaceTypeNone:
        case PPLocationSpaceTypeOther:
            return NSLocalizedStringWithDefaultValue(@"location.space.name.other", nil, [PPBaseModel bundle], @"Other", @"Other");
            break;
            
        default:
            return NSLocalizedStringWithDefaultValue(@"location.space.name.none", nil, [PPBaseModel bundle], @"None", @"None");
            break;
    }
    return nil;
}

@end
