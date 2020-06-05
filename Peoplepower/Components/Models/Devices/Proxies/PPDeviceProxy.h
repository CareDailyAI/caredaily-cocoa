//
//  PPDeviceProxy.h
//  Peoplepower
//
//  Copyright (c) 2020 People Power. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPLocation.h"
//#import "PPDeviceMeasurements.h"
#import "PPUser.h"
#import "PPFile.h"
#import "PPDevices.h"
#import "PPCloudConnectivityServer.h"
#import "PPDeviceProxyLocal.h"
#import "PPDeviceProxyLocalCamera.h"
#import "PPDeviceProxyLocalPictureFrame.h"

@class PPDeviceProxy;

#define DEFAULT_DEVICE_PROXY_ALERT_ID_LIMIT 1000
#define PROVIDEO_CACHE_REFRESH_TIME_SECONDS 60
#define FILE_UPLOAD_ATTEMPT_LIMIT 1
#define PROXY_DEFAULT_POST_FILE_RETRY_INTERVAL 20

typedef NS_OPTIONS(NSInteger, PPDeviceProxyReliabilityBufferType) {
    PPDeviceProxyReliabilityBufferTypeCommandResponses,
    PPDeviceProxyReliabilityBufferTypeMeasurement,
    PPDeviceProxyReliabilityBufferTypeAlert
};

typedef void (^PPFileAcknowledgmentBlock)(PPFileId fileId, PPFileFragments totalFragments, PPFileUsedFileSpace usedSpace, PPFileTotalFileSpace totalSpace, PPFileFilesAction action, PPFileThumbnail thumbnail, PPFileTwitterShare twitterShare, NSError * _Nullable error);
typedef void (^PPProxyRegisterBlock)(PPDeviceProxy * _Nullable device, NSError * _Nullable error);
typedef NSDictionary * _Nonnull (^PPDeviceProxyDeviceCommandBlock)(NSArray * _Nullable parameters);
typedef void (^PPUserAccountsBlock)(PPUser * _Nullable user, NSError * _Nullable error);

@protocol PPDeviceProxyDelegate <NSObject>

- (void)proxyDidSendMeasurement:(NSString *)sequenceNumber status:(NSString *)status;
- (void)willSendMeasurement:(NSString *)sequenceNumber measurement:(PPDeviceMeasurement *)measurement;

@end;

@interface PPDeviceProxy : PPBaseModel <PPDeviceProxyLocalWebsocketDelegate>

#pragma mark - Session Management

/**
 * Current active proxy
 */
+ (PPDeviceProxy *)currentProxy;

/**
 * Set proxy.
 *
 * @param proxy PPDeviceProxy New proxy
 **/
+ (void)setProxy:(PPDeviceProxy *)proxy;

#pragma mark - Device Properties

@property (nonatomic, weak, readwrite) NSObject<PPDeviceProxyDelegate> *delegate;
@property (nonatomic, strong) PPCloudConnectivityServer *server;
@property (nonatomic, strong) NSString *authToken;
@property (nonatomic, strong) NSString *host;
@property (nonatomic) PPDevicesPort port;
@property (nonatomic) PPDevicesUseSSL useSsl;
@property (nonatomic, strong) PPLocation *location;
@property (nonatomic, strong) PPDeviceProxyLocal *localDevice;
@property (nonatomic) NSInteger persistentTimeout;
@property (nonatomic) NSInteger postFileRetryInterval;

//+ (void)registerDeviceType:(PPDeviceTypeId)devicetypeId location:(PPLocation *)location proxyId:(NSString *)proxyId callback:(PPProxyRegisterBlock)callback;

- (id)initWithAuthToken:(NSString *)authToken server:(PPCloudConnectivityServer *)server localDevice:(PPDeviceProxyLocal *)localDevice;

- (void)turnOn:(NSObject<PPDeviceProxyLocalDelegate> *)delegate;
- (BOOL)isOn;
- (void)turnOff;

+ (BOOL)wasProxyOn;

- (void)commandsForDeviceId:(NSString *)deviceId sendToBlock:(PPDeviceProxyDeviceCommandBlock)commandBlock;
- (void)stopCommandsForDeviceId:(NSString *)deviceId;
- (void)sendMeasurement:(PPDeviceMeasurement *)measurement;
- (void)sendMeasurements:(NSArray *)measurements;
- (void)sendAlert:(PPDeviceMeasurementsAlert *)alert;
- (void)setHighSpeedMode:(BOOL)highSpeed;
- (void)setCleanConnection:(BOOL)cleanConnection;

- (void)sendFile:(NSData *)data fileType:(PPFileFileType)fileType isThumbnail:(BOOL)isThumbnail rotation:(NSInteger)degrees totalDuration:(NSInteger)totalDuration fromDevice:(PPDevice *)device incomplete:(BOOL)incomplete fragmentIndex:(NSInteger)fragmentIndex expectedTotalBytes:(unsigned long long)expectedTotalBytes fileRef:(NSString *)fileRef replacementFileId:(NSString *)replacementFileId attempt:(NSInteger)attempt callback:(PPFileAcknowledgmentBlock)callback;

+ (PPDeviceMeasurementsAlertId)uniqueAlertId;

/**
 * Get user by device.
 * With the Device API and no API key, determine if this is a Pro Video subscriber, to enable Pro Video features at the device
 * See http://docs.iotapps.apiary.io/#reference/user-accounts/get-user-by-device/get-user-by-device
 * This uses the Cloud API while passing in the authentication token of this proxy.
 * Responses are cached.
 *
 * A gateway or proxy can request some information about an owner. Currently only assigned paid services are returned.
 * The PPCAuthorization headers may take on one of two forms, to identify the source device:Using a Device Authentication Token:
 *      PPCAuthorization: esp token="ABC12345"
 *      Using a Streaming Session ID: PPCAuthorization: stream session="DEF67890"
 *
 * @param proxyId NSString Device ID of the gateway or proxy
 * @param callback PPUserAccountsServicesBlock Callback method provides PPUser object and optional error
 */
- (void)getUserByDevice:(NSString * _Nullable )proxyId callback:(PPUserAccountsServicesBlock _Nonnull )callback;

@end
