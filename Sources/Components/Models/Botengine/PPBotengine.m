//
//  PPBotengine.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/7/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPBotengine.h"
#import "PPBotengineApp.h"
#import "PPBotengineAppInstance.h"
#import "PPCloudEngine.h"
#import "PPCurlDebug.h"

@implementation PPBotengine

/**
 * Search app store
 * Retrieve all Composer apps that match the given criteria
 *
 * @param searchBy Search in name, author, keywords
 * @param category Category Search. i.e. 'S', 'E', etc.
 * @param compatible Filter by apps that are compatible with our user account or not, leave blank to return all apps
 * @param lang Language filter, leave blank to return apps in all languages
 * @param type PPBotengineAppType Filter by the bot type field
 * @param locationId PPLocationId Return bots available for this location
 * @param organizationId PPOrganizationId Return bots available for this organization
 *
 * @param callback PPBotengineAppsBlock Array of available apps and server status
 */
+ (void)searchAppStore:(NSString *)searchBy category:(NSString *)category compatible:(BOOL)compatible language:(NSString *)lang type:(PPBotengineAppType)type locaitonId:(PPLocationId)locationId organizationId:(PPOrganizationId)organizationId callback:(PPBotengineAppsBlock)callback {
    NSMutableString *request = [NSMutableString stringWithString:@"appstore/search?"];
    
    if(searchBy) {
        [request appendFormat:@"seachBy=%@&", searchBy];
    }
    if(category) {
        [request appendFormat:@"category=%@&", category];
    }

    [request appendFormat:@"compatible=%@&", (compatible == YES) ? @"true" : @"false"];
    
    if(lang) {
        [request appendFormat:@"lang=%@&", lang];
    }
    if(type != PPBotengineAppTypeNone) {
        [request appendFormat:@"type=%li&", (long)type];
    }
    if(locationId != PPLocationIdNone) {
        [request appendFormat:@"locationId=%li&", (long)locationId];
    }
    if(organizationId != PPOrganizationIdNone) {
        [request appendFormat:@"organizationId=%li&", (long)organizationId];
    }
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.botengine.searchAppStore()", DISPATCH_QUEUE_SERIAL);

    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppStrippedEngine] GET:request success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSMutableArray *composerApps;
            
            if(!error) {
                composerApps = [[NSMutableArray alloc] init];
                for(NSDictionary *appDict in [root objectForKey:@"apps"]) {
                    PPBotengineApp *composerApp = [PPBotengineApp appFromAppDict:appDict];
                    [composerApps addObject:composerApp];
                }
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(composerApps, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, error);
            });
        });
    }];
}
+ (void)searchAppStore:(NSString *)searchBy category:(NSString *)category compatible:(BOOL)compatible language:(NSString *)lang callback:(PPBotengineAppsBlock)callback {
    [PPBotengine searchAppStore:searchBy category:category compatible:compatible language:lang type:PPBotengineAppTypeUserLocations locaitonId:PPLocationIdNone organizationId:PPOrganizationIdNone callback:callback];
}

/**
 * Get app object
 * Each app can contain a publicly available icon and/or other images.
 *
 * @param name Object name. Use "icon" for icons.
 * @param bundle Globally unique bundle ID for the app, i.e. com.peoplepowerco.myfirstapp
 *
 * @param callback PPBotengineAppObjectBlock App object with server status
 */
+ (void)getAppObject:(NSString *)name bundleId:(NSString *)bundle callback:(PPBotengineAppObjectBlock)callback {
    NSMutableString *request = [NSMutableString stringWithString:@"appstore/objects/"];
    
    [request appendFormat:@"%@?", name];
    [request appendFormat:@"bundle=%@", bundle];
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.botengine.getAppObject()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppStrippedEngine] GET:request success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            UIImage *image = [[UIImage alloc] initWithData:responseData];
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(image, nil);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, error);
            });
        });
    }];
}

/**
 * Get app information
 * This App Idenfication API does not refer to a specific app instance, but the general app itself. It combines information input from several other APIs to provides comprehensive information about the app back to the user, minus the search keywords specified by the developer. It also adds the compatibility information and detailed ratings, so the user can see in advance what devices this app is compatible with and how it would access those devices.
 *
 * @param bundle Globally unique bundle ID for the app, i.e. com.peoplepowerco.myfirstapp
 * @param lang Language filter, leave blank to return apps in all languages
 * @param locationId PPLocationId Check compatibility for this location
 * @param organizationId PPOrganizationId Check compatibility for this organization
 *
 * @param callback PPBotengineAppInfoBlock with server status
 */
