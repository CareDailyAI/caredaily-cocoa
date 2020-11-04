//
//  PPBotengineApp.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/7/18.
//  Copyright © 2020 People Power Company. All rights reserved.
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
@property (nonatomic, strong) RLMArray<PPBotengineAppVersion *><PPBotengineAppVersion> *versions;
@property (nonatomic) NSInteger trigger;
@property (nonatomic, strong) NSString *schedule;
@property (nonatomic, strong) RLMArray<RLMString> *events;
@property (nonatomic, strong) RLMArray<PPBotengineAppDeviceType *><PPBotengineAppDeviceType> *deviceTypes;
@property (nonatomic, strong) RLMArray<PPBotengineAppAccess *><PPBotengineAppAccess> *access;
@property (nonatomic, strong) RLMArray<PPBotengineAppCommunications *><PPBotengineAppCommunications> *communications;

+ (PPBotengineApp *)appFromAppDict:(NSDictionary *)appDict;

+ (PPBotengineAppCategory)appCategoryFromString:(NSString *)categoryString;

+ (PPBotengineApp *)appWithBundle:(NSString *)bundle category:(PPBotengineAppCategory)category marketing:(PPBotengineAppMarketing *)marketing rating:(PPBotengineAppRating *)rating compatible:(BOOL)compatible;

- (id)initWithBundle:(NSString *)bundle category:(PPBotengineAppCategory)category marketing:(PPBotengineAppMarketing *)marketing rating:(PPBotengineAppRating *)rating compatible:(BOOL)compatible instanceSummary:(NSString *)instanceSummary versions:(RLMArray *)versions trigger:(NSInteger)trigger schedule:(NSString *)schedule events:(RLMArray *)events deviceTypes:(RLMArray *)deviceTypes access:(RLMArray *)access communications:(RLMArray *)communications;

@end

