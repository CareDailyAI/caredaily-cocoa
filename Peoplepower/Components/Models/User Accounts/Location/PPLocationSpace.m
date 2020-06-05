//
//  PPLocationSpace.m
//  PPiOSCore
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
            return NSLocalizedString(@"Undefined", @"Label - Undefined (Space Name)");
            break;
        case PPLocationSpaceTypeKitchen:
            return NSLocalizedString(@"Kitchen", @"Label - Kitchen (Space Name)");
            break;
        case PPLocationSpaceTypeBedroom:
            return NSLocalizedString(@"Bedroom", @"Label - Bedroom (Space Name)");
            break;
        case PPLocationSpaceTypeBathroom:
            return NSLocalizedString(@"Bathroom", @"Label - Bathroom (Space Name)");
            break;
        case PPLocationSpaceTypeHallway:
            return NSLocalizedString(@"Hallway", @"Label - Hallway (Space Name)");
            break;
        case PPLocationSpaceTypeLivingRoom:
            return NSLocalizedString(@"Living Room", @"Label - Room (Space Name)");
            break;
        case PPLocationSpaceTypeDiningRoom:
            return NSLocalizedString(@"Dining Room", @"Label - Room (Space Name)");
            break;
        case PPLocationSpaceTypeFamilyRoom:
            return NSLocalizedString(@"Family Room", @"Label - Room (Space Name)");
            break;
        case PPLocationSpaceTypeLaundryRoom:
            return NSLocalizedString(@"Laundry Room", @"Label - Room (Space Name)");
            break;
        case PPLocationSpaceTypeOffice:
            return NSLocalizedString(@"Office", @"Label - Office (Space Name)");
            break;
        case PPLocationSpaceTypeStairs:
            return NSLocalizedString(@"Stairs", @"Label - Stairs (Space Name)");
            break;
        case PPLocationSpaceTypeGarage:
            return NSLocalizedString(@"Garage", @"Label - Garage (Space Name)");
            break;
        case PPLocationSpaceTypeBasement:
            return NSLocalizedString(@"Basement", @"Label - Basement (Space Name)");
            break;
        case PPLocationSpaceTypeNone:
        case PPLocationSpaceTypeOther:
            return NSLocalizedString(@"Other", @"Label - Other (Space Name)");
            break;
            
        default:
            return NSLocalizedString(@"None", @"Label - None (Space Name)");
            break;
    }
    return nil;
}

@end
