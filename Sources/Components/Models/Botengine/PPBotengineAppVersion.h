//
//  PPBotengineAppVersion.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/7/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPBotengineAppRating.h"

@interface PPBotengineAppVersion : PPBaseModel

@property (nonatomic, strong) NSString *version;
@property (nonatomic, strong) NSDate *creationDate;
@property (nonatomic, strong) NSDate *statusChangeDate;
@property (nonatomic, strong) NSString *whatsNew;
@property (nonatomic, strong) PPBotengineAppRating *rating;

- (id)initWithVersion:(NSString *)version creationDate:(NSDate *)creationDate statusChangeDage:(NSDate *)statusChangeDate whatsNew:(NSString *)whatsNew rating:(PPBotengineAppRating *)rating;

@end
