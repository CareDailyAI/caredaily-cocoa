//
//  PPDynamicUIScreenSection.m
//  PPiOSCore
//
//  Created by Destry Teeter on 3/12/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPDynamicUIScreenSection.h"

@implementation PPDynamicUIScreenSection

- (id)initSectionId:(NSString *)sectionId name:(NSString *)name order:(PPDynamicUIScreenSectionOrder)order organization:(PPOrganization *)organization sectionItems:(NSArray *)sectionItems {
    self = [super init];
    if(self) {
        self.sectionId = sectionId;
        self.name = name;
        self.order = order;
        self.organization = organization;
        self.sectionItems = sectionItems;
    }
    return self;
}

+ (PPDynamicUIScreenSection *)initWithDictionary:(NSDictionary *)sectionDict {
    
    NSString *sectionId = [sectionDict objectForKey:@"sectionId"];
    NSString *name = [sectionDict objectForKey:@"name"];
    PPDynamicUIScreenSectionOrder order = PPDynamicUIScreenSectionOrderNone;
    if([sectionDict objectForKey:@"order"]) {
        order = (PPDynamicUIScreenSectionOrder)((NSString *)[sectionDict objectForKey:@"order"]).integerValue;
    }
    PPOrganization *organization =  [PPOrganization initWithDictionary:[sectionDict objectForKey:@"organization"]];

    NSMutableArray *sectionItems;
    if([sectionDict objectForKey:@"items"]) {
        sectionItems = [[NSMutableArray alloc] initWithCapacity:0];
        for(NSDictionary *itemDict in [sectionDict objectForKey:@"items"]) {
            PPDynamicUIScreenSectionItem *item = [PPDynamicUIScreenSectionItem initWithDictionary:itemDict];
            [sectionItems addObject:item];
        }
    }
    
    PPDynamicUIScreenSection *section = [[PPDynamicUIScreenSection alloc] initSectionId:sectionId name:name order:order organization:organization sectionItems:sectionItems];
    return section;
}
@end
