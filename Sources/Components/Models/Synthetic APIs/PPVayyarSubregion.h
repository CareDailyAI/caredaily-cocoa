//
//  PPVayyarSubregion.h
//  Peoplepower
//
//  Created by Destry Teeter on 7/2/21.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import <Peoplepower/Peoplepower.h>

NS_ASSUME_NONNULL_BEGIN
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
@property (strong, nonatomic) NSNumber *xMin;

/// Required.Looking into the room from the device, this is the right-most side of the sub-region.
@property (strong, nonatomic) NSNumber *xMax;

/// Required. Distance from the Vayyar Home to the nearest side of the sub-region.
@property (strong, nonatomic) NSNumber *yMin;

/// Required. Distance from the Vayyar Home to the farthest side of the sub-region.
@property (strong, nonatomic) NSNumber *yMax;

/// Optional. True to detect falls in this room, False to avoid detecting fall (default is True).
@property (nonatomic) BOOL detectFalls;

/// Optional. True to detect people, False to not detect people (default is True).
@property (nonatomic) BOOL detectPresence;

/// Optional. Number of seconds to wait until Vayyar Home declares someone entered this sub-region (default is 3 seconds).
@property (strong, nonatomic) NSNumber *enterDuration;

/// Optional. Number of seconds to wait until Vayyar Home declares the sub-region is unoccupied (default is 3 seconds).
@property (strong, nonatomic) NSNumber *exitDuration;

/// Optional. Associated occupant IDs (default is an empty array).
@property (strong, nonatomic) NSArray *occupantIds;

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
          exitDuration:(NSNumber *)exitDuration
           occupantIds:(NSArray *)occupantIds;

+ (PPVayyarSubregion *)initWithDeviceId:(NSString *)deviceId data:(NSDictionary *)data;

@end

NS_ASSUME_NONNULL_END