+ (void)getAppInformation:(NSString *)bundle language:(NSString *)lang locationId:(PPLocationId)locationId organizationId:(PPOrganizationId)organizationId callback:(PPBotengineAppInfoBlock)callback {
    NSMutableString *request = [NSMutableString stringWithString:@"appstore/appInfo?"];
    [request appendFormat:@"bundle=%@&", bundle];
    if(lang) {
        [request appendFormat:@"lang=%@&", lang];
    }
    if(locationId != PPLocationIdNone) {
        [request appendFormat:@"locationId=%li&", (long)locationId];
    }
    if(organizationId != PPOrganizationIdNone) {
        [request appendFormat:@"organizationId=%li&", (long)organizationId];
    }
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.botengine.getAppInformation()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppStrippedEngine] GET:request success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPBotengineApp *composerApp;
            
            if(!error) {
                NSDictionary *appDict = [root objectForKey:@"app"];
            
                composerApp = [PPBotengineApp appFromAppDict:appDict];
                composerApp.bundle = bundle;
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(composerApp, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, error);
            });
        });
    }];
}
+ (void)getAppInformation:(NSString *)bundle language:(NSString *)lang callback:(PPBotengineAppInfoBlock)callback {
    [PPBotengine getAppInformation:bundle language:lang locationId:PPLocationIdNone organizationId:PPOrganizationIdNone callback:callback];
}

/**
 * Purchase a new app instance
 *
 * @param bundle Globally unique bundle ID for the app, i.e. com.peoplepowerco.myfirstapp
 * @param locationId PPLocationId Assign the bot instance to the specific user location
 * @param organizationId PPOrganizationId Assign the bot instance to the specific organization
 * @param circleId PPCircleId Assign the bot instance to the specific circle
 *
 * @param callback PPBotengineAppPurchaseBlock with server status
 */
+ (void)purchaseAppInstance:(NSString *)bundle locationId:(PPLocationId)locationId organizationId:(PPOrganizationId)organizationId circleId:(PPCircleId)circleId callback:(PPBotengineAppPurchaseBlock)callback {
    NSMutableString *request = [NSMutableString stringWithString:@"appstore/appInstance?"];
    [request appendFormat:@"bundle=%@&", bundle];
    
    if(locationId != PPLocationIdNone) {
        [request appendFormat:@"locationId=%li&", (long)locationId];
    }
    if(organizationId != PPOrganizationIdNone) {
        [request appendFormat:@"organizationId=%li&", (long)organizationId];
    }
    if(circleId != PPCircleIdNone) {
        [request appendFormat:@"circleId=%li&", (long)circleId];
    }
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.botengine.purchaseAppInstance()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    
    [[PPCloudEngine sharedAppStrippedEngine] POST:request success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPBotengineAppInstanceId instanceId = PPBotengineAppInstanceIdNone;
            
            if(!error) {
                instanceId = ((NSString *)[root objectForKey:@"appInstanceId"]).intValue;
            }

            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(instanceId, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(PPBotengineAppInstanceIdNone, error);
            });
        });
    }];
}
+ (void)purchaseAppInstance:(NSString *)bundle callback:(PPBotengineAppPurchaseBlock)callback {
    [PPBotengine purchaseAppInstance:bundle locationId:PPLocationIdNone organizationId:PPOrganizationIdNone circleId:PPCircleIdNone callback:callback];
}

/**
 * Configure an app instance
 *
 * @param appInstanceId NSString Globally unique bundle ID for the app, i.e. com.peoplepowerco.myfirstapp
 * @param status PPBotengineAppInstanceStatus App instance status
 * @param nickname NSString User defined nickname
 * @param timezone NSString The local timezone the app should run in
 * @param access NSArray Array of accessible categories/devices
 * @param communications NSArray Array of communication categories
 *
 * @param callback PPErrorBlock with server status
 */
