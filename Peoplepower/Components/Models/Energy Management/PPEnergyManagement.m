//
//  PPEnergyManagement.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/12/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPEnergyManagement.h"
#import "PPCloudEngine.h"

@implementation PPEnergyManagement

#pragma mark - Energy Measurements by Location

/**
 * Get Energy Usage for a Location.
 *
 * @param locationId Required PPLocationId Location ID for which to obtain energy measurements
 * @param aggregation Required PPEnergyManagementAggregation How to aggregate / split the energy data
 * @param startDate Required NSDate Start date to begin receiving measurements, example: 2014-08-01T12:00:00-08:00
 * @param endDate NSDate End date to stop receiving measurements, example: 2014-08-01T13:00:00-08:00. Default is the current date.
 * @param external PPEnergyManagementUsageExternal Define the preference for internal vs. external data sources
 * @param callback PPEnergyManagementUsageBlock Usage callback block
 **/
+ (void)getEnergyUsageForLocation:(PPLocationId)locationId aggregation:(PPEnergyManagementAggregation)aggregation startDate:(NSDate *)startDate endDate:(NSDate *)endDate external:(PPEnergyManagementUsageExternal)external callback:(PPEnergyManagementUsageBlock)callback {
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    NSAssert1(aggregation != PPEnergyManagementAggregationNone, @"%s missing aggregation", __FUNCTION__);
    NSAssert1(startDate != nil, @"%s missing startDate", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"locations/%li/energyUsage/%li/", (long)locationId, (long)aggregation];
    
    [requestString appendFormat:@"%@?", [PPNSString stringByAddingURIPercentEscapesUsingEncoding:NSUTF8StringEncoding toString:[PPNSDate apiFriendStringFromDate:startDate]]];
    
    if(endDate) {
        [requestString appendFormat:@"endDate=%@&", [PPNSString stringByAddingURIPercentEscapesUsingEncoding:NSUTF8StringEncoding toString:[PPNSDate apiFriendStringFromDate:endDate]]];
    }
    
    if(external != PPEnergyManagementUsageExternalNone) {
        [requestString appendFormat:@"external=%li&", (long)external];
    }
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.energymanagement.getEnergyUsageForLocation()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppEngine] GET:requestString success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSMutableArray *usages;
            
            if(!error) {
                usages = [[NSMutableArray alloc] initWithCapacity:0];
                for(NSDictionary *usageDict in [root objectForKey:@"usages"]) {
                    PPEnergyManagementUsage *usage = [PPEnergyManagementUsage initWithDictionary:usageDict];
                    [usages addObject:usage];
                }
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(usages, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

#pragma mark - Upload Utility Bills for a Location

/**
 * Upload Utility Bills for a Location.
 *
 * @param locationId Required PPLocationId Location ID for which to update utility bill information
 * @param billData Required NSArray Bill data to upload
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)uploadUtilityBillsForLocation:(PPLocationId)locationId billData:(NSArray *)billData callback:(PPErrorBlock)callback {
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    NSAssert1(billData != nil && [billData count] > 0, @"%s missing billData", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"locations/%li/billData?", (long)locationId];
    
    NSMutableString *JSONString = [[NSMutableString alloc] init];
    [JSONString appendString:@"{"];
    [JSONString appendString:@"\"billData\": ["];
    BOOL appendComma = NO;
    for(PPEnergyManagementUtilityBill *bill in billData) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendString:[PPEnergyManagementUtilityBill stringify:bill]];
        appendComma = YES;
    }
    [JSONString appendString:@"]"];
    [JSONString appendString:@"}"];
    
    NSError *error;
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppEngine] getRequestSerializer] requestWithMethod:@"POST" URLString:[NSURL URLWithString:requestString relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    [request setHTTPBody:[JSONString dataUsingEncoding:NSUTF8StringEncoding]];
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.energymanagement.uploadUtilityBillsForLocation()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppEngine] operationWithRequest:request success:^(NSData *responseData) {
        
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
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

#pragma mark - Delete a Utility Bill

/**
 * Delete a Utility Bill.
 *
 * @param locationId Required PPLocationId Location ID for which to delete a utility bill
 * @param billId Required PPEnergyManagementUtilityBillId Specific Bill ID to delete
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)deleteUtilityBill:(PPLocationId)locationId billId:(PPEnergyManagementUtilityBillId)billId callback:(PPErrorBlock)callback {
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    NSAssert1(billId != PPEnergyManagementUtilityBillIdNone, @"%s missing billId", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"locations/%li/bills/%li/", (long)locationId, (long)billId];
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.energymanagement.deleteUtilityBill()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppEngine] DELETE:requestString success:^(NSData *responseData) {
        
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
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

#pragma mark - Get Device Energy Usage

/**
 * Get Device Energy Usage.
 * Return a device's values of power, billing rate, its associated cost, total energy usage, and its cost for the current day, month and year.
 * By default, this API returns total device values. To get the values for the specific part of a device, use an index number (assuming the device supports parameters with index numbers).
 * This method uses the time zone ID from the device location to calculate values. If the time zone is not set, it uses the default server time zone.
 *
 * @param deviceId Required NSString Device ID for which to obtain energy-related data
 * @param index NSString Optional index number to obtain energy-related data from a part of a device (assuming the device supports index numbers)
 * @param locationId Required PPLocationId Request information on a specific location
 * @param userId PPUserId Optional User ID, used by administrator accounts to specific a user to pull energy-related data from
 * @param callback PPEnergyManagementDeviceUsageBlock Device usage callback block
 **/
+ (void)getDeviceEnergyUsage:(NSString *)deviceId index:(NSString *)index locationId:(PPLocationId)locationId userId:(PPUserId)userId callback:(PPEnergyManagementDeviceUsageBlock)callback {
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    NSAssert1(deviceId != nil, @"%s missing deviceId", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"devices/%@/currentEnergyUsage?", [PPNSString stringByAddingURIPercentEscapesUsingEncoding:NSUTF8StringEncoding toString:deviceId]];
    
    if(index) {
        [requestString appendFormat:@"index=%@&", index];
    }
    if(locationId != PPLocationIdNone) {
        [requestString appendFormat:@"locationId=%li&", (long)locationId];
    }
    if(userId != PPUserIdNone) {
        [requestString appendFormat:@"userId=%li&", (long)userId];
    }
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.energymanagement.getDeviceEnergyUsage()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppEngine] GET:requestString success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPEnergyManagementDeviceUsagePower *power;
            PPEnergyManagementDeviceUsageEnergy *energy;
            
            if(!error) {
                power = [PPEnergyManagementDeviceUsagePower initWithDictionary:[root objectForKey:@"power"]];
                energy = [PPEnergyManagementDeviceUsageEnergy initWithDictionary:[root objectForKey:@"energy"]];
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(power, energy, error);
            });
        });
    } failure:^(NSError *error) {

        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

#pragma mark - Get Aggregated Energy Usage for a Device

/**
 * Get Aggregated Energy Usage for a Device.
 * Return energy usage at a device level for a specified period of time, and aggregated by different periods.
 * This method uses the time zone ID from the device location to calculate values. If the time zone is not set, it uses the default server time zone.
 *
 * @param deviceId Required NSString Device ID for which to obtain aggregated energy usage
 * @param aggregation Required PPEnergyManagementAggregation How to aggregate / split the energy data
 * @param startDate Required NSDate Start date to begin aggregating energy measurements, example: 2014-08-01T12:00:00-08:00
 * @param endDate NSDate End date to stop aggregating energy measurements, example: 2014-08-01T13:00:00-08:00. Default is the current date.
 * @param reduceNoise PPEnergyManagementReducesNoise Return tiny energy values less than defined threshold as zero
 * @param locationId Required PPLocationId Request information on a specific location
 * @param userId PPUserId User ID to receive aggregated energy measurements from, only called by administrator accounts
 * @param callback PPEnergyManagementAggregatedDeviceUsageBlock Aggregated device usage callback block
 **/
+ (void)getAggregatedEnergyUsageForDevice:(NSString *)deviceId aggregation:(PPEnergyManagementAggregation)aggregation startDate:(NSDate *)startDate endDate:(NSDate *)endDate reduceNoise:(PPEnergyManagementReducesNoise)reduceNoise locationId:(PPLocationId)locationId userId:(PPUserId)userId callback:(PPEnergyManagementAggregatedDeviceUsageBlock)callback {
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    NSAssert1(deviceId != nil, @"%s missing deviceId", __FUNCTION__);
    NSAssert1(aggregation != PPEnergyManagementAggregationNone, @"%s missing aggregation", __FUNCTION__);
    NSAssert1(startDate != nil, @"%s missing startDate", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"devices/%@/energyUsage/%li/", [PPNSString stringByAddingURIPercentEscapesUsingEncoding:NSUTF8StringEncoding toString:deviceId], (long)aggregation];
    
    [requestString appendFormat:@"%@?", [PPNSString stringByAddingURIPercentEscapesUsingEncoding:NSUTF8StringEncoding toString:[PPNSDate apiFriendStringFromDate:startDate]]];
    
    if(endDate) {
        [requestString appendFormat:@"endDate=%@&", [PPNSString stringByAddingURIPercentEscapesUsingEncoding:NSUTF8StringEncoding toString:[PPNSDate apiFriendStringFromDate:endDate]]];
    }
    
    if(locationId != PPLocationIdNone) {
        [requestString appendFormat:@"locationId=%li&", (long)locationId];
    }
    
    if(reduceNoise != PPEnergyManagementReducesNoiseNone) {
        [requestString appendFormat:@"reduceNoise=%@&", (reduceNoise) ? @"true" : @"false"];
    }
    if(userId != PPUserIdNone) {
        [requestString appendFormat:@"userId=%li&", (long)userId];
    }
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.energymanagement.getAggrevatedEnergyUsageForDevice()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppEngine] GET:requestString success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSMutableArray *usages;
            
            if(!error) {
                usages = [[NSMutableArray alloc] initWithCapacity:0];
                for(NSDictionary *usageDict in [root objectForKey:@"usages"]) {
                    PPEnergyManagementDeviceUsageAggregated *usage = [PPEnergyManagementDeviceUsageAggregated initWithDictionary:usageDict];
                    [usages addObject:usage];
                }
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(usages, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

#pragma mark - Get Billing Information

/**
 * Get Billing Information.
 * The IoT Software Suite contains a billing rates database capable of storing flat-rate, time-of-use, and tiered pricing schemes for utility billing. This group of APIs tracks billing information, and also tracks the user's customizable budget information to help keep them on track.
 * A billing day is the day when the user gets charged by the utility. The billing day is an integer representing a single day of the month, like "28" for the 28th day of the month. Each billing cycle ends on the day before the billing day, at 23:59:59. A new billing cycle starts at 00:00:00 on the billing day.
 *
 * @param locationId Required PPLocationId Location ID to obtain billing information for.
 * @param filter Required PPEnergyManagementBillingInfoFilter Filter response by day, budget, rate, or billing
 * @param callback PPEnergyManagementBillingInfoBlock Billing Info callback block
 **/
+ (void)getBillingInformation:(PPLocationId)locationId filter:(PPEnergyManagementBillingInfoFilter)filter callback:(PPEnergyManagementBillingInfoBlock)callback {
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    NSAssert1(filter != PPEnergyManagementBillingInfoFilterNone, @"%s missing filter", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"locations/%li/billing/%li", (long)locationId, (long)filter];
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.energymanagement.getBillingInformation()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppEngine] GET:requestString success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPEnergyManagementBillingInfo *billingInfo;
            
            if(!error) {
                billingInfo = [PPEnergyManagementBillingInfo initWithDictionary:root];
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(billingInfo, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

#pragma mark - Update Billing Information

/**
 * Update Billing Information.
 * Update the billing day, billing rate, and budget information. All fields are optional.
 *
 * @param locationId Required PPLocationId
 * @param billingInfo Required PPEnergyManagementBillingInfo Billing info object to sync to the server
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)updateBillingInformation:(PPLocationId)locationId billingInfo:(PPEnergyManagementBillingInfo *)billingInfo callback:(PPErrorBlock)callback {
    NSAssert1(locationId != PPLocationIdNone, @"%s missing locationId", __FUNCTION__);
    NSAssert1(billingInfo != nil, @"%s missing billingInfo", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"locations/%li/billing?", (long)locationId];
    
    NSMutableString *JSONString = [[NSMutableString alloc] init];
    [JSONString appendString:@"{"];
    [JSONString appendFormat:@"\"billingInfo\": %@", [PPEnergyManagementBillingInfo stringify:billingInfo]];
    [JSONString appendString:@"}"];
    
    NSError *error;
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppEngine] getRequestSerializer] requestWithMethod:@"PUT" URLString:[NSURL URLWithString:requestString relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    [request setHTTPBody:[JSONString dataUsingEncoding:NSUTF8StringEncoding]];
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.energymanagement.updateBillingInformation()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppEngine] operationWithRequest:request success:^(NSData *responseData) {
        
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
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

@end

