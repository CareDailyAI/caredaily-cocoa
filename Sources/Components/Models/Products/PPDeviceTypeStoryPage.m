//
//  PPDeviceTypeStoryPage.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPDeviceTypeStoryPage.h"

NSString *PPDeviceTypeStoryPageStyleDefault = @"";
NSString *PPDeviceTypeStoryPageStyleInfo = @"info";
NSString *PPDeviceTypeStoryPageStyleConnect = @"connect";
NSString *PPDeviceTypeStoryPageStylePicture = @"picture";
NSString *PPDeviceTypeStoryPageStyleCalibrate = @"calibrate";

@implementation PPDeviceTypeStoryPage

- (id)initWithIndex:(PPDeviceTypeStoryPageIndex)index hidden:(PPDeviceTypeStoryPageHidden)hidden dismissible:(PPDeviceTypeStoryPageDismissible)dismissible subtitle:(NSString *)subtitle desc:(NSString *)desc style:(NSString *)style content:(NSString *)content actions:(RLMArray *)actions media:(RLMArray *)media displayInfo:(PPDeviceTypeParameterDisplayInfo *)displayInfo {
    self = [super init];
    if(self) {
        self.index = index;
        self.hidden = hidden;
        self.dismissible = dismissible;
        self.subtitle = subtitle;
        self.desc = desc;
        self.style = style;
        self.content = content;
        self.actions = (RLMArray<PPDeviceTypeStoryPageAction *><PPDeviceTypeStoryPageAction> *)actions;
        self.media = (RLMArray<PPDeviceTypeMedia *><PPDeviceTypeMedia> *)media;
        self.displayInfo = displayInfo;
    }
    return self;
}

+ (PPDeviceTypeStoryPage *)initWithDictionary:(NSDictionary *)pageDict {
    PPDeviceTypeStoryPageIndex index = PPDeviceTypeStoryPageIndexNone;
    if([pageDict objectForKey:@"index"]) {
        index = (PPDeviceTypeStoryPageIndex)((NSString *)[pageDict objectForKey:@"index"]).integerValue;
    }
    PPDeviceTypeStoryPageHidden hidden = PPDeviceTypeStoryPageHiddenNone;
    if([pageDict objectForKey:@"hidden"]) {
        hidden = (PPDeviceTypeStoryPageHidden)((NSString *)[pageDict objectForKey:@"hidden"]).integerValue;
    }
    PPDeviceTypeStoryPageDismissible dismissible = PPDeviceTypeStoryPageDismissibleNone;
    if([pageDict objectForKey:@"dismissible"]) {
        dismissible = (PPDeviceTypeStoryPageDismissible)((NSString *)[pageDict objectForKey:@"dismissible"]).integerValue;
    }
    NSString *subtitle = [pageDict objectForKey:@"subtitle"];
    NSString *desc = [pageDict objectForKey:@"desc"];
    NSString *style = [pageDict objectForKey:@"style"];
    NSString *content = [pageDict objectForKey:@"content"];
    
    NSMutableArray *actions = [[NSMutableArray alloc] initWithCapacity:0];
    if ([pageDict objectForKey:@"actions"]) {
        for (NSDictionary *actionDict in [pageDict objectForKey:@"actions"]) {
            PPDeviceTypeStoryPageAction *action = [PPDeviceTypeStoryPageAction initWithDictionary:actionDict];
            [actions addObject:action];
        }
    }
    else if ([pageDict objectForKey:@"actionType"]
             || [pageDict objectForKey:@"actionStyle"]
             || [pageDict objectForKey:@"actionStoryId"]
             || [pageDict objectForKey:@"actionDesc"]) {
        PPDeviceTypeStoryPageActionIndex actionIndex = 0;
        PPDeviceTypeStoryPageActionType actionType = PPDeviceTypeStoryPageActionTypeNone;
        if([pageDict objectForKey:@"actionType"]) {
            actionType = (PPDeviceTypeStoryPageActionType)((NSString *)[pageDict objectForKey:@"actionType"]).integerValue;
        }
        PPDeviceTypeStoryPageActionStyle actionStyle = PPDeviceTypeStoryPageActionStyleNone;
        if([pageDict objectForKey:@"actionStyle"]) {
            actionStyle = (PPDeviceTypeStoryPageActionStyle)((NSString *)[pageDict objectForKey:@"actionStyle"]).integerValue;
        }
        NSString *actionStoryId = [pageDict objectForKey:@"actionStoryId"];
        NSString *actionDesc = [pageDict objectForKey:@"actionDesc"];
        
        PPDeviceTypeStoryPageAction *action = [[PPDeviceTypeStoryPageAction alloc] initWithIndex:actionIndex type:actionType style:actionStyle storyId:actionStoryId url:nil desc:actionDesc];
        [actions addObject:action];
    }
    
    NSMutableArray *medias;
    if([pageDict objectForKey:@"media"]) {
        medias = [[NSMutableArray alloc] initWithCapacity:0];
        for(NSDictionary *mediaDict in [pageDict objectForKey:@"media"]) {
            PPDeviceTypeMedia *media = [PPDeviceTypeMedia initWithDictionary:mediaDict];
            [medias addObject:media];
        }
    }
    
    PPDeviceTypeParameterDisplayInfo *displayInfo;
    if([pageDict objectForKey:@"displayInfo"]) {
        displayInfo = [PPDeviceTypeParameterDisplayInfo initWithDictionary:[pageDict objectForKey:@"displayInfo"]];
    }
    
    PPDeviceTypeStoryPage *page = [[PPDeviceTypeStoryPage alloc] initWithIndex:index hidden:hidden dismissible:dismissible subtitle:subtitle desc:desc style:style content:content actions:(RLMArray *)actions media:(RLMArray *)medias displayInfo:displayInfo];
    return page;
}

