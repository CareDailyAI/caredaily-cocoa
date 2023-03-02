//
//  PPDeviceTypeAttribute.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPDeviceTypeAttributeOption.h"

@interface PPDeviceTypeAttribute : PPBaseModel

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *value;
@property (nonatomic) PPDeviceTypeAttributeExtended extended;
@property (nonatomic, strong) NSString *defaultValue;
@property (nonatomic, strong) RLMArray<PPDeviceTypeAttributeOption *><PPDeviceTypeAttributeOption> *options;

- (id)initWithName:(NSString *)name value:(NSString *)value extended:(PPDeviceTypeAttributeExtended)extended defaultValue:(NSString *)defaultValue options:(RLMArray *)options;

+ (PPDeviceTypeAttribute *)initWithDictionary:(NSDictionary *)attributeDict;

+ (NSString *)stringify:(PPDeviceTypeAttribute *)attribute;

#pragma mark - Helper methods

- (BOOL)isEqualToAttribute:(PPDeviceTypeAttribute *)attribute;

- (void)sync:(PPDeviceTypeAttribute *)attribute;

@end
