//
//  PPDynamicUIScreen.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/12/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPDynamicUIScreenSection.h"

@interface PPDynamicUIScreen : PPBaseModel

@property (nonatomic, strong) NSString *screenId;
@property (nonatomic) PPDynamicUIScreenOrder order;
@property (nonatomic, strong) NSArray *sections;

- (id)initWithScreenId:(NSString *)screenId order:(PPDynamicUIScreenOrder)order sections:(NSArray *)sections;

+ (PPDynamicUIScreen *)initWithDictionary:(NSDictionary *)screenDict;

#pragma mark - Helper methods

- (BOOL)isEqualToScreen:(PPDynamicUIScreen *)screen;

- (void)sync:(PPDynamicUIScreen *)screen;

@end
