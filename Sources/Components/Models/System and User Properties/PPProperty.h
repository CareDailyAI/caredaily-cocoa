//
//  PPProperty.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

@interface PPProperty : PPBaseModel

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *value;

- (id)initWithName:(NSString *)name value:(NSString *)value;

+ (PPProperty *)initWithDictionary:(NSDictionary *)propertyDict;

+ (NSString *)stringify:(PPProperty *)property;
+ (NSDictionary *)data:(PPProperty *)property;

@end
