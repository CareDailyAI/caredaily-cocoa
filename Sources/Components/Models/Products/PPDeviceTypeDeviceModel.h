//
//  PPDeviceTypeDeviceModel.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2023 People Power Company. All rights reserved.
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

@interface PPDeviceTypeDeviceModel : PPBaseModel

@property (nonatomic, strong) NSString * _Nonnull modelId;
@property (nonatomic, strong) NSArray * _Nullable brands;
@property (nonatomic, strong) NSDictionary * _Nullable manufacturer;
@property (nonatomic) PPDeviceTypeDeviceModelPairingType pairingType;
@property (nonatomic) PPCloudsIntegrationClientApplicationId OAuthAppId;
@property (nonatomic, strong) NSArray * _Nullable dependencyDeviceTypes;
@property (nonatomic) PPDeviceTypeDeviceModelHidden hidden;
@property (nonatomic) PPDeviceTypeDeviceModelSortId sortId;
@property (nonatomic, strong) NSDictionary * _Nonnull name;
@property (nonatomic, strong) NSDictionary * _Nonnull desc;
@property (nonatomic, strong) NSArray * _Nullable lookupParams;
@property (nonatomic, strong) NSString * _Nullable modelTemplate;
@property (nonatomic, strong) NSArray * _Nullable media;
@property (nonatomic, strong) PPDeviceTypeParameterDisplayInfo * _Nullable displayInfo;

- (id _Nonnull )initWithModelId:(NSString * _Nonnull )modelId
               brands:(NSArray * _Nullable )brands
         manufacturer:(NSDictionary * _Nullable )manufacturer
          pairingType:(PPDeviceTypeDeviceModelPairingType)pairingType
           OAuthAppId:(PPCloudsIntegrationClientApplicationId)OAuthAppId
dependencyDeviceTypes:(NSArray * _Nullable )dependencyDeviceTypes
               hidden:(PPDeviceTypeDeviceModelHidden)hidden
               sortId:(PPDeviceTypeDeviceModelSortId)sortId
                 name:(NSDictionary * _Nonnull )name
                 desc:(NSDictionary * _Nonnull )desc
         lookupParams:(NSArray * _Nullable )lookupParams
        modelTemplate:(NSString * _Nullable )modelTemplate
                media:(NSArray * _Nullable )media
          displayInfo:(PPDeviceTypeParameterDisplayInfo * _Nullable )displayInfo;

+ (PPDeviceTypeDeviceModel * _Nonnull )initWithDictionary:(NSDictionary * _Nonnull )modelDict;

+ (NSString * _Nonnull )stringify:(PPDeviceTypeDeviceModel * _Nonnull )model;

@end

