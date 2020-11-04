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
@class PPDeviceTypeDeviceModelName;
@class PPDeviceTypeDeviceModelDesc;

typedef NS_OPTIONS(NSInteger, PPDeviceTypeDeviceModelPairingType) {
    PPDeviceTypeDeviceModelPairingTypeNone = -1,
    PPDeviceTypeDeviceModelPairingTypeQR = 1,
    PPDeviceTypeDeviceModelPairingTypeNative = 2,
    PPDeviceTypeDeviceModelPairingTypeOAuth = 4,
    PPDeviceTypeDeviceModelPairingTypeZigBee = 8,
    PPDeviceTypeDeviceModelPairingTypeWiFi = 16,
    PPDeviceTypeDeviceModelPairingTypeGenerateQR = 32,
    PPDeviceTypeDeviceModelPairingTypeBluetooth = 64,
};

typedef NS_OPTIONS(NSInteger, PPDeviceTypeDeviceModelHidden) {
    PPDeviceTypeDeviceModelHiddenNone = -1,
    PPDeviceTypeDeviceModelHiddenFalse = 0,
    PPDeviceTypeDeviceModelHiddenTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceTypeDeviceModelSortId) {
    PPDeviceTypeDeviceModelSortIdNone = -1,
};

@interface PPDeviceTypeDeviceModel : PPBaseModel

@property (nonatomic, strong) NSString *_Nonnull modelId;
@property (nonatomic, strong) RLMArray<PPDeviceTypeDeviceModelBrand *><PPDeviceTypeDeviceModelBrand> *_Nullable brands;
@property (nonatomic, strong) PPDeviceTypeDeviceModelManufacture *_Nullable manufacturer;
@property (nonatomic) PPDeviceTypeDeviceModelPairingType pairingType;
@property (nonatomic) PPCloudsIntegrationClientApplicationId OAuthAppId;
@property (nonatomic, strong) RLMArray<RLMInt> * _Nullable dependencyDeviceTypes;
@property (nonatomic) PPDeviceTypeDeviceModelHidden hidden;
@property (nonatomic) PPDeviceTypeDeviceModelSortId sortId;
@property (nonatomic, strong) PPDeviceTypeDeviceModelName * _Nonnull name;
@property (nonatomic, strong) PPDeviceTypeDeviceModelDesc * _Nonnull desc;
@property (nonatomic, strong) RLMArray<PPDeviceTypeDeviceModelLookupParam *><PPDeviceTypeDeviceModelLookupParam> * _Nullable lookupParams;
@property (nonatomic, strong) NSString * _Nullable modelTemplate;
@property (nonatomic, strong) RLMArray<PPDeviceTypeMedia *><PPDeviceTypeMedia> * _Nullable media;
@property (nonatomic, strong) PPDeviceTypeParameterDisplayInfo * _Nullable displayInfo;

- (id _Nonnull )initWithModelId:(NSString * _Nonnull )modelId
               brands:(RLMArray * _Nullable )brands
         manufacturer:(PPDeviceTypeDeviceModelManufacture * _Nullable )manufacturer
          pairingType:(PPDeviceTypeDeviceModelPairingType)pairingType
           OAuthAppId:(PPCloudsIntegrationClientApplicationId)OAuthAppId
dependencyDeviceTypes:(RLMArray * _Nullable )dependencyDeviceTypes
               hidden:(PPDeviceTypeDeviceModelHidden)hidden
               sortId:(PPDeviceTypeDeviceModelSortId)sortId
                 name:(PPDeviceTypeDeviceModelName * _Nonnull )name
                 desc:(PPDeviceTypeDeviceModelDesc * _Nonnull )desc
         lookupParams:(RLMArray * _Nullable )lookupParams
        modelTemplate:(NSString * _Nullable )modelTemplate
                media:(RLMArray * _Nullable )media
          displayInfo:(PPDeviceTypeParameterDisplayInfo * _Nullable )displayInfo;

+ (PPDeviceTypeDeviceModel * _Nonnull )initWithDictionary:(NSDictionary * _Nonnull )modelDict;

+ (NSString * _Nonnull )stringify:(PPDeviceTypeDeviceModel * _Nonnull )model;

@end

@interface PPDeviceTypeDeviceModelManufacture : PPRLMDictionary
+ (PPDeviceTypeDeviceModelManufacture * _Nonnull )initWithDictionary:(NSDictionary * _Nonnull )dict;
@end

@interface PPDeviceTypeDeviceModelName : PPRLMDictionary
+ (PPDeviceTypeDeviceModelName * _Nonnull )initWithDictionary:(NSDictionary * _Nonnull )dict;
@end

@interface PPDeviceTypeDeviceModelDesc : PPRLMDictionary
+ (PPDeviceTypeDeviceModelDesc * _Nonnull )initWithDictionary:(NSDictionary * _Nonnull )dict;
@end

