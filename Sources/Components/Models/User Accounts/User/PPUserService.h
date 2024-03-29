//
//  PPUserService.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/6/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

@interface PPUserService : PPBaseModel <NSCopying>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic) PPUserServiceAmount amount;
@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *endDate;

- (id)initWithName:(NSString *)name desc:(NSString *)desc amount:(PPUserServiceAmount)amount startDate:(NSDate *)startDate endDate:(NSDate *)endDate;

+ (PPUserService *)initWithDictionary:(NSDictionary *)serviceDict;

#pragma mark - Helper methods

- (void)sync:(PPUserService *)userService;

@end
