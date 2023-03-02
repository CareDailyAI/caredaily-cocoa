//
//  PPDeviceTypeDeviceModelCategory.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPDeviceTypeDeviceModelCategory.h"
#import "PPDeviceTypeStory.h"

@implementation PPDeviceTypeDeviceModelCategory

+ (NSString *)primaryKey {
    return @"categoryId";
}

- (id)initWithId:(NSString *)categoryId parentId:(NSString *)parentId brands:(RLMArray *)brands icon:(NSString *)icon search:(RLMArray *)search hidden:(PPDeviceTypeDeviceModelHidden)hidden sortId:(PPDeviceTypeDeviceModelSortId)sortId name:(PPDeviceTypeDeviceModelCategoryName *)name stories:(RLMArray *)stories models:(RLMArray *)models {
    self = [super init];
    if(self) {
        self.categoryId = categoryId;
        self.parentId = parentId;
        self.brands = (RLMArray<PPDeviceTypeDeviceModelBrand *><PPDeviceTypeDeviceModelBrand> *)brands;
        self.icon = icon;
        self.search = (RLMArray<RLMString> *)search;
        self.hidden = hidden;
        self.sortId = sortId;
        self.name = name;
        self.stories = (RLMArray<PPDeviceTypeStory *><PPDeviceTypeStory> *)stories;
        self.models = (RLMArray<PPDeviceTypeDeviceModel *><PPDeviceTypeDeviceModel> *)models;
    }
    return self;
}

+ (PPDeviceTypeDeviceModelCategory *)initWithDictionary:(NSDictionary *)categoryDict {
    NSString *categoryId = [categoryDict objectForKey:@"id"];
    NSString *parentId = [categoryDict objectForKey:@"parentId"];
    
    NSMutableArray *brands;
    if([categoryDict objectForKey:@"brands"]) {
        brands = [[NSMutableArray alloc] initWithCapacity:0];
        for(NSDictionary *brandDict in [categoryDict objectForKey:@"brands"]) {
            PPDeviceTypeDeviceModelBrand *brand = [PPDeviceTypeDeviceModelBrand initWithDictionary:brandDict];
            [brands addObject:brand];
        }
    }
    
    NSString *icon = [categoryDict objectForKey:@"icon"];
    NSArray *search = [((NSString *)[categoryDict objectForKey:@"search"]) componentsSeparatedByString:@","];
    PPDeviceTypeDeviceModelHidden hidden = PPDeviceTypeDeviceModelHiddenNone;
    if([categoryDict objectForKey:@"hidden"]) {
        hidden = (PPDeviceTypeDeviceModelHidden)((NSString *)[categoryDict objectForKey:@"hidden"]).integerValue;
    }
    PPDeviceTypeDeviceModelSortId sortId = PPDeviceTypeDeviceModelSortIdNone;
    if([categoryDict objectForKey:@"sortId"]) {
        sortId = (PPDeviceTypeDeviceModelSortId)((NSString *)[categoryDict objectForKey:@"sortId"]).integerValue;
    }

    PPDeviceTypeDeviceModelCategoryName *name = [PPDeviceTypeDeviceModelCategoryName initWithDictionary:[categoryDict objectForKey:@"name"]];
    
    NSMutableArray *stories;
    if([categoryDict objectForKey:@"stories"]) {
        stories = [[NSMutableArray alloc] initWithCapacity:0];
        for(NSDictionary *storyDict in [categoryDict objectForKey:@"stories"]) {
            PPDeviceTypeStory *story = [PPDeviceTypeStory initWithDictionary:storyDict];
            [stories addObject:story];
        }
    }
    
    NSMutableArray *models;
    if([categoryDict objectForKey:@"models"]) {
        models = [[NSMutableArray alloc] initWithCapacity:0];
        for(NSDictionary *modelDict in [categoryDict objectForKey:@"models"]) {
            PPDeviceTypeDeviceModel *model = [PPDeviceTypeDeviceModel initWithDictionary:modelDict];
            [models addObject:model];
        }
    }
    PPDeviceTypeDeviceModelCategory *category = [[PPDeviceTypeDeviceModelCategory alloc] initWithId:categoryId parentId:parentId brands:(RLMArray<PPDeviceTypeDeviceModelBrand *><PPDeviceTypeDeviceModelBrand> *)brands icon:icon search:(RLMArray<RLMString> *)search hidden:hidden sortId:sortId name:name stories:(RLMArray<PPDeviceTypeStory *><PPDeviceTypeStory> *)stories models:(RLMArray<PPDeviceTypeDeviceModel *><PPDeviceTypeDeviceModel> *)models];
    return category;
}

