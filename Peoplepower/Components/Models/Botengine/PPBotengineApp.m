//
//  PPBotengineApp.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/7/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBotengineApp.h"
#import "PPDeviceType.h"

NSString *COMPOSER_APP_CATEGORY_ENERGY = @"E";
NSString *COMPOSER_APP_CATEGORY_SECURITY = @"S";
NSString *COMPOSER_APP_CATEGORY_CARE = @"C";
NSString *COMPOSER_APP_CATEGORY_LIFESTYLE = @"L";
NSString *COMPOSER_APP_CATEGORY_HEALTH = @"H";
NSString *COMPOSER_APP_CATEGORY_WELLNESS = @"W";

@implementation PPBotengineApp

+ (PPBotengineApp *)appFromAppDict:(NSDictionary *)app {
    NSString *bundle = [app objectForKey:@"bundle"];
    
    NSString *name = [app objectForKey:@"name"];
    NSString *author = [app objectForKey:@"author"];
    NSString *copyright = [app objectForKey:@"copyright"];
    NSString *description = [app objectForKey:@"description"];
    NSString *marketingUrl = [app objectForKey:@"marketingUrl"];
    NSString *supportUrl = [app objectForKey:@"supportUrl"];
    NSString *videoUrl = [app objectForKey:@"videoUrl"];
    NSString *privacyUrl = [app objectForKey:@"privacyUrl"];
    
    PPBotengineAppMarketing *marketing = [PPBotengineAppMarketing marketingWithName:name author:author copyright:copyright desc:description marketingUrl:marketingUrl supportUrl:supportUrl videoUrl:videoUrl privacyUrl:privacyUrl];
    
    BOOL compatible = YES;
    if([app.allKeys containsObject:@"compatible"]) {
        compatible = ((NSString *)[app objectForKey:@"compatible"]).boolValue;
    }
    
    NSString *instancesSummary = [app objectForKey:@"instancesSummary"];
    
    PPBotengineAppCategory appCategory = PPBotengineAppCategoryNone;
    NSString *category = [app objectForKey:@"category"];
    for(NSString *categoryString in [category componentsSeparatedByString:@","]) {
        appCategory += [PPBotengineApp appCategoryFromString:categoryString];
    }
    
    PPBotengineAppRating *rating = [PPBotengineAppRating ratingFromDict:[app objectForKey:@"rating"]];
    
    NSMutableArray *versions = [[NSMutableArray alloc] init];
    for(NSDictionary *versionDict in [app objectForKey:@"versions"]) {
        NSString *versionString = [versionDict objectForKey:@"version"];
        NSString *statusChangeDateString = [versionDict objectForKey:@"statusChangeDate"];
        
        NSDate *statusChangeDate = [NSDate date];
        if(statusChangeDateString != nil && ![statusChangeDateString isEqualToString:@""]) {
            statusChangeDate = [PPNSDate parseDateTime:statusChangeDateString];
        }
        
        NSString *whatsNew = [versionDict objectForKey:@"whatsnew"];
        PPBotengineAppRating *rating = [PPBotengineAppRating ratingFromDict:[versionDict objectForKey:@"rating"]];
        
        PPBotengineAppVersion *version = [[PPBotengineAppVersion alloc] initWithVersion:versionString creationDate:nil statusChangeDage:statusChangeDate whatsNew:whatsNew rating:rating];
        [versions addObject:version];
    }
    
    NSInteger trigger = ((NSString *)[app objectForKey:@"trigger"]).integerValue;
    NSString *schedule = [app objectForKey:@"schedule"];
    NSString *eventsString = [app objectForKey:@"event"];
    NSArray *events = [eventsString componentsSeparatedByString:@","];
    
    NSMutableArray *deviceTypes = [[NSMutableArray alloc] init];
    for(NSDictionary *deviceTypeDict in [app objectForKey:@"deviceTypes"]) {
        PPDeviceTypeId deviceTypeId = (PPDeviceTypeId)((NSString *)[deviceTypeDict objectForKey:@"id"]).integerValue;
        NSInteger minOccurence = ((NSString *)[deviceTypeDict objectForKey:@"minOccurence"]).integerValue;
        BOOL trigger = ((NSString *)[deviceTypeDict objectForKey:@"trigger"]).boolValue;
        BOOL read = ((NSString *)[deviceTypeDict objectForKey:@"read"]).boolValue;
        BOOL control = ((NSString *)[deviceTypeDict objectForKey:@"control"]).boolValue;
        NSString *reason = [deviceTypeDict objectForKey:@"reason"];
        
        PPDeviceType *deviceType = [[PPDeviceType alloc] initWithTypeId:deviceTypeId name:nil editable:PPDeviceTypeEditableNone createdBy:nil creationDate:nil attributes:nil] ;
        PPBotengineAppDeviceType *appDeviceType = [[PPBotengineAppDeviceType alloc] initWithDeviceType:deviceType minOccurence:minOccurence trigger:trigger read:read control:control reason:reason];
        [deviceTypes addObject:appDeviceType];
    }
    
    NSMutableArray *access = [[NSMutableArray alloc] init];
    for(NSDictionary *accessDict in [app objectForKey:@"access"]) {
        PPBotengineAppAccessCategory category = ((NSString *)[accessDict objectForKey:@"category"]).intValue;
        NSString *deviceId = [accessDict objectForKey:@"deviceId"];
        if(category == PPBotengineAppAccessCategoryDevices && (deviceId == nil || [deviceId isEqualToString:@""])) {
            // Handle edge case around bad access configuration
            continue;
        }
        NSInteger locationId = ((NSString *)[accessDict objectForKey:@"locationId"]).integerValue;
        BOOL trigger = ((NSString *)[accessDict objectForKey:@"trigger"]).boolValue;
        BOOL read = ((NSString *)[accessDict objectForKey:@"read"]).boolValue;
        BOOL control = ((NSString *)[accessDict objectForKey:@"control"]).boolValue;
        NSString *reason = [accessDict objectForKey:@"reason"];
        BOOL excluded = ((NSString *)[accessDict objectForKey:@"excluded"]).boolValue;
        
        BOOL isDuplicate = NO;
        if(deviceId != nil && ![deviceId isEqualToString:@""]) {
            for(PPBotengineAppAccess *a in access) {
                if([a.deviceId isEqualToString:deviceId]) {
                    isDuplicate = YES;
                }
            }
        }
        if(!isDuplicate) {
            PPBotengineAppAccess *appAccess = [[PPBotengineAppAccess alloc] initWithCategory:category deviceId:deviceId locationId:locationId trigger:trigger read:read control:control reason:reason excluded:excluded];
            [access addObject:appAccess];
        }
    }
    
    NSMutableArray *communications = [[NSMutableArray alloc] init];
    for(NSDictionary *communicationsDict in [app objectForKey:@"communications"]) {
        PPBotengineAppCommunicationsCategory category = ((NSString *)[communicationsDict objectForKey:@"category"]).intValue;
        BOOL email = ((NSString *)[communicationsDict objectForKey:@"email"]).boolValue;
        BOOL push = ((NSString *)[communicationsDict objectForKey:@"push"]).boolValue;
        BOOL sms = ((NSString *)[communicationsDict objectForKey:@"sms"]).boolValue;
        BOOL msg = ((NSString *)[communicationsDict objectForKey:@"msg"]).boolValue;
        
        PPBotengineAppCommunications *appCommunications = [[PPBotengineAppCommunications alloc] initWithCategory:category email:email push:push sms:sms msg:msg];
        
        [communications addObject:appCommunications];
    }
    
    PPBotengineApp* composerApp = [[PPBotengineApp alloc] initWithBundle:bundle category:appCategory marketing:marketing rating:rating compatible:YES instanceSummary:instancesSummary versions:versions trigger:trigger schedule:schedule events:events deviceTypes:deviceTypes access:access communications:communications];
    composerApp.compatible = compatible;
    
    return composerApp;
}

