//
//  PPDynamicUIScreen.h
//  PPiOSCore
//
//  Created by Destry Teeter on 3/12/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPDynamicUIScreenSection.h"

typedef NS_OPTIONS(NSInteger, PPDynamicUIScreenOrder) {
    PPDynamicUIScreenOrderNone = -1,
};

@interface PPDynamicUIScreen : NSObject

@property (nonatomic, strong) NSString *screenId;
@property (nonatomic) PPDynamicUIScreenOrder order;
@property (nonatomic, strong) NSArray *sections;

- (id)initWithScreenId:(NSString *)screenId order:(PPDynamicUIScreenOrder)order sections:(NSArray *)sections;

+ (PPDynamicUIScreen *)initWithDictionary:(NSDictionary *)screenDict;

#pragma mark - Helper methods

- (BOOL)isEqualToScreen:(PPDynamicUIScreen *)screen;

- (void)sync:(PPDynamicUIScreen *)screen;

@end
