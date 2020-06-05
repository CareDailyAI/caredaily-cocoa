//
//  PPDeviceTypeStory.m
//  PPiOSCore
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPDeviceTypeStory.h"

@implementation PPDeviceTypeStory

- (id)initWithStoryId:(NSString *)storyId models:(NSArray *)models brands:(NSArray *)brands storyType:(PPDeviceTypeStoryType)storyType lang:(NSString *)lang title:(NSString *)title search:(NSArray *)search sortId:(PPDeviceTypeStorySortId)sortId pages:(NSArray *)pages {
    self = [super init];
    if(self) {
        self.storyId = storyId;
        self.models = models;
        self.brands = brands;
        self.storyType = storyType;
        self.lang = lang;
        self.title = title;
        self.search = search;
        self.sortId = sortId;
        self.pages = pages;
    }
    return self;
}

+ (PPDeviceTypeStory *)initWithDictionary:(NSDictionary *)storyDict {
    NSString *storyId = [storyDict objectForKey:@"id"];
    NSMutableArray *models;
    if([storyDict objectForKey:@"models"]) {
        models = [[NSMutableArray alloc] initWithCapacity:0];
        for(NSDictionary *modelDict in [storyDict objectForKey:@"models"]) {
            PPDeviceTypeStoryModel *model = [PPDeviceTypeStoryModel initWithDictionary:modelDict];
            [models addObject:model];
        }
    }
    NSMutableArray *brands;
    if([storyDict objectForKey:@"brands"]) {
        brands = [storyDict objectForKey:@"brands"];
    }
    PPDeviceTypeStoryType storyType = PPDeviceTypeStoryTypeNone;
    if([storyDict objectForKey:@"storyType"]) {
        storyType = (PPDeviceTypeStoryType)((NSString *)[storyDict objectForKey:@"storyType"]).integerValue;
    }
    NSString *lang = [storyDict objectForKey:@"lang"];
    NSString *title = [storyDict objectForKey:@"title"];
    NSArray *search = [((NSString *)[storyDict objectForKey:@"search"]) componentsSeparatedByString:@","];
    PPDeviceTypeStorySortId sortId = PPDeviceTypeStorySortIdNone;
    if([storyDict objectForKey:@"sortId"]) {
        sortId = (PPDeviceTypeStorySortId)((NSString *)[storyDict objectForKey:@"sortId"]).integerValue;
    }
    NSMutableArray *pages;
    if([storyDict objectForKey:@"pages"]) {
        pages = [[NSMutableArray alloc] initWithCapacity:0];
        for(NSDictionary *pageDict in [storyDict objectForKey:@"pages"]) {
            PPDeviceTypeStoryPage *page = [PPDeviceTypeStoryPage initWithDictionary:pageDict];
            [pages addObject:page];
        }
    }
    
    PPDeviceTypeStory *storybook = [[PPDeviceTypeStory alloc] initWithStoryId:storyId models:models brands:brands storyType:storyType lang:lang title:title search:search sortId:sortId pages:pages];
    return storybook;
}

+ (NSString *)stringify:(PPDeviceTypeStory *)story {
    NSMutableString *JSONString = [[NSMutableString alloc] init];
    [JSONString appendString:@"{"];
    
    BOOL appendComma = NO;
    
    
    if(story.storyId) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"id\":\"%@\"", story.storyId];
        appendComma = YES;
    }
    
    if([story.models count] > 0) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendString:@"\"models\":["];
        
        BOOL appendModelComma = NO;
        for(PPDeviceTypeStoryModel *model in story.models) {
            if(appendModelComma) {
                [JSONString appendString:@","];
            }
            [JSONString appendString:[PPDeviceTypeStoryModel stringify:model]];
            appendModelComma = YES;
        }
        [JSONString appendString:@"]"];
        appendComma = YES;
    }
    
    if([story.brands count] > 0) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendString:@"\"brands\":["];
        
        BOOL appendModelComma = NO;
        for(NSString *brand in story.models) {
            if(appendModelComma) {
                [JSONString appendString:@","];
            }
            [JSONString appendFormat:@"\"%@\"", brand];
            appendModelComma = YES;
        }
        [JSONString appendString:@"]"];
        appendComma = YES;
    }
    
    if(story.storyType != PPDeviceTypeStoryTypeNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"storyType\":%li", (long)story.storyType];
        appendComma = YES;
    }
    
    if(story.lang) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"lang\":\"%@\"", story.lang];
        appendComma = YES;
    }
    
    if(story.title) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"title\":\"%@\"", story.title];
        appendComma = YES;
    }
    
    if([story.search count]) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"search\":\"%@\"", [story.search componentsJoinedByString:@","]];
        appendComma = YES;
    }
    
    if(story.sortId != PPDeviceTypeStorySortIdNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"sortId\":%li", (long)story.sortId];
        appendComma = YES;
    }
    
    if(story.pages) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendString:@"\"pages\": ["];
        
        BOOL appendPageComma = NO;
        for(PPDeviceTypeStoryPage *page in story.pages) {
            if(appendPageComma) {
                [JSONString appendString:@","];
            }
            [JSONString appendString:[PPDeviceTypeStoryPage stringify:page]];
            appendPageComma = YES;
        }
        
        [JSONString appendString:@"]"];
        appendComma = YES;
    }
    
    [JSONString appendString:@"}"];
    return JSONString;
}

#pragma mark - Helper methods

- (BOOL)isEqualToStory:(PPDeviceTypeStory *)story {
    BOOL equal = NO;
    
    if(story.storyId && _storyId) {
        if([story.storyId isEqualToString:_storyId]) {
            equal = YES;
        }
    }
    
    return equal;
}

- (void)sync:(PPDeviceTypeStory *)story {
    if(story.storyId) {
        _storyId = story.storyId;
    }
    if(story.models) {
        _models = story.models;
    }
    if(story.brands) {
        _brands = story.brands;
    }
    if(story.storyType != PPDeviceTypeStoryTypeNone) {
        _storyType = story.storyType;
    }
    if(story.lang) {
        _lang = story.lang;
    }
    if(story.title) {
        _title = story.title;
    }
    if(story.search) {
        _search = story.search;
    }
    if(story.sortId != PPDeviceTypeStorySortIdNone) {
        _sortId = story.sortId;
    }
    if(story.pages) {
        _pages = story.pages;
    }
}

@end
