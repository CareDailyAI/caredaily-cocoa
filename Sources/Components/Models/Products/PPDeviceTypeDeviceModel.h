//
//  PPDeviceTypeDeviceModel.h
//  Peoplepower
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

@class PPDeviceTypeDeviceModelManufacture;
RLM_ARRAY_TYPE(PPDeviceTypeDeviceModelManufacture);

@class PPDeviceTypeDeviceModelName;
RLM_ARRAY_TYPE(PPDeviceTypeDeviceModelName);

@class PPDeviceTypeDeviceModelDesc;
RLM_ARRAY_TYPE(PPDeviceTypeDeviceModelDesc);

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

@interface PPDeviceTypeDeviceModel : RLMObject

@property (nonatomic, strong) NSString *modelId;
@property (nonatomic, strong) RLMArray<PPDeviceTypeDeviceModelBrand *><PPDeviceTypeDeviceModelBrand> *brands;
@property (nonatomic, strong) PPDeviceTypeDeviceModelManufacture *manufacturer;
@property (nonatomic) PPDeviceTypeDeviceModelPairingType pairingType;
@property (nonatomic) PPCloudsIntegrationClientApplicationId OAuthAppId;
@property (nonatomic, strong) RLMArray<RLMInt> *dependencyDeviceTypes;
@property (nonatomic) PPDeviceTypeDeviceModelHidden hidden;
@property (nonatomic) PPDeviceTypeDeviceModelSortId sortId;
@property (nonatomic, strong) PPDeviceTypeDeviceModelName *name;
@property (nonatomic, strong) PPDeviceTypeDeviceModelDesc *desc;
@property (nonatomic, strong) RLMArray<PPDeviceTypeDeviceModelLookupParam *><PPDeviceTypeDeviceModelLookupParam> *lookupParams;
@property (nonatomic, strong) NSString *modelTemplate;
@property (nonatomic, strong) RLMArray<PPDeviceTypeMedia *><PPDeviceTypeMedia> *media;
@property (nonatomic, strong) PPDeviceTypeParameterDisplayInfo *displayInfo;

- (id)initWithModelId:(NSString *)modelId brands:(RLMArray *)brands manufacturer:(PPDeviceTypeDeviceModelManufacture *)manufacturer pairingType:(PPDeviceTypeDeviceModelPairingType)pairingType OAuthAppId:(PPCloudsIntegrationClientApplicationId)OAuthAppId dependencyDeviceTypes:(RLMArray *)dependencyDeviceTypes hidden:(PPDeviceTypeDeviceModelHidden)hidden sortId:(PPDeviceTypeDeviceModelSortId)sortId name:(PPDeviceTypeDeviceModelName *)name desc:(PPDeviceTypeDeviceModelDesc *)desc lookupParams:(RLMArray *)lookupParams modelTemplate:(NSString *)modelTemplate media:(RLMArray *)media displayInfo:(PPDeviceTypeParameterDisplayInfo *)displayInfo;

+ (PPDeviceTypeDeviceModel *)initWithDictionary:(NSDictionary *)modelDict;

+ (NSString *)stringify:(PPDeviceTypeDeviceModel *)model;

@end

RLM_ARRAY_TYPE(PPDeviceTypeDeviceModel)

@interface PPDeviceTypeDeviceModelManufacture : PPRLMDictionary
+ (PPDeviceTypeDeviceModelManufacture *)initWithDictionary:(NSDictionary *)dict;
@end

@interface PPDeviceTypeDeviceModelName : PPRLMDictionary
+ (PPDeviceTypeDeviceModelName *)initWithDictionary:(NSDictionary *)dict;
@end

@interface PPDeviceTypeDeviceModelDesc : PPRLMDictionary
+ (PPDeviceTypeDeviceModelDesc *)initWithDictionary:(NSDictionary *)dict;
@end

