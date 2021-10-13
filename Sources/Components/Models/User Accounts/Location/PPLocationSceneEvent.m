//
//  PPLocationSceneEvent.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/7/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPLocationSceneEvent.h"

@implementation PPLocationSceneEvent

+ (NSString *)primaryKey {
    return @"eventId";
}

- (NSString *)eventId {
    if(_dateMS > 0) {
        return [NSString stringWithFormat:@"%li-%li-%@", (long)_locationId, (long)_dateMS, _event];
    }
    return [NSString stringWithFormat:@"%li-%@", (long)_locationId, _event];
}

- (id)initWithEvent:(NSString *)event date:(NSDate *)date dateMS:(NSInteger)dateMS sourceType:(PPLocationSceneEventSourceType)sourceType sourceAgent:(NSString *)sourceAgent selected:(BOOL)selected comment:(NSString *)comment {
    self = [super init];
    if(self) {
        self.event = event;
        self.date = date;
        self.dateMS = dateMS;
        self.sourceType = sourceType;
        self.sourceAgent = sourceAgent;
        self.selected = selected;
        self.comment = comment;
        
        self.locationId = PPLocationIdNone;
    }
    return self;
}

+ (PPLocationSceneEvent *)initWithDictionary:(NSDictionary *)eventDict {
    NSString *eventName = [eventDict objectForKey:@"event"];
    NSString *eventDateString = [eventDict objectForKey:@"eventDate"];
    
    NSInteger eventDateMS = -1;
    if([eventDict objectForKey:@"eventDateMS"]) {
         eventDateMS = ((NSString *)[eventDict objectForKey:@"eventDate"]).integerValue;
    }
    NSDate *eventDate = [NSDate date];
    if(eventDateString != nil) {
        if(![eventDateString isEqualToString:@""]) {
            eventDate = [PPNSDate parseDateTime:eventDateString];
        }
    }
    
    PPLocationSceneEventSourceType eventSourceType = PPLocationSceneEventSourceTypeNone;
    if([eventDict objectForKey:@"sourceType"]) {
        eventSourceType = (PPLocationSceneEventSourceType)((NSString *)[eventDict objectForKey:@"sourceType"]);
    }
    NSString *eventSourceAgent = [eventDict objectForKey:@"sourceAgent"];
    
    NSString *comment = [eventDict objectForKey:@"comment"];
    
    PPLocationSceneEvent *event = [[PPLocationSceneEvent alloc] initWithEvent:eventName date:eventDate dateMS:eventDateMS sourceType:eventSourceType sourceAgent:eventSourceAgent selected:NO comment:comment];
    return event;
}

- (id)iconWithFrame:(id)frame defaultIconColor:(id)defaultIconColor {
    NSLog(@"%s deprecated. Use PPLocationSceneEventUI+event:iconWithFrame:defaultIconColor", __FUNCTION__);
    return nil;
}

