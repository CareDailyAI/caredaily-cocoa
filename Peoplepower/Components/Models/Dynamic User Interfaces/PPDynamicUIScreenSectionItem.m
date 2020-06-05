//
//  PPDynamicUIScreenSectionItem.m
//  PPiOSCore
//
//  Created by Destry Teeter on 3/12/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPDynamicUIScreenSectionItem.h"

@implementation PPDynamicUIScreenSectionItem

- (id)initWithId:(NSString *)itemId name:(NSString *)name order:(PPDynamicUIScreenSectionItemOrder)order product:(NSString *)product details:(NSString *)details icon:(NSString *)icon {
    self = [super init];
    if(self) {
        self.itemId = itemId;
        self.name = name;
        self.order = order;
        self.product = product;
        self.details = details;
        self.icon = icon;
    }
    return self;
}

+ (PPDynamicUIScreenSectionItem *)initWithDictionary:(NSDictionary *)itemDict {
    NSString *itemId = [itemDict objectForKey:@"id"];
    NSString *name = [itemDict objectForKey:@"name"];
    PPDynamicUIScreenSectionItemOrder order = PPDynamicUIScreenSectionItemOrderNone;
    if([itemDict objectForKey:@"order"]) {
        order = (PPDynamicUIScreenSectionItemOrder)((NSString *)[itemDict objectForKey:@"order"]).integerValue;
    }
    NSString *product = [itemDict objectForKey:@"product"];
    NSString *details = [itemDict objectForKey:@"details"];
    NSString *icon = [itemDict objectForKey:@"icon"];
    
    PPDynamicUIScreenSectionItem *item = [[PPDynamicUIScreenSectionItem alloc] initWithId:itemId name:name order:order product:product details:details icon:icon];
    return item;
}
@end
