//
//  PPDynamicUIScreenSectionItem.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/12/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

typedef NS_OPTIONS(NSInteger, PPDynamicUIScreenSectionItemOrder) {
    PPDynamicUIScreenSectionItemOrderNone = -1,
};

@interface PPDynamicUIScreenSectionItem : NSObject

@property (nonatomic, strong) NSString *itemId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic) PPDynamicUIScreenSectionItemOrder order;
@property (nonatomic, strong) NSString *product;
@property (nonatomic, strong) NSString *details;
@property (nonatomic, strong) NSString *icon;

- (id)initWithId:(NSString *)itemId name:(NSString *)name order:(PPDynamicUIScreenSectionItemOrder)order product:(NSString *)product details:(NSString *)details icon:(NSString *)icon;

+ (PPDynamicUIScreenSectionItem *)initWithDictionary:(NSDictionary *)itemDict;

@end