+ (void)configureAppInstance:(NSInteger)appInstanceId status:(PPBotengineAppInstanceStatus)status nickname:(NSString *)nickname timezone:(NSString *)timezone access:(NSArray *)access communications:(NSArray *)communications callback:(PPErrorBlock)callback {
    NSMutableString *urlString = [NSMutableString stringWithString:@"appstore/appInstance?"];
    
    [urlString appendFormat:@"appInstanceId=%lu", (long unsigned)appInstanceId];
    
    if(status != PPBotengineAppInstanceStatusUndefined) {
        [urlString appendFormat:@"&status=%li", (long)status];
    }
    
    NSMutableString *JSONString = [NSMutableString stringWithFormat:@"{\"app\": {"];
    BOOL appendComma = NO;
    if(nickname) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"nickname\":\"%@\"", nickname];
        appendComma = YES;
    }
    
    if(timezone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"timezone\":\"%@\"", timezone];
        appendComma = YES;
    }
    
    if(access != nil) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendString:@"\"access\": ["];
        appendComma = NO;
        for(PPBotengineAppAccess *accessObj in access) {
            if(appendComma) {
                [JSONString appendString:@","];
            }
            [JSONString appendFormat:@"%@", [accessObj JSONString]];
            appendComma = YES;
        }
        [JSONString appendFormat:@"]"];
         appendComma = YES;
    }
    
    if([communications count] > 0) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendString:@"\"communications\": ["];
        appendComma = NO;
        for(PPBotengineAppCommunications *communicationsObj in communications) {
            if(appendComma) {
                [JSONString appendString:@","];
            }
            [JSONString appendFormat:@"%@", [communicationsObj JSONString]];
            appendComma = YES;
        }
        [JSONString appendFormat:@"]"];
    }
    
    [JSONString appendString:@"}}"];
    
    NSError *error;
    
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppStrippedEngine] getRequestSerializer] requestWithMethod:@"PUT" URLString:[NSURL URLWithString:urlString relativeToURL:[[PPCloudEngine sharedAppStrippedEngine] getBaseURL]].absoluteString parameters:nil error:&error];

    [request setHTTPBody:[JSONString dataUsingEncoding:NSUTF8StringEncoding]];
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.botengine.configureAppInstance()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppStrippedEngine] operationWithRequest:request success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        });
    }];
}

/**
 * Get my app instances
 *
 * @param appInstanceId PPBotengineAppInstanceId Optional app instance ID of a specific app instance to obtain information about
 * @param bundle NSString Optional Bundle name of a specific app instance to obtain information about
 * @param locationId PPLocationId Filtering bot instances by location
 * @param organizationId PPOrganizationId Return bots purchased by this organization
 * @param circleId PPCircleId Return bots purchased by this circle
 * @param userId PPUserId Get specific user bot instances by organization administrator
 *
 * @param callback PPBotengineAppsBlock Array of current app instances and server status
 */
+ (void)getAppInstances:(PPBotengineAppInstanceId)appInstanceId bundle:(NSString *)bundle locationId:(PPLocationId)locationId organizationId:(PPOrganizationId)organizationId circleId:(PPCircleId)circleId userId:(PPUserId)userId callback:(PPBotengineAppsBlock)callback {
    NSMutableString *request = [NSMutableString stringWithString:@"appstore/appInstance?"];
    
    if(appInstanceId != PPBotengineAppInstanceIdNone) {
        [request appendFormat:@"appInstanceId=%li&", (long)appInstanceId];
    }
    
    if(bundle) {
        [request appendFormat:@"bundle=%@&", bundle];
    }
    
    if(locationId != PPLocationIdNone) {
        [request appendFormat:@"locationId=%li&", (long)locationId];
    }
    if(organizationId != PPOrganizationIdNone) {
        [request appendFormat:@"organizationId=%li&", (long)organizationId];
    }
    if(circleId != PPCircleIdNone) {
        [request appendFormat:@"circleId=%li&", (long)circleId];
    }
    if(userId != PPUserIdNone) {
        [request appendFormat:@"userId=%li&", (long)userId];
    }
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.botengine.getAppInstances()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppStrippedEngine] GET:request success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSMutableArray *appInstances;
            
            if(!error) {
                appInstances = [[NSMutableArray alloc] init];
                for(NSDictionary *appDict in [root objectForKey:@"apps"]) {
                    PPBotengineAppInstance *appInstance = [PPBotengineAppInstance appInstanceFromAppInstanceDict:appDict];
                    [appInstances addObject:appInstance];
                }
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(appInstances, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, error);
            });
        });
    }];
}
+ (void)getAppInstances:(PPBotengineAppInstanceId)appInstanceId bundle:(NSString *)bundle callback:(PPBotengineAppsBlock)callback {
    [PPBotengine getAppInstances:appInstanceId bundle:bundle locationId:PPLocationIdNone organizationId:PPOrganizationIdNone circleId:PPCircleIdNone userId:PPUserIdNone callback:callback];
}

