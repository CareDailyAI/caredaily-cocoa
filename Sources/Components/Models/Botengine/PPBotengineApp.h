//
//  PPBotengineApp.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/7/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPBotengineAppRating.h"
#import "PPBotengineAppMarketing.h"
#import "PPBotengineAppVersion.h"
#import "PPBotengineAppDeviceType.h"
#import "PPBotengineAppAccess.h"
#import "PPBotengineAppCommunications.h"
#import "PPBotengineAppReview.h"

@interface PPBotengineApp : PPBaseModel

@property (nonatomic, strong) NSString *bundle;
@property (nonatomic, strong) PPBotengineAppMarketing *marketing;
@property (nonatomic) BOOL compatible;
@property (nonatomic) PPBotengineAppCategory category;
@property (nonatomic, strong) NSString *instanceSummary;
@property (nonatomic, strong) PPBotengineAppRating *rating;
@property (nonatomic, strong) NSArray *versions;
@property (nonatomic) NSInteger trigger;
@property (nonatomic, strong) NSString *schedule;
@property (nonatomic, strong) NSArray *events;
@property (nonatomic, strong) NSArray *deviceTypes;
@property (nonatomic, strong) NSArray *access;
@property (nonatomic, strong) NSArray *communications;

+ (PPBotengineApp *)appFromAppDict:(NSDictionary *)appDict;

+ (PPBotengineAppCategory)appCategoryFromString:(NSString *)categoryString;

+ (PPBotengineApp *)appWithBundle:(NSString *)bundle category:(PPBotengineAppCategory)category marketing:(PPBotengineAppMarketing *)marketing rating:(PPBotengineAppRating *)rating compatible:(BOOL)compatible;

- (id)initWithBundle:(NSString *)bundle category:(PPBotengineAppCategory)category marketing:(PPBotengineAppMarketing *)marketing rating:(PPBotengineAppRating *)rating compatible:(BOOL)compatible instanceSummary:(NSString *)instanceSummary versions:(NSArray *)versions trigger:(NSInteger)trigger schedule:(NSString *)schedule events:(NSArray *)events deviceTypes:(NSArray *)deviceTypes access:(NSArray *)access communications:(NSArray *)communications;

@end
