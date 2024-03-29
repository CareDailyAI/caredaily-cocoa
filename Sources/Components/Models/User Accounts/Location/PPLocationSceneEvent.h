//
//  PPLocationSceneEvent.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/7/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

@interface PPLocationSceneEvent : PPBaseModel <NSCopying>

@property (nonatomic, strong) NSString *event;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic) NSInteger dateMS;
@property (nonatomic) PPLocationSceneEventSourceType sourceType;
@property (nonatomic, strong) NSString *sourceAgent;
@property (nonatomic) BOOL selected;
@property (nonatomic, strong) NSString* comment;

@property (nonatomic, strong) NSString *eventId;
@property (nonatomic) NSInteger locationId;

- (id)initWithEvent:(NSString *)event date:(NSDate *)date dateMS:(NSInteger)dateMS sourceType:(PPLocationSceneEventSourceType)sourceType sourceAgent:(NSString *)sourceAgent selected:(BOOL)selected comment:(NSString *)comment;

+ (PPLocationSceneEvent *)initWithDictionary:(NSDictionary *)eventDict;

- (id)iconWithFrame:(id)frame defaultIconColor:(id)defaultIconColor __attribute__((deprecated));

+ (NSString *)localizedEventString:(NSString *)event;
+ (NSString *)nonLocalizedEventString:(NSString *)event;
+ (NSArray *)availableEvents;

@end
