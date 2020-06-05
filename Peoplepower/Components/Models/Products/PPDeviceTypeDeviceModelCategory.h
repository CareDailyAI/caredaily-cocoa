//
//  PPDeviceTypeDeviceModelCategory.h
//  PPiOSCore
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPDeviceTypeDeviceModel.h"

@class PPDeviceTypeStory;

@interface PPDeviceTypeDeviceModelCategory : NSObject

@property (nonatomic) NSString *categoryId;
@property (nonatomic) NSString *parentId;
@property (nonatomic, strong) NSArray *brands;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSArray *search;
@property (nonatomic) PPDeviceTypeDeviceModelHidden hidden;
@property (nonatomic) PPDeviceTypeDeviceModelSortId sortId;
@property (nonatomic, strong) NSDictionary *name;
@property (nonatomic, strong) NSArray *stories;
@property (nonatomic, strong) NSArray *models;

- (id)initWithId:(NSString *)categoryId parentId:(NSString *)parentId brands:(NSArray *)brands icon:(NSString *)icon search:(NSArray *)search hidden:(PPDeviceTypeDeviceModelHidden)hidden sortId:(PPDeviceTypeDeviceModelSortId)sortId name:(NSDictionary *)name stories:(NSArray *)stories models:(NSArray *)models;

+ (PPDeviceTypeDeviceModelCategory *)initWithDictionary:(NSDictionary *)categoryDict;

+ (NSString *)stringify:(PPDeviceTypeDeviceModelCategory *)category;

#pragma mark - Helper Methods

- (BOOL)isEqualToCategory:(PPDeviceTypeDeviceModelCategory *)category;

- (void)sync:(PPDeviceTypeDeviceModelCategory *)category;

@end
