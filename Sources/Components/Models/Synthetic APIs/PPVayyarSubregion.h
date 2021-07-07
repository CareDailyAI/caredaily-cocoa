//
//  PPVayyarSubregion.h
//  Peoplepower
//
//  Created by Destry Teeter on 7/2/21.
//  Copyright © 2021 People Power Company. All rights reserved.
//

#import <Peoplepower/Peoplepower.h>

NS_ASSUME_NONNULL_BEGIN
/**
 * # Subregion Behavior
 * Parameters:
 * - `context_id` int Subregion Context ID to apply to this subregion.
 * - `title` String Title of the subregion
 * - `detail` String Optional detail description if it helps - usually the title is enough, but there were a few that deserved a bit more explanation.
 * - `icon` String Icon name
 * - `icon_font` String Icon font to apply
 * - `width_cm` int Recommended width of the subregion, in centimeters
 * - `length_cm` int Recommended length of the subregion, in centimeters
 * - `flexible_cm` Boolean True if the subregion size is flexible from our recommendations, False if this is a standard size
 * - `detect_falls` True to detect falls in this room, False to avoid detecting fall (default is True).
 * - `edit_falls` True to show UI controls for editing fall detection
 * - `detect_presence` True to detect people, False to not detect people (default is True).
 * - `edit_presence` True to show UI controls for editing presence detection
 * - `enter_duration_s` Number of seconds to wait until Vayyar Home declares someone entered this sub-region (default is 3 seconds).
 * - `exit_duration_s` Number of seconds to wait until Vayyar Home declares the sub-region is unoccupied (default is 3 seconds).
 * - `compatible_behaviors` List List of compatible behavior ID's, as defined in the `behaviors` state
 */
@interface PPVayyarSubregion : PPBaseModel

/// Device ID to apply this subregion to
@property (strong, nonatomic) NSString *deviceId;

/// Subregion ID of this subregion.  Optional. If provided then this is an existing subregion
@property (nonatomic) PPVayyarSubregionId subregionId;

/// Context / behavior of this subregion - see the Subregion Behavior Properties
@property (nonatomic) PPVayyarContextId contextId;

/// Context / behavior of this subregion - see the Subregion Behavior Properties
@property (strong, nonatomic) NSString *uniqueId;

/// Descriptive name of this subregion, default is the title of the subregion context that was selected.
@property (strong, nonatomic) NSString *name;

/// Required. Looking into the room from the device, this is the left-most side of the sub-region. Remember to the left of Vayyar Home is negative numbers on the x-axis.
@property (strong, nonatomic) NSNumber<RLMFloat> *xMin;

/// Required.Looking into the room from the device, this is the right-most side of the sub-region.
@property (strong, nonatomic) NSNumber<RLMFloat> *xMax;

/// Required. Distance from the Vayyar Home to the nearest side of the sub-region.
@property (strong, nonatomic) NSNumber<RLMFloat> *yMin;

/// Required. Distance from the Vayyar Home to the farthest side of the sub-region.
@property (strong, nonatomic) NSNumber<RLMFloat> *yMax;

/// Optional. True to detect falls in this room, False to avoid detecting fall (default is True).
@property (nonatomic) BOOL detectFalls;

/// Optional. True to detect people, False to not detect people (default is True).
@property (nonatomic) BOOL detectPresence;

/// Optional. Number of seconds to wait until Vayyar Home declares someone entered this sub-region (default is 3 seconds).
@property (strong, nonatomic) NSNumber<RLMInt> *enterDuration;

/// Optional. Number of seconds to wait until Vayyar Home declares the sub-region is unoccupied (default is 3 seconds).
@property (strong, nonatomic) NSNumber<RLMInt> *exitDuration;

- (id)initWithDeviceId:(NSString *)deviceId
           subregionId:(PPVayyarSubregionId)subregionId
             contextId:(PPVayyarContextId)contextId
              uniqueId:(NSString *)uniqueId
                  name:(NSString *)name
                  xMin:(NSNumber *)xMin
                  xMax:(NSNumber *)xMax
                  yMin:(NSNumber *)yMin
                  yMax:(NSNumber *)yMax
           detectFalls:(BOOL)detectFalls
        detectPresence:(BOOL)detectPresence
         enterDuration:(NSNumber *)enterDuration
          exitDuration:(NSNumber *)exitDuration;

+ (PPVayyarSubregion *)initWithDeviceId:(NSString *)deviceId data:(NSDictionary *)data;

@end

NS_ASSUME_NONNULL_END