+ (NSString *)stringify:(PPDeviceTypeStoryPage *)page {
    NSMutableString *JSONString = [[NSMutableString alloc] init];
    [JSONString appendString:@"{"];
    
    BOOL appendComma = NO;
    
    
    if(page.index != PPDeviceTypeStoryPageIndexNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"index\":%li", (long)page.index];
        appendComma = YES;
    }
    
    if(page.hidden != PPDeviceTypeStoryPageHiddenNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"hidden\":%li", (long)page.hidden];
        appendComma = YES;
    }
    
    if(page.hidden != PPDeviceTypeStoryPageDismissibleNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"dismissible\":%li", (long)page.dismissible];
        appendComma = YES;
    }
    
    if(page.subtitle) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"subtitle\":\"%@\"", page.subtitle];
        appendComma = YES;
    }
    
    if(page.desc) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"desc\":\"%@\"", page.desc];
        appendComma = YES;
    }
    
    if(page.style) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"style\":\"%@\"", page.style];
        appendComma = YES;
    }
    
    if(page.content) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"content\":\"%@\"", page.content];
        appendComma = YES;
    }
    
    if(page.actions) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendString:@"\"actions\": ["];
        
        BOOL appendPageComma = NO;
        for(PPDeviceTypeStoryPageAction *action in page.actions) {
            if(appendPageComma) {
                [JSONString appendString:@","];
            }
            [JSONString appendFormat:@"%@", [PPDeviceTypeStoryPageAction stringify:action]];
            appendPageComma = YES;
        }
        
        [JSONString appendString:@"]"];
        appendComma = YES;
    }
    
    if(page.media) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendString:@"\"media\": ["];
        
        BOOL appendPageComma = NO;
        for(PPDeviceTypeMedia *media in page.media) {
            if(appendPageComma) {
                [JSONString appendString:@","];
            }
            [JSONString appendFormat:@"{\"id\":\"%@\"}", media.mediaId];
            appendPageComma = YES;
        }
        
        [JSONString appendString:@"]"];
        appendComma = YES;
    }

    if(page.displayInfo) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"displayInfo\":%@", [PPDeviceTypeParameterDisplayInfo stringify:page.displayInfo]];
        appendComma = YES;
    }
    
    [JSONString appendString:@"}"];
    return JSONString;
}

@end
