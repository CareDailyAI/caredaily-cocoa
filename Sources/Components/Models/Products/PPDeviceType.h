//
//  PPDeviceType.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPUser.h"
#import "PPDeviceTypeAttribute.h"

@interface PPDeviceType : PPBaseModel

@property (nonatomic) PPDeviceTypeId typeId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic) PPDeviceTypeEditable editable;
@property (nonatomic, strong) PPUser *createdBy;
@property (nonatomic, strong) NSDate *creationDate;
@property (nonatomic, strong) RLMArray<PPDeviceTypeAttribute *><PPDeviceTypeAttribute> *attributes;

- (id)initWithTypeId:(PPDeviceTypeId)typeId name:(NSString *)name editable:(PPDeviceTypeEditable)editable createdBy:(PPUser *)createdBy creationDate:(NSDate *)creationDate attributes:(RLMArray *)attributes;

+ (PPDeviceType *)initWithDictionary:(NSDictionary *)typeDict;

+ (NSString *)stringify:(PPDeviceType *)deviceType;

#pragma mark - Helper Methods

- (BOOL)isEqualToDeviceType:(PPDeviceType *)deviceType;

- (void)sync:(PPDeviceType *)deviceType;

@end
