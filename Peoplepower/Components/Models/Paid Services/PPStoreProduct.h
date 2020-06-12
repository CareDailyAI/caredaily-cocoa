//
//  PPStoreProduct.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/12/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

typedef NS_OPTIONS(NSInteger, PPStoreProductId) {
    PPStoreProductIdNone = -1,
};

typedef NS_OPTIONS(NSInteger, PPStoreProductImageHeight) {
    PPStoreProductImageHeightNone = -1,
};

@interface PPStoreProduct : RLMObject

@property (nonatomic) PPStoreProductId productId;
@property (nonatomic, strong) NSString *thumbnail;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *productLink;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic) PPStoreProductImageHeight imageHeight;

- (id)initWithId:(PPStoreProductId)productId thumbnail:(NSString *)thumbnail name:(NSString *)name desc:(NSString *)desc productLink:(NSString *)productLink imageUrl:(NSString *)imageUrl imageHeight:(PPStoreProductImageHeight)imageHeight;

+ (PPStoreProduct *)initWithDictionary:(NSDictionary *)productDict;

#pragma mark - Helper Methods

- (BOOL)isEqualToProduct:(PPStoreProduct *)product;

- (void)sync:(PPStoreProduct *)product;

@end

RLM_ARRAY_TYPE(PPStoreProduct);