+ (NSString *)localizedEventString:(NSString *)event {
    NSString *localizedEventString;;
    
    if([[event uppercaseString] rangeOfString:EVENT_HOME].location != NSNotFound) {
        localizedEventString = NSLocalizedStringWithDefaultValue(@"location.event.home", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Home", @"Home");
    }
    else if([[event uppercaseString] rangeOfString:EVENT_AWAY].location != NSNotFound) {
        localizedEventString = NSLocalizedStringWithDefaultValue(@"location.event.away", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Away", @"Away");
    }
    else if([[event uppercaseString] rangeOfString:EVENT_VACATION].location != NSNotFound) {
        localizedEventString = NSLocalizedStringWithDefaultValue(@"location.event.vacation", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Vacation", @"Vacation");
    }
    else if([[event uppercaseString] rangeOfString:EVENT_SLEEP].location != NSNotFound) {
        localizedEventString = NSLocalizedStringWithDefaultValue(@"location.event.sleep", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Sleep", @"Sleep");
    }
    else if([[event uppercaseString] rangeOfString:EVENT_TEST].location != NSNotFound) {
        localizedEventString = NSLocalizedStringWithDefaultValue(@"location.event.test", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Test", @"Test");
    }
    else if([[event uppercaseString] rangeOfString:EVENT_STAY].location != NSNotFound) {
        localizedEventString = NSLocalizedStringWithDefaultValue(@"location.event.stay", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Stay", @"Stay");
    }
    else {
        // In the case of a translation failure, default to "Home" mode.
        localizedEventString = NSLocalizedStringWithDefaultValue(@"location.event.home", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Home", @"Home");
    }
    
    return localizedEventString;
}

+ (NSString *)nonLocalizedEventString:(NSString *)event {
    NSString *nonLocalizedEventString = event;
    if([[event uppercaseString] rangeOfString:[NSLocalizedStringWithDefaultValue(@"location.event.home", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Home", @"Home") uppercaseString]].location != NSNotFound) {
        nonLocalizedEventString = EVENT_HOME;
    }
    else if([[event uppercaseString] rangeOfString:[NSLocalizedStringWithDefaultValue(@"location.event.away", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Away", @"Away") uppercaseString]].location != NSNotFound) {
        nonLocalizedEventString = EVENT_AWAY;
    }
    else if([[event uppercaseString] rangeOfString:[NSLocalizedStringWithDefaultValue(@"location.event.vacation", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Vacation", @"Vacation") uppercaseString]].location != NSNotFound) {
        nonLocalizedEventString = EVENT_VACATION;
    }
    else if([[event uppercaseString] rangeOfString:[NSLocalizedStringWithDefaultValue(@"location.event.sleep", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Sleep", @"Sleep") uppercaseString]].location != NSNotFound) {
        nonLocalizedEventString = EVENT_SLEEP;
    }
    else if([[event uppercaseString] rangeOfString:[NSLocalizedStringWithDefaultValue(@"location.event.test", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Test", @"Test") uppercaseString]].location != NSNotFound) {
        nonLocalizedEventString = EVENT_TEST;
    }
    else if([[event uppercaseString] rangeOfString:[NSLocalizedStringWithDefaultValue(@"location.event.stay", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Stay", @"Stay") uppercaseString]].location != NSNotFound) {
        nonLocalizedEventString = EVENT_STAY;
    }
    
    return nonLocalizedEventString;
}

+ (NSArray *)availableEvents {
    PPLocationSceneEvent *homeEvent = [[PPLocationSceneEvent alloc] initWithEvent:EVENT_HOME date:nil dateMS:-1 sourceType:PPLocationSceneEventSourceTypeNone sourceAgent:nil selected:NO comment:nil];
    PPLocationSceneEvent *awayEvent = [[PPLocationSceneEvent alloc] initWithEvent:EVENT_AWAY date:nil dateMS:-1 sourceType:PPLocationSceneEventSourceTypeNone sourceAgent:nil selected:NO comment:nil];
    PPLocationSceneEvent *vacationEvent = [[PPLocationSceneEvent alloc] initWithEvent:EVENT_VACATION date:nil dateMS:-1 sourceType:PPLocationSceneEventSourceTypeNone sourceAgent:nil selected:NO comment:nil];
    PPLocationSceneEvent *sleepEvent = [[PPLocationSceneEvent alloc] initWithEvent:EVENT_SLEEP date:nil dateMS:-1 sourceType:PPLocationSceneEventSourceTypeNone sourceAgent:nil selected:NO comment:nil];
    PPLocationSceneEvent *stayEvent = [[PPLocationSceneEvent alloc] initWithEvent:EVENT_STAY date:nil dateMS:-1 sourceType:PPLocationSceneEventSourceTypeNone sourceAgent:nil selected:NO comment:nil];
    PPLocationSceneEvent *testEvent = [[PPLocationSceneEvent alloc] initWithEvent:EVENT_TEST date:nil dateMS:-1 sourceType:PPLocationSceneEventSourceTypeNone sourceAgent:nil selected:NO comment:nil];
    
    return @[homeEvent, awayEvent, vacationEvent, sleepEvent, stayEvent, testEvent];
}

#pragma mark - Encoding

- (id)copyWithZone:(NSZone *)zone {
    PPLocationSceneEvent *sceneEvent = [[PPLocationSceneEvent allocWithZone:zone] init];
    
    sceneEvent.event = [self.event copyWithZone:zone];
    sceneEvent.date = [self.date copyWithZone:zone];
    sceneEvent.sourceType = self.sourceType;
    sceneEvent.sourceAgent = [self.sourceAgent copyWithZone:zone];
    sceneEvent.selected = self.selected;
    sceneEvent.comment = self.comment;
    
    return sceneEvent;
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if(self) {
        self.event = [decoder decodeObjectForKey:@"event"];
        self.date = [decoder decodeObjectForKey:@"date"];
        self.sourceType = (PPLocationSceneEventSourceType)((NSNumber *)[decoder decodeObjectForKey:@"sourceType"]).integerValue;
        self.sourceAgent = [decoder decodeObjectForKey:@"sourceAgent"];
        self.selected = (BOOL)((NSNumber *)[decoder decodeObjectForKey:@"selected"]).integerValue;
        self.comment = [decoder decodeObjectForKey:@"comment"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_event forKey:@"event"];
    [encoder encodeObject:_date forKey:@"date"];
    [encoder encodeObject:@(_sourceType) forKey:@"sourceType"];
    [encoder encodeObject:_sourceAgent forKey:@"sourceAgent"];
    [encoder encodeObject:@(_selected) forKey:@"selected"];
    [encoder encodeObject:_comment forKey:@"comment"];
}


@end
