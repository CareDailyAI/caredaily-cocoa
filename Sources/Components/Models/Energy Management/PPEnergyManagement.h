//
//  PPEnergyManagement.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/12/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//
// Electricity customers are billed on how much energy their homes, businesses, and appliances consume. The IoT Software Suite enables post-processing and analytics on energy measurements, to slice and dice the data as needed to create a valuable user experience.
// The IoT Software Suite contains a Utility Rates Database in the backend to map utility names to their current rates and pricing information. This data can help smooth out the deployment of energy-related programs, and greatly improve the user experience by converting the nebulous units of kilowatt-hours into something more user friendly, like monetary value.
//
// Green Button
// The United States national Green Button standard was originally created by and spun out of People Power Company with John Teeter, People Power's Chief Scientist.
// Green Button API's are implemented according to http://services.greenbuttondata.org/All API's have URI prefix {server}/espapi/gb/xml/.
// JSON format is not supported.
//

#import "PPBaseModel.h"
#import "PPEnergyManagementUsage.h"
#import "PPEnergyManagementUtilityBill.h"
#import "PPEnergyManagementDeviceUsageEnergy.h"
#import "PPEnergyManagementDeviceUsagePower.h"
#import "PPEnergyManagementDeviceUsageAggregated.h"
#import "PPEnergyManagementBillingInfo.h"

@interface PPEnergyManagement : PPBaseModel

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
+ (void)getEnergyUsageForLocation:(PPLocationId)locationId aggregation:(PPEnergyManagementAggregation)aggregation startDate:(NSDate * _Nonnull )startDate endDate:(NSDate * _Nullable )endDate external:(PPEnergyManagementUsageExternal)external callback:(PPEnergyManagementUsageBlock _Nonnull )callback;

#pragma mark - Upload Utility Bills for a Location

/**
 * Upload Utility Bills for a Location.
 *
 * @param locationId Required PPLocationId Location ID for which to update utility bill information
 * @param billData Required NSArray Bill data to upload
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)uploadUtilityBillsForLocation:(PPLocationId)locationId billData:(NSArray * _Nonnull )billData callback:(PPErrorBlock _Nonnull )callback;

#pragma mark - Delete a Utility Bill

/**
 * Delete a Utility Bill.
 *
 * @param locationId Required PPLocationId Location ID for which to delete a utility bill
 * @param billId Required PPEnergyManagementUtilityBillId Specific Bill ID to delete
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)deleteUtilityBill:(PPLocationId)locationId billId:(PPEnergyManagementUtilityBillId)billId callback:(PPErrorBlock _Nonnull )callback;

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
+ (void)getDeviceEnergyUsage:(NSString * _Nonnull )deviceId index:(NSString * _Nullable )index locationId:(PPLocationId)locationId userId:(PPUserId)userId callback:(PPEnergyManagementDeviceUsageBlock _Nonnull )callback;

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
+ (void)getAggregatedEnergyUsageForDevice:(NSString * _Nonnull )deviceId aggregation:(PPEnergyManagementAggregation)aggregation startDate:(NSDate * _Nonnull )startDate endDate:(NSDate * _Nullable )endDate reduceNoise:(PPEnergyManagementReducesNoise)reduceNoise locationId:(PPLocationId)locationId userId:(PPUserId)userId callback:(PPEnergyManagementAggregatedDeviceUsageBlock _Nonnull )callback;

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
+ (void)getBillingInformation:(PPLocationId)locationId filter:(PPEnergyManagementBillingInfoFilter)filter callback:(PPEnergyManagementBillingInfoBlock _Nonnull )callback;

#pragma mark - Update Billing Information

/**
 * Update Billing Information.
 * Update the billing day, billing rate, and budget information. All fields are optional.
 *
 * @param locationId Required PPLocationId
 * @param billingInfo Required PPEnergyManagementBillingInfo Billing info object to sync to the server
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)updateBillingInformation:(PPLocationId)locationId billingInfo:(PPEnergyManagementBillingInfo * _Nonnull )billingInfo callback:(PPErrorBlock _Nonnull )callback;

@end
