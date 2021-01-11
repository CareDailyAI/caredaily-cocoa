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
            return NSLocalizedStringFromTableInBundle(@"Undefined", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Undefined (Space Name)");
            break;
        case PPLocationSpaceTypeKitchen:
            return NSLocalizedStringFromTableInBundle(@"Kitchen", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Kitchen (Space Name)");
            break;
        case PPLocationSpaceTypeBedroom:
            return NSLocalizedStringFromTableInBundle(@"Bedroom", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Bedroom (Space Name)");
            break;
        case PPLocationSpaceTypeBathroom:
            return NSLocalizedStringFromTableInBundle(@"Bathroom", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Bathroom (Space Name)");
            break;
        case PPLocationSpaceTypeHallway:
            return NSLocalizedStringFromTableInBundle(@"Hallway", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Hallway (Space Name)");
            break;
        case PPLocationSpaceTypeLivingRoom:
            return NSLocalizedStringFromTableInBundle(@"Living Room", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Room (Space Name)");
            break;
        case PPLocationSpaceTypeDiningRoom:
            return NSLocalizedStringFromTableInBundle(@"Dining Room", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Room (Space Name)");
            break;
        case PPLocationSpaceTypeFamilyRoom:
            return NSLocalizedStringFromTableInBundle(@"Family Room", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Room (Space Name)");
            break;
        case PPLocationSpaceTypeLaundryRoom:
            return NSLocalizedStringFromTableInBundle(@"Laundry Room", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Room (Space Name)");
            break;
        case PPLocationSpaceTypeOffice:
            return NSLocalizedStringFromTableInBundle(@"Office", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Office (Space Name)");
            break;
        case PPLocationSpaceTypeStairs:
            return NSLocalizedStringFromTableInBundle(@"Stairs", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Stairs (Space Name)");
            break;
        case PPLocationSpaceTypeGarage:
            return NSLocalizedStringFromTableInBundle(@"Garage", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Garage (Space Name)");
            break;
        case PPLocationSpaceTypeBasement:
            return NSLocalizedStringFromTableInBundle(@"Basement", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Basement (Space Name)");
            break;
        case PPLocationSpaceTypeNone:
        case PPLocationSpaceTypeOther:
            return NSLocalizedStringFromTableInBundle(@"Other", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - Other (Space Name)");
            break;
            
        default:
            return NSLocalizedStringFromTableInBundle(@"None", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Label - None (Space Name)");
            break;
    }
    return nil;
}

@end
