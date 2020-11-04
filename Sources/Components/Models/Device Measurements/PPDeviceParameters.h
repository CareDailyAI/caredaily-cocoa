//
//  PPDeviceParameters.h
//  Peoplepower
//
//  Created by Destry Teeter on 2/27/18.
//  Copyright © 2020 People Power. All rights reserved.
//

#import "PPBaseModel.h"

@interface PPDeviceParameters : PPBaseModel

/*
 * Change parameter into user friend string
 *
 * Configured parameter options: deviceTypeId, value
 *
 * @param parameter NSString parameter name
 * @param options NSDictionary parameter options.
 *
 * @return NSString user friend string for parameter value.  If no value, then return default name for parameter.
 */
+ (NSString *)stringForDeviceParameter:(NSString *)parameter options:(NSDictionary *)options;

+ (NSDictionary *)fontIconStringForDeviceParameter:(NSString *)parameter options:(NSDictionary *)options __attribute__((deprecated));

+ (NSDictionary *)parameterOptionsWithValue:(NSString *)value deviceTypeId:(NSInteger)deviceTypeId;
+ (NSDictionary *)parameterOptionsWithValue:(NSString *)value deviceTypeId:(NSInteger)deviceTypeId index:(NSString *)index;

+ (NSArray *)fanModesForSequence:(PPDeviceParametersFanModeSequence)sequence;

+ (NSArray *)systemModeStatuses;

+ (NSArray *)powerStatuses;

/*
 * Check if a historical measurements are supported for a given parameter
 *
 * @param parameter NSString parameter name
 *
 * @return BOOL true if this parameter supports historical measurements
 */
+ (BOOL)parameterSupportsHistoricalMeasurements:(NSString *)parameter;

@end
