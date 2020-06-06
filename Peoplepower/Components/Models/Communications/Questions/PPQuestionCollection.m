//
//  PPQuestionCollection.m
//  PPiOSCore
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPQuestionCollection.h"

@implementation PPQuestionCollection

+ (NSString *)primaryKey {
    return @"name";
}

- (id)initWithName:(NSString *)name
              icon:(NSString *)icon
              desc:(NSString *)desc
             media:(NSString *)media
  mediaContentType:(NSString *)mediaContentType
            weight:(PPQuestionCollectionWeight)weight {
    self = [super init];
    if(self) {
        self.name = name;
        self.icon = icon;
        self.desc = desc;
        self.media = media;
        self.mediaContentType = mediaContentType;
        self.weight = weight;
    }
    return self;
}

+ (PPQuestionCollection *)initWithDictionary:(NSDictionary *)collectionDict {
    
    NSString *name = [collectionDict objectForKey:@"name"];
    NSString *icon = [collectionDict objectForKey:@"icon"];
    NSString *desc = [collectionDict objectForKey:@"description"];
    PPQuestionCollectionWeight weight = PPQuestionCollectionWeightDefault;
    if([collectionDict objectForKey:@"weight"]) {
        weight = (PPQuestionCollectionWeight)((NSString *)[collectionDict objectForKey:@"weight"]).integerValue;
    }
    NSString *media = [collectionDict objectForKey:@"media"];
    NSString *mediaContentType = [collectionDict objectForKey:@"mediaContentType"];
    
    PPQuestionCollection *collection = [[PPQuestionCollection alloc] initWithName:name
                                                                             icon:icon
                                                                             desc:desc
                                                                            media:media
                                                                 mediaContentType:mediaContentType
                                                                           weight:weight];
    return collection;
}

#pragma mark - Helper methods

- (BOOL)isEqualToCollection:(PPQuestionCollection *)collection {
    BOOL equal = NO;
    
    if(collection.name != nil && _name != nil && [collection.name isEqualToString:_name]) {
        equal = YES;
    }
    
    return equal;
}

- (void)sync:(PPQuestionCollection *)collection {
    if(collection.name) {
        _name = collection.name;
    }
    if(collection.icon) {
        _icon = collection.icon;
    }
    if(collection.desc) {
        _desc = collection.desc;
    }
    if(collection.media) {
        _media = collection.media;
    }
    if(collection.mediaContentType) {
        _mediaContentType = collection.mediaContentType;
    }
    if(collection.weight != _weight) {
        _weight = collection.weight;
    }
}

@end
