//
//  PPDynamicUIScreen.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/12/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPDynamicUIScreen.h"

@implementation PPDynamicUIScreen

- (id)initWithScreenId:(NSString *)screenId order:(PPDynamicUIScreenOrder)order sections:(NSArray *)sections {
    self = [super init];
    if(self) {
        self.screenId = screenId;
        self.order = order;
        self.sections = sections;
    }
    return self;
}

+ (PPDynamicUIScreen *)initWithDictionary:(NSDictionary *)screenDict {
    NSString *screenId = [screenDict objectForKey:@"id"];
    PPDynamicUIScreenOrder order = PPDynamicUIScreenOrderNone;
    if([screenDict objectForKey:@"order"]) {
        order = (PPDynamicUIScreenOrder)((NSString *)[screenDict objectForKey:@"order"]).integerValue;
    }
    
    NSMutableArray *sections;
    if([screenDict objectForKey:@"sections"]) {
        sections = [[NSMutableArray alloc] initWithCapacity:0];
        for(NSDictionary *sectionDict in [screenDict objectForKey:@"sections"]) {
            PPDynamicUIScreenSection *section = [PPDynamicUIScreenSection initWithDictionary:sectionDict];
            [sections addObject:section];
        }
    }
    
    PPDynamicUIScreen *screen = [[PPDynamicUIScreen alloc] initWithScreenId:screenId order:order sections:sections];
    return screen;
}

#pragma mark - Helper methods

- (BOOL)isEqualToScreen:(PPDynamicUIScreen *)screen {
    BOOL equal = NO;
    
    if(screen.screenId && _screenId) {
        if([screen.screenId isEqualToString:_screenId]) {
            equal = YES;
        }
    }
    return equal;
}

- (void)sync:(PPDynamicUIScreen *)screen {
    if(screen.screenId) {
        _screenId = screen.screenId;
    }
    if(screen.order != PPDynamicUIScreenSectionOrderNone) {
        _order = screen.order;
    }
    if(screen.sections) {
        _sections = screen.sections;
    }
}

@end
