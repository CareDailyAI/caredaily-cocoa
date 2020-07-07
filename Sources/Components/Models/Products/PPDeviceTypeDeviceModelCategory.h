//
//  PPDeviceTypeDeviceModelCategory.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPDeviceTypeDeviceModel.h"

@class PPDeviceTypeStory;
@class PPDeviceTypeDeviceModelCategoryName;

@interface PPDeviceTypeDeviceModelCategory : PPBaseModel

@property (nonatomic) NSString *categoryId;
@property (nonatomic) NSString *parentId;
@property (nonatomic, strong) RLMArray<PPDeviceTypeDeviceModelBrand *><PPDeviceTypeDeviceModelBrand> *brands;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) RLMArray<RLMString> *search;
@property (nonatomic) PPDeviceTypeDeviceModelHidden hidden;
@property (nonatomic) PPDeviceTypeDeviceModelSortId sortId;
@property (nonatomic, strong) PPDeviceTypeDeviceModelCategoryName *name;
@property (nonatomic, strong) RLMArray<PPDeviceTypeStory *><PPDeviceTypeStory> *stories;
@property (nonatomic, strong) RLMArray<PPDeviceTypeDeviceModel *><PPDeviceTypeDeviceModel> *models;

- (id)initWithId:(NSString *)categoryId parentId:(NSString *)parentId brands:(RLMArray *)brands icon:(NSString *)icon search:(RLMArray *)search hidden:(PPDeviceTypeDeviceModelHidden)hidden sortId:(PPDeviceTypeDeviceModelSortId)sortId name:(PPDeviceTypeDeviceModelCategoryName *)name stories:(RLMArray *)stories models:(RLMArray *)models;

+ (PPDeviceTypeDeviceModelCategory *)initWithDictionary:(NSDictionary *)categoryDict;

+ (NSString *)stringify:(PPDeviceTypeDeviceModelCategory *)category;

#pragma mark - Helper Methods

- (BOOL)isEqualToCategory:(PPDeviceTypeDeviceModelCategory *)category;

- (void)sync:(PPDeviceTypeDeviceModelCategory *)category;

@end

@interface PPDeviceTypeDeviceModelCategoryName : PPRLMDictionary
+ (PPDeviceTypeDeviceModelCategoryName *)initWithDictionary:(NSDictionary *)dict;
@end

