//
//  PPDeviceTypeStoryPageAction.m
//  Peoplepower
//
//  Created by Destry Teeter on 6/25/19.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPDeviceTypeStoryPageAction.h"

@implementation PPDeviceTypeStoryPageAction

- (id)initWithIndex:(PPDeviceTypeStoryPageActionIndex)index type:(PPDeviceTypeStoryPageActionType)type style:(PPDeviceTypeStoryPageActionStyle)style storyId:(NSString *)storyId desc:(NSString *)desc {
    return [self initWithIndex:index type:type style:style storyId:storyId url:nil desc:desc];
}

- (id)initWithIndex:(PPDeviceTypeStoryPageActionIndex)index type:(PPDeviceTypeStoryPageActionType)type style:(PPDeviceTypeStoryPageActionStyle)style storyId:(NSString *)storyId url:(NSString *)url desc:(NSString *)desc {
    self = [super init];
    if(self) {
        self.index = index;
        self.type = type;
        self.style = style;
        self.storyId = storyId;
        self.url = url;
        self.desc = desc;
    }
    return self;
}

+ (PPDeviceTypeStoryPageAction *)initWithDictionary:(NSDictionary *)actionDict {
    PPDeviceTypeStoryPageActionIndex index = PPDeviceTypeStoryPageActionIndexActionNone;
    if([actionDict objectForKey:@"index"]) {
        index = (PPDeviceTypeStoryPageActionIndex)((NSString *)[actionDict objectForKey:@"index"]).integerValue;
    }
    
    PPDeviceTypeStoryPageActionType type = PPDeviceTypeStoryPageActionTypeNone;
    if([actionDict objectForKey:@"type"]) {
        type = (PPDeviceTypeStoryPageActionType)((NSString *)[actionDict objectForKey:@"type"]).integerValue;
    }
    PPDeviceTypeStoryPageActionStyle style = PPDeviceTypeStoryPageActionStyleNone;
    if([actionDict objectForKey:@"style"]) {
        style = (PPDeviceTypeStoryPageActionStyle)((NSString *)[actionDict objectForKey:@"style"]).integerValue;
    }
    NSString *storyId = [actionDict objectForKey:@"storyId"];
    NSString *url = [actionDict objectForKey:@"url"];
    NSString *desc = [actionDict objectForKey:@"desc"];
    
    PPDeviceTypeStoryPageAction *action = [[PPDeviceTypeStoryPageAction alloc] initWithIndex:index type:type style:style storyId:storyId url:url desc:desc];
    return action;
}

+ (NSString *)stringify:(PPDeviceTypeStoryPageAction *)action {
    NSMutableString *JSONString = [[NSMutableString alloc] init];
    [JSONString appendString:@"{"];
    
    BOOL appendComma = NO;
    
    
    if(action.index != PPDeviceTypeStoryPageActionIndexActionNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"index\":%li", (long)action.index];
        appendComma = YES;
    }
    
    if(action.type != PPDeviceTypeStoryPageActionTypeNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"type\":%li", (long)action.type];
        appendComma = YES;
    }
    
    if(action.style != PPDeviceTypeStoryPageActionStyleNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"style\":%li", (long)action.style];
        appendComma = YES;
    }
    
    if(action.storyId) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"storyId\":\"%@\"", action.storyId];
        appendComma = YES;
    }
    
    if(action.url) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"url\":\"%@\"", action.url];
        appendComma = YES;
    }
    
    if(action.desc) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"desc\":\"%@\"", action.desc];
        appendComma = YES;
    }
    
    [JSONString appendString:@"}"];
    return JSONString;
}

@end
