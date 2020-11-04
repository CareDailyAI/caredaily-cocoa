//
//  PPDynamicUIScreenSection.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/12/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPOrganization.h"
#import "PPDynamicUIScreenSectionItem.h"

@interface PPDynamicUIScreenSection : PPBaseModel

@property (nonatomic) PPDynamicUIScreenSectionOrder sectionOrder;
@property (nonatomic, strong) NSString *sectionId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic) PPDynamicUIScreenSectionOrder order;
@property (nonatomic, strong) PPOrganization *organization;
@property (nonatomic, strong) NSArray *sectionItems;

- (id)initSectionId:(NSString *)sectionId name:(NSString *)name order:(PPDynamicUIScreenSectionOrder)order organization:(PPOrganization *)organization sectionItems:(NSArray *)sectionItems;

+ (PPDynamicUIScreenSection *)initWithDictionary:(NSDictionary *)sectionDict;

@end
