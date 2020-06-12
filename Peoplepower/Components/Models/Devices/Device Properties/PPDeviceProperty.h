//
//  PPDeviceProperty.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/8/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

@interface PPDeviceProperty : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *index;
@property (nonatomic, strong) NSString *content;

- (id)initWithName:(NSString *)name index:(NSString *)index content:(NSString *)content;

+ (PPDeviceProperty *)initWithDictionary:(NSDictionary *)propertyDict;

+ (NSString *)stringify:(PPDeviceProperty *)property;
+ (NSDictionary *)data:(PPDeviceProperty *)property;

#pragma mark - Helper methods

- (void)sync:(PPDeviceProperty *)property;

@end
