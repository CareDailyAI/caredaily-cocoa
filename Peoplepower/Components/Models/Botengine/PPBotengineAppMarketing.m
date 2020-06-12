//
//  PPBotengineAppMarketing.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/7/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBotengineAppMarketing.h"

@implementation PPBotengineAppMarketing

+ (PPBotengineAppMarketing *)marketingWithName:(NSString *)name author:(NSString *)author desc:(NSString *)desc {
    return [[PPBotengineAppMarketing alloc] initWithName:name author:author copyright:nil desc:desc marketingUrl:nil supportUrl:nil videoUrl:nil privacyUrl:nil keywords:nil];
}

+ (PPBotengineAppMarketing *)marketingWithName:(NSString *)name author:(NSString *)author copyright:(NSString *)copyright desc:(NSString *)desc marketingUrl:(NSString *)marketingUrl supportUrl:(NSString *)supportUrl videoUrl:(NSString *)videoUrl privacyUrl:(NSString *)privacyUrl {
    return [[PPBotengineAppMarketing alloc] initWithName:name author:author copyright:copyright desc:desc marketingUrl:marketingUrl supportUrl:supportUrl videoUrl:videoUrl privacyUrl:privacyUrl keywords:nil];
}

- (id)initWithName:(NSString *)name author:(NSString *)author copyright:(NSString *)copyright desc:(NSString *)desc marketingUrl:(NSString *)marketingUrl supportUrl:(NSString *)supportUrl videoUrl:(NSString *)videoUrl privacyUrl:(NSString *)privacyUrl keywords:(RLMArray *)keywords {
    self = [super init];
    if(self) {
        self.name = name;
        self.author = author;
        self.copyright = copyright;
        self.desc = desc;
        self.marketingUrl = marketingUrl;
        self.supportUrl = supportUrl;
        self.videoUrl = videoUrl;
        self.privacyUrl = privacyUrl;
        self.keywords = (RLMArray<RLMString> *)keywords;
    }
    return self;
}

@end