+ (PPBotengineAppCategory)appCategoryFromString:(NSString *)categoryString {
    if([categoryString isEqualToString:COMPOSER_APP_CATEGORY_ENERGY]) {
        return PPBotengineAppCategoryEnergy;
    }
    else if([categoryString isEqualToString:COMPOSER_APP_CATEGORY_SECURITY]) {
        return PPBotengineAppCategorySecurity;
    }
    else if([categoryString isEqualToString:COMPOSER_APP_CATEGORY_CARE]) {
        return PPBotengineAppCategoryCare;
    }
    else if([categoryString isEqualToString:COMPOSER_APP_CATEGORY_LIFESTYLE]) {
        return PPBotengineAppCategoryLifestyle;
    }
    else if([categoryString isEqualToString:COMPOSER_APP_CATEGORY_HEALTH]) {
        return PPBotengineAppCategoryHealth;
    }
    else if([categoryString isEqualToString:COMPOSER_APP_CATEGORY_WELLNESS]) {
        return PPBotengineAppCategoryWellness;
    }

    return PPBotengineAppCategoryNone;
}

+ (PPBotengineApp *)appWithBundle:(NSString *)bundle category:(PPBotengineAppCategory)category marketing:(PPBotengineAppMarketing *)marketing rating:(PPBotengineAppRating *)rating compatible:(BOOL)compatible {
    return [[PPBotengineApp alloc] initWithBundle:bundle category:category marketing:marketing rating:rating compatible:compatible instanceSummary:nil versions:nil trigger:PPBotengineAppExecutionTriggerNone schedule:nil events:nil deviceTypes:nil access:nil communications:nil];
}

- (id)initWithBundle:(NSString *)bundle category:(PPBotengineAppCategory)category marketing:(PPBotengineAppMarketing *)marketing rating:(PPBotengineAppRating *)rating compatible:(BOOL)compatible instanceSummary:(NSString *)instanceSummary versions:(NSArray *)versions trigger:(NSInteger)trigger schedule:(NSString *)schedule events:(NSArray *)events deviceTypes:(NSArray *)deviceTypes access:(NSArray *)access communications:(NSArray *)communications {
    self = [super init];
    if(self) {
        self.bundle = bundle;
        self.category = category;
        self.marketing = marketing;
        self.rating = rating;
        self.compatible = compatible;
        self.instanceSummary = instanceSummary;
        self.versions = versions;
        self.trigger = trigger;
        self.schedule = schedule;
        self.events = events;
        self.deviceTypes = deviceTypes;
        self.access = access;
        self.communications = communications;
    }
    
    return self;
}

@end
