//
//  PPLocationNarrative.h
//  Peoplepower
//
//  Created by Destry Teeter on 9/25/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//
// A way for bots to produce a narrative for a location - i.e. document someone's day, or security breaches, etc.
//Friends and family who can switch into and view your location should be able to see your narrative. Administrators should also be able to access your narrative in Maestro for debugging / understanding / explanation of "why did that happen in my home?" purposes.

#import <Foundation/Foundation.h>
#import "PPBotengineAppInstance.h"

NS_ASSUME_NONNULL_BEGIN

@interface PPLocationNarrative : PPBaseModel

@property (nonatomic) PPLocationNarrativeId narrativeId;
@property (nonatomic) PPLocationId locationId;
@property (nonatomic) NSDate *narrativeDate;
@property (nonatomic) PPLocationNarrativePriority priority;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSDictionary *target;
@property (nonatomic, strong) NSDate *creationDate;
@property (nonatomic) PPBotengineAppInstanceId appInstanceId;

- (id)initWithId:(PPLocationNarrativeId)narrativeId locationId:(PPLocationId)locationId narrativeDate:(NSDate *)narrativeDate priority:(PPLocationNarrativePriority)priority icon:(NSString *)icon title:(NSString *)title description:(NSString *)desc target:(NSDictionary *)target creationDate:(NSDate *)creationDate appInstanceId:(PPBotengineAppInstanceId)appInstanceId;

+ (PPLocationNarrative *)initWithDictionary:(NSDictionary *)narrativeDict;

+ (NSString *)stringify:(PPLocationNarrative *)narrative;
+ (NSDictionary *)data:(PPLocationNarrative *)narrative;

@end

NS_ASSUME_NONNULL_END