/**
 * Delete an app instances
 *
 * @param appInstanceId NSString Optional ID of a specific app instance to obtain information about
 *
 * @param callback NSError with server status
 */
+ (void)deleteAppInstances:(NSInteger)appInstanceId callback:(PPErrorBlock)callback {
    NSString *request = [NSString stringWithFormat:@"appstore/appInstance?appInstanceId=%lu", (long unsigned)appInstanceId];
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.botengine.deleteAppInstances()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppStrippedEngine] DELETE:request success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        });
    }];
}

/**
 * Get app reviews
 *
 * @param bundle NSString Globally unique bundle ID for the app, i.e. com.peoplepowerco.myfirstapp
 * @param mine BOOL Return only my review, if I previously wrote one for this app
 * @param version NSString Filter by version number
 * @param lang Language filter, leave blank to return apps in all languages
 *
 * @param callback PPBotengineAppReviewBlock Average rating, list of reviews and server status
 */
+ (void)getAppReviews:(NSString *)bundle mine:(BOOL)mine version:(NSString *)version language:(NSString *)lang callback:(PPBotengineAppReviewBlock)callback {
    NSMutableString *request = [NSMutableString stringWithString:@"appstore/reviews?"];
    [request appendFormat:@"bundle=%@&", bundle];
    [request appendFormat:@"mine=%@&", (mine == YES) ? @"true" : @"false"];

    if(version) {
        [request appendFormat:@"version=%@&", version];
    }
    
    if(lang) {
        [request appendFormat:@"lang=%@&", lang];
    }
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.botengine.getAppReviews()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppStrippedEngine] GET:request success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPBotengineAppRating *rating;
            NSMutableArray *reviews;
            
            if(!error) {
                
                rating = [PPBotengineAppRating ratingFromDict:[root objectForKey:@"rating"]];
                reviews = [[NSMutableArray alloc] init];
                for(NSDictionary *reviewDict in [root objectForKey:@"reviews"]) {
                    PPBotengineAppReview *review = [PPBotengineAppReview appReviewFromDict:reviewDict];
                    [reviews addObject:review];
                }
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(rating, reviews, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, nil, error);
            });
        });
    }];
}

/**
 * Write app review
 * A user should only be able to supply a single rating for an app, not multiple ratings for the same app. If a review already exists from this user, we should overwrite the previous review with the new one. The nickname is likely the person's registered First and Last name, but should be modifiable to keep the review totally anonymous. A developer cannot publish a review for own app.
 *
 * @param bundle Globally unique bundle ID for the app
 * @param rating NSInteger
 * @param lang NSString
 * @param desc NSString
 *
 * @param callback NSError with server status
 */
+ (void)writeAppReview:(NSString *)bundle rating:(NSInteger)rating language:(NSString *)lang desc:(NSString *)desc nickname:(NSString *)nickname callback:(PPErrorBlock)callback {
    NSMutableString *urlString = [NSMutableString stringWithString:@"appstore/reviews?"];
    [urlString appendFormat:@"bundle=%@&", bundle];
    
    NSMutableString *JSONString = [NSMutableString stringWithFormat:@"{"];
    [JSONString appendString:@"\"review\": {"];
    BOOL appendComma = NO;
    if(rating) {
        [JSONString appendFormat:@"\"rating\": \"%lu\"", (long unsigned)rating];
        appendComma = YES;
    }
    
    if(lang) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"lang\":\"%@\"", lang];
        appendComma = YES;
    }
    
    if(desc) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"desc\":\"%@\"", desc];
        appendComma = YES;
    }
    
    if(nickname) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"nickname\":\"%@\"", nickname];
    }
    
    [JSONString appendString:@"}}"];
    
    NSError *error;
    
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppStrippedEngine] getRequestSerializer] requestWithMethod:@"POST" URLString:[NSURL URLWithString:urlString relativeToURL:[[PPCloudEngine sharedAppStrippedEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    
    [request setHTTPBody:[JSONString dataUsingEncoding:NSUTF8StringEncoding]];
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.botengine.writeAppReview()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppStrippedEngine] operationWithRequest:request success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        });
    }];
}

/**
 * Vote for review
 * A user should only be able to vote another user review up or down one time.
 *
 * @param reviewId NSInteger
 * @param vote PPBotengineAppReviewVote vote value
 *
 * @param callback NSError with server status
 */