+ (NSString *)stringify:(PPDeviceTypeDeviceModelCategory *)category {
    
    NSMutableString *JSONString=[[NSMutableString alloc] init];
    [JSONString appendString:@"{"];
    
    BOOL appendComma = NO;
    
    
    if(category.categoryId) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"id\":\"%@\"", category.categoryId];
        appendComma = YES;
    }
    
    if(category.parentId) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"parentId\":\"%@\"", category.parentId];
        appendComma = YES;
    }
    
    if([category.brands count] > 0) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendString:@"\"brands\":["];
        
        BOOL appendBrandComma = NO;
        for(PPDeviceTypeDeviceModelBrand *brand in category.brands) {
            if(appendBrandComma) {
                [JSONString appendString:@","];
            }
            [JSONString appendString:[PPDeviceTypeDeviceModelBrand stringify:brand]];
            appendBrandComma = YES;
        }
        [JSONString appendString:@"]"];
        appendComma = YES;
    }
    
    if(category.icon) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"icon\":\"%@\"", category.icon];
        appendComma = YES;
    }
    
    if([category.search count]) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"search\": [%@]", [PPRLMArray stringArray:category.search componentsJoinedByString:@","]];
        appendComma = YES;
    }
    
    if(category.hidden != PPDeviceTypeDeviceModelHiddenNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"hidden\":%li", (long)category.hidden];
        appendComma = YES;
    }
    
    if(category.sortId != PPDeviceTypeDeviceModelSortIdNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"sortId\":%li", (long)category.sortId];
        appendComma = YES;
    }
    
    if(category.name) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"name\": {%@}", [PPDeviceTypeDeviceModelCategoryName stringify:category.name]];
        appendComma = YES;
    }
    
    [JSONString appendString:@"}"];
    return JSONString;
}

#pragma mark - Helper Methods

- (BOOL)isEqualToCategory:(PPDeviceTypeDeviceModelCategory *)category {
    BOOL equal = NO;
    
    if(category.categoryId && _categoryId) {
        if([category.categoryId isEqualToString:_categoryId]) {
            equal = YES;
        }
    }
    
    return equal;
}

- (void)sync:(PPDeviceTypeDeviceModelCategory *)category {
    if(category.categoryId) {
        _categoryId = category.categoryId;
    }
    if(category.parentId) {
        _parentId = category.parentId;
    }
    if(category.brands) {
        _brands = category.brands;
    }
    if(category.icon) {
        _icon = category.icon;
    }
    if(category.search) {
        _search = category.search;
    }
    if(category.hidden != PPDeviceTypeDeviceModelHiddenTrue) {
        _hidden = category.hidden;
    }
    if(category.sortId != PPDeviceTypeDeviceModelSortIdNone) {
        _sortId = category.sortId;
    }
    if(category.name) {
        _name = category.name;
    }
    if(category.stories) {
        _stories = category.stories;
    }
    if(category.models) {
        _models = category.models;
    }
}


@end

@implementation PPDeviceTypeDeviceModelCategoryName

+ (PPDeviceTypeDeviceModelCategoryName *)initWithDictionary:(NSDictionary *)dict {
    PPRLMDictionary *RLMDictionary = [super initWithDictionary:dict];
    return [[PPDeviceTypeDeviceModelCategoryName alloc] initWithKeys:RLMDictionary.keys value:RLMDictionary.values];
}

@end
