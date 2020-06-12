//
//  PPStoreProduct.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/12/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPStoreProduct.h"

@implementation PPStoreProduct

+ (NSString *)primaryKey {
    return @"productId";
}

- (id)initWithId:(PPStoreProductId)productId thumbnail:(NSString *)thumbnail name:(NSString *)name desc:(NSString *)desc productLink:(NSString *)productLink imageUrl:(NSString *)imageUrl imageHeight:(PPStoreProductImageHeight)imageHeight {
    self = [super init];
    if(self) {
        self.productId = productId;
        self.thumbnail = thumbnail;
        self.name = name;
        self.desc = desc;
        self.productLink = productLink;
        self.imageUrl = imageUrl;
        self.imageHeight = imageHeight;
    }
    return self;
}

+ (PPStoreProduct *)initWithDictionary:(NSDictionary *)productDict {
    PPStoreProductId productId = PPStoreProductIdNone;
    if([productDict objectForKey:@"id"]) {
        productId = (PPStoreProductId)((NSString *)[productDict objectForKey:@"id"]).integerValue;
    }
    NSString *thumbnail = [productDict objectForKey:@"url"];
    NSString *name = [productDict objectForKey:@"name"];
    NSString *desc = [productDict objectForKey:@"desc"];
    NSString *productLink = [productDict objectForKey:@"productLink"];
    NSString *imageUrl = [productDict objectForKey:@"image"];
    PPStoreProductImageHeight imageHeight = (PPStoreProductImageHeight)((NSString *)[productDict objectForKey:@"imageHeight"]).integerValue;
    
    PPStoreProduct *product = [[PPStoreProduct alloc] initWithId:productId thumbnail:thumbnail name:name desc:desc productLink:productLink imageUrl:imageUrl imageHeight:imageHeight];
    return product;
}

#pragma mark - Helper methods

- (BOOL)isEqualToProduct:(PPStoreProduct *)product {
    BOOL equal = NO;
    
    if(product.productId != PPStoreProductIdNone && _productId != PPStoreProductIdNone) {
        if(product.productId == _productId) {
            equal = YES;
        }
    }
    
    return equal;
}

- (void)sync:(PPStoreProduct *)product {
    if(product.productId != PPStoreProductIdNone) {
        _productId = product.productId;
    }
    if(product.thumbnail) {
        _thumbnail = product.thumbnail;
    }
    if(product.name) {
        _name = product.name;
    }
    if(product.desc) {
        _desc = product.desc;
    }
    if(product.productLink) {
        _productLink = product.productLink;
    }
    if(product.imageUrl) {
        _imageUrl = product.imageUrl;
    }
    if(product.imageHeight != PPStoreProductImageHeightNone) {
        _imageHeight = product.imageHeight;
    }
}

@end