+ (void)voteForReview:(NSInteger)reviewId vote:(PPBotengineAppReviewVote)vote callback:(PPErrorBlock)callback {
    NSMutableString *request = [NSMutableString stringWithString:@"appstore/reviews/"];
    [request appendFormat:@"%lu/", (long unsigned)reviewId];
    [request appendFormat:@"vote/%li", (long)vote];
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.botengine.voteForReview()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppStrippedEngine] PUT:request success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        });
    }];
}

/**
 * Send a data stream message
 * Applications can send a message to bots.
 * The message can be sent to bots subscribed on the specific data stream address or bots of provided instands ID's
 * End users can send messages to bots only purchased by them including organizational bots. Organization administrators can send messages to organizational bots in the same organization and to non-organization and individual bots of user in this organization.
 * The end user IDs and the bot IDs (appInstanceId) are specified in the request body.
 *
 * @param scope PPBotengineAppInstanceDataStreamBitmask Optional Bitmask to feed organization and/or individual bots
 * @param address NSString Data stream address
 * @param locationId PPLocationId Send data to bots of this location. Mandatatory for end users.
 * @param organizationId PPOrganizationId Send data to bots of users of the specific organization, used by an administrator.
 * @param feed NSDictionry Feed to send to the bot
 * @param appInstanceId NSInteger ID of a specific app instance to obtain information about
 *
 * @param callback NSError with server status
 */
+ (void)postDataStream:(PPBotengineAppInstanceDataStreamBitmask)scope address:(NSString *)address locationId:(PPLocationId)locationId organizationId:(PPOrganizationId)organizationId feed:(NSDictionary *)feed appInstanceId:(NSInteger)appInstanceId callback:(PPErrorBlock)callback {
    NSMutableString *urlString = [NSMutableString stringWithFormat:@"appstore/stream?address=%@&", address];
    
    if(scope != PPBotengineAppInstanceDataStreamBitmaskUndefined) {
        [urlString appendFormat:@"scope=%li&", (long)scope];
    }
    
    if(locationId != PPLocationIdNone) {
        [urlString appendFormat:@"locationId=%li&", (long)locationId];
    }
    if(organizationId != PPOrganizationIdNone) {
        [urlString appendFormat:@"organizationId=%li&", (long)organizationId];
    }
    
    NSMutableDictionary *data = @{}.mutableCopy;
    if (appInstanceId != PPBotengineAppInstanceIdNone) {
        [data setObject:@[@(appInstanceId)] forKey:@"bots"];
    }
    [data setObject:feed forKey:@"feed"];
    
    NSError *dataError;
    NSData *body = [NSJSONSerialization dataWithJSONObject:data options:0 error:&dataError];
    if(dataError) {
        callback([PPBaseModel resultCodeToNSError:14 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",dataError.userInfo]]);
        return;
    }
    
    NSError *error;
    
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppStrippedEngine] getRequestSerializer] requestWithMethod:@"POST" URLString:[NSURL URLWithString:urlString relativeToURL:[[PPCloudEngine sharedAppStrippedEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    [request setHTTPBody:body];
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.botengine.postDataStream()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppStrippedEngine] operationWithRequest:request success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        });
    }];
}
+ (void)postDataStream:(PPBotengineAppInstanceDataStreamBitmask)scope address:(NSString *)address feed:(NSDictionary *)feed appInstanceId:(NSInteger)appInstanceId callback:(PPErrorBlock)callback {
    [PPBotengine postDataStream:scope address:address locationId:PPLocationIdNone organizationId:PPOrganizationIdNone feed:feed appInstanceId:appInstanceId callback:callback];
}

/**
 * Summary
 * Returns microservices and data stream addresses for specified location or organization.
 *
 * @param locationId PPLocationId Location ID
 * @param organizationId PPOrganizationId Organization ID
 *
 * @param callback PPBotengineSummaryBlock Summary return block
 */
+ (void)getSummary:(PPLocationId)locationId organizationId:(PPOrganizationId)organizationId callback:(PPBotengineSummaryBlock _Nonnull )callback {
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    NSMutableString *request = [NSMutableString stringWithFormat:@"appstore/summary?locationId=%li&", (long)locationId];
    
    if(organizationId != PPOrganizationIdNone) {
        [request appendFormat:@"organizationId=%li&", (long)organizationId];
    }
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.botengine.getSummary()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppStrippedEngine] GET:request success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSMutableArray *dataStreams;
            NSMutableArray *microServices;
            
            if(!error) {
                dataStreams = [root objectForKey:@"dataStreams"];
                microServices = [root objectForKey:@"microServices"];
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(dataStreams, microServices, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, nil, error);
            });
        });
    }];
}

@end
