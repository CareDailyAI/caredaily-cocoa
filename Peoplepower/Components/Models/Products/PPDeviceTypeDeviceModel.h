//
//  PPDeviceTypeDeviceModel.h
//  PPiOSCore
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//
// Supported device models and categories.
// Data is returned for one brand only. If the brand parameter is not set, data for the default brand is returned.
// Categories can be organizaed in hierarchies.
//

#import "PPBaseModel.h"
#import "PPCloudsIntegrationClient.h"
#import "PPDeviceTypeMedia.h"
#import "PPDeviceTypeDeviceModelBrand.h"
#import "PPDeviceTypeDeviceModelLookupParam.h"

typedef NS_OPTIONS(NSInteger, PPDeviceTypeDeviceModelPairingType) {
    PPDeviceTypeDeviceModelPairingTypeNone = -1,
    PPDeviceTypeDeviceModelPairingTypeQR = 1,
    PPDeviceTypeDeviceModelPairingTypeNative = 2,
    PPDeviceTypeDeviceModelPairingTypeOAuth = 4,
    PPDeviceTypeDeviceModelPairingTypeZigBee = 8,
    PPDeviceTypeDeviceModelPairingTypeWiFi = 16,
    PPDeviceTypeDeviceModelPairingTypeGenerateQR = 32
};

typedef NS_OPTIONS(NSInteger, PPDeviceTypeDeviceModelHidden) {
    PPDeviceTypeDeviceModelHiddenNone = -1,
    PPDeviceTypeDeviceModelHiddenFalse = 0,
    PPDeviceTypeDeviceModelHiddenTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceTypeDeviceModelSortId) {
    PPDeviceTypeDeviceModelSortIdNone = -1,
};

@interface PPDeviceTypeDeviceModel : NSObject

@property (nonatomic, strong) NSString *modelId;
@property (nonatomic, strong) NSArray *brands;
@property (nonatomic, strong) NSDictionary *manufacturer;
@property (nonatomic) PPDeviceTypeDeviceModelPairingType pairingType;
@property (nonatomic) PPCloudsIntegrationClientApplicationId OAuthAppId;
@property (nonatomic, strong) NSArray *dependencyDeviceTypes;
@property (nonatomic) PPDeviceTypeDeviceModelHidden hidden;
@property (nonatomic) PPDeviceTypeDeviceModelSortId sortId;
@property (nonatomic, strong) NSDictionary *name;
@property (nonatomic, strong) NSDictionary *desc;
@property (nonatomic, strong) NSArray *lookupParams;
@property (nonatomic, strong) NSString *modelTemplate;
@property (nonatomic, strong) NSArray *media;
@property (nonatomic, strong) PPDeviceTypeParameterDisplayInfo *displayInfo;

- (id)initWithModelId:(NSString *)modelId brands:(NSArray *)brands manufacturer:(NSDictionary *)manufacturer pairingType:(PPDeviceTypeDeviceModelPairingType)pairingType OAuthAppId:(PPCloudsIntegrationClientApplicationId)OAuthAppId dependencyDeviceTypes:(NSArray *)dependencyDeviceTypes hidden:(PPDeviceTypeDeviceModelHidden)hidden sortId:(PPDeviceTypeDeviceModelSortId)sortId name:(NSDictionary *)name desc:(NSDictionary *)desc lookupParams:(NSArray *)lookupParams modelTemplate:(NSString *)modelTemplate media:(NSArray *)media displayInfo:(PPDeviceTypeParameterDisplayInfo *)displayInfo;

+ (PPDeviceTypeDeviceModel *)initWithDictionary:(NSDictionary *)modelDict;

+ (NSString *)stringify:(PPDeviceTypeDeviceModel *)model;

@end

