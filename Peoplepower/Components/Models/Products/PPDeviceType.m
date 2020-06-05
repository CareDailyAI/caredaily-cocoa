//
//  PPDeviceType.m
//  PPiOSCore
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPDeviceType.h"

@implementation PPDeviceType

- (id)initWithTypeId:(PPDeviceTypeId)typeId name:(NSString *)name editable:(PPDeviceTypeEditable)editable createdBy:(PPUser *)createdBy creationDate:(NSDate *)creationDate attributes:(NSArray *)attributes {
    self = [super init];
    if(self) {
        self.typeId = typeId;
        self.name = name;
        self.editable = editable;
        self.createdBy = createdBy;
        self.creationDate = creationDate;
        self.attributes = attributes;
    }
    return self;
}

+ (PPDeviceType *)initWithDictionary:(NSDictionary *)typeDict {
    PPDeviceTypeId typeId = PPDeviceTypeIdNone;
    if([typeDict objectForKey:@"id"]) {
        typeId = (PPDeviceTypeId)((NSString *)[typeDict objectForKey:@"id"]).integerValue;
    }
    NSString *name = [typeDict objectForKey:@"name"];
    PPDeviceTypeEditable editable = PPDeviceTypeEditableNone;
    if([typeDict objectForKey:@"ditable"]) {
        editable = (PPDeviceTypeEditable)((NSString *)[typeDict objectForKey:@"ditable"]).integerValue;
    }
    PPUser *createdBy;
    if([typeDict objectForKey:@"createdBy"]) {
        createdBy = [PPUser initWithDictionary:[typeDict objectForKey:@"createdBy"]];
    }
    NSString *creationDateString = [typeDict objectForKey:@"creationDate"];
    
    NSDate *creationDate = [NSDate date];
    if(creationDateString != nil) {
        if(![creationDateString isEqualToString:@""]) {
            creationDate = [PPNSDate parseDateTime:creationDateString];
        }
    }
    
    NSMutableArray *attributes;
    if([typeDict objectForKey:@"attributes"]) {
        attributes = [[NSMutableArray alloc] initWithCapacity:0];
        for(NSDictionary *attributeDict in [typeDict objectForKey:@"attributes"]) {
            PPDeviceTypeAttribute *attribute = [PPDeviceTypeAttribute initWithDictionary:attributeDict];
            [attributes addObject:attribute];
        }
    }
    
    PPDeviceType *type = [[PPDeviceType alloc] initWithTypeId:typeId name:name editable:editable createdBy:createdBy creationDate:creationDate attributes:attributes];
    return type;
}

+ (NSString *)stringify:(PPDeviceType *)deviceType {
    NSMutableString *JSONString=[[NSMutableString alloc] init];
    [JSONString appendString:@"{"];
    
    BOOL appendComma = NO;
    
    if(deviceType.name) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"name\":\"%@\"", deviceType.name];
        appendComma = YES;
    }
    
    if(deviceType.attributes) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendString:@"\"attr\": ["];
        
        BOOL appendBudgetComma = NO;
        for(PPDeviceTypeAttribute *attribute in deviceType.attributes) {
            if(appendBudgetComma) {
                [JSONString appendString:@","];
            }
            [JSONString appendString:[PPDeviceTypeAttribute stringify:attribute]];
            appendBudgetComma = YES;
        }
        
        [JSONString appendString:@"]"];
        appendComma = YES;
    }
    
    [JSONString appendString:@"}"];
    return JSONString;
}

#pragma mark - Helper Methods

- (BOOL)isEqualToDeviceType:(PPDeviceType *)deviceType {
    BOOL equal = NO;
    
    if(deviceType.typeId != PPDeviceTypeIdNone && _typeId != PPDeviceTypeIdNone) {
        if(deviceType.typeId == _typeId) {
            equal = YES;
        }
    }
    
    return equal;
}

- (void)sync:(PPDeviceType *)deviceType {
    if(deviceType.typeId != PPDeviceTypeIdNone) {
        _typeId = deviceType.typeId;
    }
    if(deviceType.name) {
        _name = deviceType.name;
    }
    if(deviceType.editable != PPDeviceTypeEditableNone) {
        _editable = deviceType.editable;
    }
    if(deviceType.createdBy) {
        _createdBy = deviceType.createdBy;
    }
    if(deviceType.creationDate) {
        _creationDate = deviceType.creationDate;
    }
    if(deviceType.attributes) {
        _attributes = deviceType.attributes;
    }
}

@end
