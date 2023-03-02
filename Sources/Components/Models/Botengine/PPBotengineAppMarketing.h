//
//  PPBotengineAppMarketing.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/7/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

@interface PPBotengineAppMarketing : PPBaseModel

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *copyright;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *marketingUrl;
@property (nonatomic, strong) NSString *supportUrl;
@property (nonatomic, strong) NSString *videoUrl;
@property (nonatomic, strong) NSString *privacyUrl;
@property (nonatomic, strong) RLMArray<RLMString> *keywords;

+ (PPBotengineAppMarketing *)marketingWithName:(NSString *)name author:(NSString *)author desc:(NSString *)desc;

+ (PPBotengineAppMarketing *)marketingWithName:(NSString *)name author:(NSString *)author copyright:(NSString *)copyright desc:(NSString *)desc marketingUrl:(NSString *)marketingUrl supportUrl:(NSString *)supportUrl videoUrl:(NSString *)videoUrl privacyUrl:(NSString *)privacyUrl;

- (id)initWithName:(NSString *)name author:(NSString *)author copyright:(NSString *)copyright desc:(NSString *)desc marketingUrl:(NSString *)marketingUrl supportUrl:(NSString *)supportUrl videoUrl:(NSString *)videoUrl privacyUrl:(NSString *)privacyUrl keywords:(RLMArray *)keywords;

@end

