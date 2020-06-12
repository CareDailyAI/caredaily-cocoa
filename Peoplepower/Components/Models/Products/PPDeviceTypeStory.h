//
//  PPDeviceTypeStory.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPDeviceTypeStoryPage.h"
#import "PPDeviceTypeStoryModel.h"

typedef NS_OPTIONS(NSInteger, PPDeviceTypeStoryType) {
    PPDeviceTypeStoryTypeNone                               = -1,
    PPDeviceTypeStoryTypeUndefined                          = 0,
    PPDeviceTypeStoryTypeConnectDevice                      = 1, // The initial part of the add device OOBE.
    PPDeviceTypeStoryTypeDeviceConnectionSuccess            = 2, // Displayed when a device successfully connected to the cloud, or the second part of OOBE.
    PPDeviceTypeStoryTypeDeviceConnectionFail               = 3,
    PPDeviceTypeStoryTypeDeviceInstallationHelp             = 4, // How to install your device, it should shows after you’ve done standard wizard.
    PPDeviceTypeStoryTypePaidService                        = 5, // How-to setup and what you've got with paid subscription.
    PPDeviceTypeStoryTypeScenarios                          = 6, // Device goals
    PPDeviceTypeStoryTypePromotions                         = 7, // Marketing information that can shows up in app.
    PPDeviceTypeStoryTypeBundle                             = 8, // Device model bundles (kits)
    PPDeviceTypeStoryTypeBotMicroservies                    = 10, // Bot stories.
    PPDeviceTypeStoryTypeDeviceReconnectionRandomDisconnect = 11, // Troubleshooting if something goes wrong with device connection.
    PPDeviceTypeStoryTypeDeviceReconnectionBattery          = 12, // Troubleshooting if the battery is dead and the device is now disconnected.
    PPDeviceTypeStoryTypeDeviceReconnectionWirelessSignal   = 13, // Troubleshooting if the wireless signal strength was bad and the device is now disconnected.
    PPDeviceTypeStoryTypeOAuthSuccess                       = 20,
    PPDeviceTypeStoryTypeOAuthFailure                       = 21,
    PPDeviceTypeStoryTypeFAQ                                = 30,
    PPDeviceTypeStoryTypeTermsOfService                     = 40,
    PPDeviceTypeStoryTypePrivacyPolicy                      = 41,
    PPDeviceTypeStoryTypeMonitoringService                  = 42,
    PPDeviceTypeStoryTypeCookiePolicy                       = 43,
    PPDeviceTypeStoryTypeMDTAC                              = 44,
    PPDeviceTypeStoryTypeConsentToParticipate               = 45,
    PPDeviceTypeStoryTypeHipaaStatemenet                    = 46,
    PPDeviceTypeStoryTypeAbout                              = 50,
};

typedef NS_OPTIONS(NSInteger, PPDeviceTypeStorySortId) {
    PPDeviceTypeStorySortIdNone = -1,
};

@interface PPDeviceTypeStory : NSArray

@property (nonatomic, strong) NSString *storyId;
@property (nonatomic, strong) NSArray *models;
@property (nonatomic, strong) NSArray *brands;
@property (nonatomic) PPDeviceTypeStoryType storyType;
@property (nonatomic, strong) NSString *lang;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray *search;
@property (nonatomic) PPDeviceTypeStorySortId sortId;
@property (nonatomic, strong) NSArray *pages;

- (id)initWithStoryId:(NSString *)storyId models:(NSArray *)models brands:(NSArray *)brands storyType:(PPDeviceTypeStoryType)storyType lang:(NSString *)lang title:(NSString *)title search:(NSArray *)search sortId:(PPDeviceTypeStorySortId)sortId pages:(NSArray *)pages;

+ (PPDeviceTypeStory *)initWithDictionary:(NSDictionary *)storyDict;

+ (NSString *)stringify:(PPDeviceTypeStory *)story;

#pragma mark - Helper methods

- (BOOL)isEqualToStory:(PPDeviceTypeStory *)story;

- (void)sync:(PPDeviceTypeStory *)story;

@end
