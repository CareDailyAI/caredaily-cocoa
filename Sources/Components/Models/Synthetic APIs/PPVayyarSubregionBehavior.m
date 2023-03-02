//
//  PPVayyarSubregionBehavior.m
//  Peoplepower
//
//  Created by Destry Teeter on 7/2/21.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPVayyarSubregionBehavior.h"

@implementation PPVayyarSubregionBehavior

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
    compatibleBehaviors:(RLMArray *)compatibleBehaviors {
    self = [super init];
    if (self) {
        self.contextId = contextId;
        self.title = title;
        self.detail = detail;
        self.icon = icon;
        self.iconFont = iconFont;
        self.width = width;
        self.length = length;
        self.flexible = flexible;
        self.detectFalls = detectFalls;
        self.editFalls = editFalls;
        self.detectPresence = detectPresence;
        self.editPresence = editPresence;
        self.enterDuration = enterDuration;
        self.exitDuration = exitDuration;
        self.compatibleBehaviors = (RLMArray<RLMInt> *)compatibleBehaviors;
    }
    return self;
}

+ (PPVayyarSubregionBehavior *)initWithData:(NSDictionary *)data {
    PPVayyarContextId contextId = PPVayyarContextIdNone;
    if ([data valueForKey:@"context_id"]) {
        contextId = ((NSNumber *)[data valueForKey:@"context_id"]).intValue;
    }
    NSString * title = [data valueForKey:@"title"];
    NSString * detail = [data valueForKey:@"description"];
    NSString * icon = [data valueForKey:@"icon"];
    NSString * iconFont = [data valueForKey:@"icon_font"];
    NSNumber * width = [data valueForKey:@"width_cm"];
    NSNumber * length = [data valueForKey:@"length_cm"];
    BOOL flexible = false;
    if ([data valueForKey:@"flexible"]) {
        flexible = ((NSNumber *)[data valueForKey:@"flexible"]).intValue;
    }
    BOOL detectFalls = false;
    if ([data valueForKey:@"detect_falls"]) {
        detectFalls = ((NSNumber *)[data valueForKey:@"detect_falls"]).intValue;
    }
    BOOL editFalls = false;
    if ([data valueForKey:@"edit_falls"]) {
        editFalls = ((NSNumber *)[data valueForKey:@"edit_falls"]).intValue;
    }
    BOOL detectPresence = false;
    if ([data valueForKey:@"detect_presence"]) {
        detectPresence = ((NSNumber *)[data valueForKey:@"detect_presence"]).intValue;
    }
    BOOL editPresence = false;
    if ([data valueForKey:@"edit_presence"]) {
        editPresence = ((NSNumber *)[data valueForKey:@"edit_presence"]).intValue;
    }
    NSNumber * enterDuration = [data valueForKey:@"enter_duration_s"];
    NSNumber * exitDuration = [data valueForKey:@"exit_duration_s"];
    NSArray * compatibleBehaviors = [data valueForKey:@"compatible_behaviors"];;
    
    PPVayyarSubregionBehavior *behavior = [[PPVayyarSubregionBehavior alloc] initWithContextId:contextId
                                                                                         title:title
                                                                                        detail:detail
                                                                                          icon:icon
                                                                                      iconFont:iconFont
                                                                                         width:width
                                                                                        length:length
                                                                                      flexible:flexible
                                                                                   detectFalls:detectFalls
                                                                                     editFalls:editFalls
                                                                                detectPresence:detectPresence
                                                                                  editPresence:editPresence
                                                                                 enterDuration:enterDuration
                                                                                  exitDuration:exitDuration
                                                                           compatibleBehaviors:(RLMArray *)compatibleBehaviors];
    return behavior;
}

@end
