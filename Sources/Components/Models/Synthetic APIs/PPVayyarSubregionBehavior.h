//
//  PPVayyarSubregionBehavior.h
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
@interface PPVayyarSubregionBehavior : PPBaseModel

@property (nonatomic) PPVayyarContextId contextId;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * detail;
@property (nonatomic, strong) NSString * icon;
@property (nonatomic, strong) NSString * iconFont;
@property (nonatomic, strong) NSNumber * width;
@property (nonatomic, strong) NSNumber * length;
@property (nonatomic) BOOL flexible;
@property (nonatomic) BOOL detectFalls;
@property (nonatomic) BOOL editFalls;
@property (nonatomic) BOOL detectPresence;
@property (nonatomic) BOOL editPresence;
@property (nonatomic, strong) NSNumber * enterDuration;
@property (nonatomic, strong) NSNumber * exitDuration;
@property (nonatomic, strong) NSArray * compatibleBehaviors;

- (id)initWithContextId:(PPVayyarContextId)contextId
                  title:(NSString *)title
                 detail:(NSString *)detail
                   icon:(NSString *)icon
               iconFont:(NSString *)iconFont
                  width:(NSNumber *)width
                 length:(NSNumber *)length
               flexible:(BOOL)flexible
            detectFalls:(BOOL)detectFalls
              editFalls:(BOOL)editFalls
         detectPresence:(BOOL)detectPresence
           editPresence:(BOOL)editPresence
          enterDuration:(NSNumber *)enterDuration
           exitDuration:(NSNumber *)exitDuration
    compatibleBehaviors:(NSArray *)compatibleBehaviors;

+ (PPVayyarSubregionBehavior *)initWithData:(NSDictionary *)data;

- (NSString *)detectionStatus;
- (UIColor *)detectionStatusColor;

@end

NS_ASSUME_NONNULL_END
