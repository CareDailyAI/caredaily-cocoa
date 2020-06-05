//
//  PPBotengineApp.h
//  PPiOSCore
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

extern NSString *COMPOSER_APP_CATEGORY_ENERGY;
extern NSString *COMPOSER_APP_CATEGORY_SECURITY;
extern NSString *COMPOSER_APP_CATEGORY_CARE;
extern NSString *COMPOSER_APP_CATEGORY_LIFESTYLE;
extern NSString *COMPOSER_APP_CATEGORY_HEALTH;
extern NSString *COMPOSER_APP_CATEGORY_WELLNESS;

typedef NS_OPTIONS(NSInteger, PPBotengineAppCategory) {
    PPBotengineAppCategoryNone      = 0,
    PPBotengineAppCategoryEnergy    = 1 << 0,
    PPBotengineAppCategorySecurity  = 1 << 1,
    PPBotengineAppCategoryCare      = 1 << 2,
    PPBotengineAppCategoryLifestyle = 1 << 3,
    PPBotengineAppCategoryHealth    = 1 << 4,
    PPBotengineAppCategoryWellness  = 1 << 5
};

typedef NS_OPTIONS(NSInteger, PPBotengineAppExecutionTrigger) {
    PPBotengineAppExecutionTriggerNone                       = 0,
    PPBotengineAppExecutionTriggerSchedule                   = 0x01,
    PPBotengineAppExecutionTriggerLocationEvent              = 0x02,
    PPBotengineAppExecutionTriggerDeviceAlert                = 0x04,
    PPBotengineAppExecutionTriggerDeviceMeasurements         = 0x08,
    PPBotengineAppExecutionTriggerQuestionAnswer             = 0x10,
    PPBotengineAppExecutionTriggerDeviceFiles                = 0x20,
    PPBotengineAppExecutionTriggerAlertCountdownTimer        = 0x40,
    PPBotengineAppExecutionTriggerMeasurementsCountdownTimer = 0x80
};

/*
 The type of the bot. Depending of the type, the bot is available for purchase either for locations, organizations or circles.
 */
typedef NS_OPTIONS(NSInteger, PPBotengineAppType) {
    PPBotengineAppTypeNone = -1,
    PPBotengineAppTypeUserLocations = 0, // The bot is intended for purchase by users for locations (default type)
    PPBotengineAppTypeOrganizationAdminOrganizations = 1, // The bot is intended for purchase by organization admins for their organizations
    PPBotengineAppTypeOrganizationLocations = 2, // The bot is intended for purchase for the organization locations only
    PPBotengineAppTypeCircleUserCircles = 3, // The bot is intended for purchase by the circle users for their circles
};

@interface PPBotengineApp : NSObject

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
