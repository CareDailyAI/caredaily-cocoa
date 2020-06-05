//
//  PPBotengineAppMarketing.h
//  PPiOSCore
//
//  Created by Destry Teeter on 3/7/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

@interface PPBotengineAppMarketing : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *copyright;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *marketingUrl;
@property (nonatomic, strong) NSString *supportUrl;
@property (nonatomic, strong) NSString *videoUrl;
@property (nonatomic, strong) NSString *privacyUrl;
@property (nonatomic, strong) NSArray *keywords;

+ (PPBotengineAppMarketing *)marketingWithName:(NSString *)name author:(NSString *)author desc:(NSString *)desc;

+ (PPBotengineAppMarketing *)marketingWithName:(NSString *)name author:(NSString *)author copyright:(NSString *)copyright desc:(NSString *)desc marketingUrl:(NSString *)marketingUrl supportUrl:(NSString *)supportUrl videoUrl:(NSString *)videoUrl privacyUrl:(NSString *)privacyUrl;

- (id)initWithName:(NSString *)name author:(NSString *)author copyright:(NSString *)copyright desc:(NSString *)desc marketingUrl:(NSString *)marketingUrl supportUrl:(NSString *)supportUrl videoUrl:(NSString *)videoUrl privacyUrl:(NSString *)privacyUrl keywords:(NSArray *)keywords;

@end
