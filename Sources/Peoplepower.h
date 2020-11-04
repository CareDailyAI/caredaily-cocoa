//
//  Peoplepower.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/6/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import <Foundation/Foundation.h>

//! Project version number for PeoplepowerUI.
FOUNDATION_EXPORT double PeoplepowerVersionNumber;

//! Project version string for PeoplepowerUI.
FOUNDATION_EXPORT const unsigned char PeoplepowerVersionString[];

#pragma mark - Classes -

#import <Peoplepower/PPTypeDefinitions.h>
#import <Peoplepower/PPNetworkUtilities.h>
#import <Peoplepower/PPDateUtilities.h>
#import <Peoplepower/PPAppResources.h>
#import <Peoplepower/PPStorage.h>
#import <Peoplepower/PPRealm.h>
#import <Peoplepower/PPRealmTypes.h>

#pragma mark - Dependencies -

#pragma mark PPCurlDebug

#import <Peoplepower/PPCurlDebug.h>

#pragma mark - Models -

#import <Peoplepower/PPBaseModel.h>

#pragma mark Cloud Connectivity

#import <Peoplepower/PPCloudConnectivity.h>

#pragma mark Login and Logout

#import <Peoplepower/PPLogin.h>
#import <Peoplepower/PPLogout.h>
#import <Peoplepower/PPOperationTokenManagement.h>

#pragma mark User Accounts

#import <Peoplepower/PPUserAccounts.h>
#import <Peoplepower/PPUserAnalytics.h>

#pragma mark Devices

#import <Peoplepower/PPDevices.h>
#if !TARGET_OS_WATCH
#import <Peoplepower/PPDeviceProxy.h>
#endif
#pragma mark Device Measurements

#import <Peoplepower/PPDeviceMeasurements.h>
#import <Peoplepower/PPDeviceParameters.h>

#pragma mark Communications

#import <Peoplepower/PPNotifications.h>
#import <Peoplepower/PPCrowdFeedbacks.h>
#import <Peoplepower/PPInAppMessaging.h>
#import <Peoplepower/PPQuestions.h>
#import <Peoplepower/PPSMSGroupTexting.h>
#import <Peoplepower/PPSurveys.h>

#pragma mark System and User Properties

#import <Peoplepower/PPSystemAndUserProperties.h>

#pragma mark File Management

#import <Peoplepower/PPFileManagement.h>

#pragma mark Application Files

#import <Peoplepower/PPApplicationFileManagement.h>

#pragma mark Rules

#import <Peoplepower/PPRules.h>

#pragma mark Paid Services

#import <Peoplepower/PPPaidServices.h>

#pragma mark Professional Monitoring

#import <Peoplepower/PPProfessionalMonitoring.h>

#pragma mark Dynamic User Interfaces

#import <Peoplepower/PPDynamicUIs.h>

#pragma mark Energy Management

#import <Peoplepower/PPEnergyManagement.h>

#pragma mark Weather

#import <Peoplepower/PPWeatherManagement.h>

#pragma mark Products

#import <Peoplepower/PPDeviceTypes.h>

#pragma mark Clouds Integration

#import <Peoplepower/PPCloudsIntegration.h>

#pragma mark Community

#import <Peoplepower/PPCommunity.h>

#pragma mark Friends

#import <Peoplepower/PPFriends.h>

#pragma mark Circles

#import <Peoplepower/PPCircles.h>

#pragma mark Reports

#import <Peoplepower/PPReports.h>

#pragma mark Botengine

#import <Peoplepower/PPBotengine.h>

#pragma mark Organization

#import <Peoplepower/PPOrganizations.h>

#pragma mark Networking

#import <AFNetworking/AFHTTPSessionManager.h>
#import <AFNetworking/AFURLSessionManager.h>
#import <AFNetworking/AFCompatibilityMacros.h>
#if !TARGET_OS_WATCH
#import <AFNetworking/AFNetworkReachabilityManager.h>
#endif
#import <AFNetworking/AFSecurityPolicy.h>
#import <AFNetworking/AFURLRequestSerialization.h>
#import <AFNetworking/AFURLResponseSerialization.h>
#import <Peoplepower/PPUrl.h>
#import <Peoplepower/PPCloudEngine.h>
#import <Peoplepower/PPVersion.h>

#pragma mark - Categories -

#import <Peoplepower/PPNSString.h>
#import <Peoplepower/PPNSDate.h>
#import <Peoplepower/PPNSData.h>
#import <Peoplepower/RLMObject+PPExtras.h>
#import <Peoplepower/RLMRealm+PPExtras.h>
#import <Peoplepower/PPRLMArray.h>
#import <Peoplepower/PPRLMDictionary.h>
