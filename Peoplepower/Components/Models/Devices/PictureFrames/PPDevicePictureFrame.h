//
//  PPDevicePictureFrame.h
//  Peoplepower
//
//  Created by Destry Teeter on 4/30/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPDevice.h"
#import "PPVersion.h"
#import "PPVideoToken.h"
#import "PPQuestion.h"

// PictureFrame parameter refresh interval
extern NSInteger PICTURE_FRAME_REFRESH_INTERVAL;

// Streaming connection attemp limit
extern NSInteger PICTURE_FRAME_STREAMING_CONNECTION_ATTEMPT_LIMIT;

// PictureFrame output volume
extern PPDeviceParametersOutputVolume PICTURE_FRAME_VOLUME_OUTPUT_MAXIMUM;
extern PPDeviceParametersOutputVolume PICTURE_FRAME_VOLUME_OUTPUT_DEFAULT;


@interface PPDevicePictureFrame : PPDevice

// Camera
@property (nonatomic) PPDeviceParametersSelectedCamera selectedCamera;

// Flash
@property (nonatomic) PPDeviceParametersSelectedFlash selectedFlash;

// Recording
@property (nonatomic) PPDeviceParametersAudioStatus audioStatus;
@property (nonatomic) PPDeviceParametersRecordStatus recordStatus;
@property (nonatomic) PPDeviceParametersAudioSensitiviy audioSensitivity;
@property (nonatomic) PPDeviceParametersAudioActivity audioActivity;

// Streaming
@property (nonatomic) PPDeviceParametersAudioStreaming audioStreaming;
@property (nonatomic) PPDeviceParametersVideoStreaming videoStreaming;
@property (nonatomic) PPDeviceParametersSupportsVideoCall supportsVideoCall;

// Various
@property (nonatomic) PPDeviceParametersBatteryLevel batteryLevel;
@property (nonatomic) PPDeviceParametersCharging charging;
@property (nonatomic) PPVersion *version;
@property (nonatomic) unsigned long long availableBytes;
@property (nonatomic) PPDeviceParametersBlackoutScreenOn blackoutScreenOn;
@property (nonatomic) PPDeviceParametersOutputVolume outputVolume;

// Care
@property (nonatomic) NSString *alertTitle;
@property (nonatomic) NSString *alertSubtitle;
@property (nonatomic) PPQuestionId alertQuestionId;
@property (nonatomic) NSString *alertMessage;
@property (nonatomic) NSString *alertIcon;
@property (nonatomic) NSDate *alertTimestamp;
@property (nonatomic) PPDeviceParametersAlertDuration alertDuration;
@property (nonatomic) PPDeviceParametersAlertPriority alertPriority;
@property (nonatomic) NSString *playSound;
@property (nonatomic) PPDeviceParametersAlertStatus alertStatus;
@property (nonatomic) NSString *notification;

// Volatile Parameters
@property (nonatomic) NSString *streamId;
@property (nonatomic) NSInteger recordStream;

- (id)initWithDeviceId:(NSString *)deviceId proxyId:(NSString *)proxyId name:(NSString *)name connected:(PPDeviceConnected)connected restricted:(PPDeviceRestricted)restricted shared:(PPDeviceShared)shared newDevice:(PPDeviceNewDevice)newDevice goalId:(PPDeviceTypeGoalId)goalId typeId:(PPDeviceTypeId)typeId category:(PPDeviceTypeCategory)category typeAttributes:(NSMutableArray *)typeAttributes locationId:(PPLocationId)locationId startDate:(NSDate *)startDate lastDataReceivedDate:(NSDate *)lastDataReceivedDate lastMeasureDate:(NSDate *)lastMeasureDate lastConnectedDate:(NSDate *)lastConnectedDate parameters:(NSMutableArray *)parameters properties:(NSMutableArray *)properties icon:(NSString *)icon spaces:(NSMutableArray *)spaces modelId:(NSString *)modelId;

+ (PPDevicePictureFrame *)initWithDictionary:(NSDictionary *)deviceDict;

+ (NSMutableArray *)defaultParameters;

+ (NSArray *)kvoObservers;

/**
 * Supports Video.
 * Check if this device has any available cameras
 *
 * @return BOOL True if this device has a supported camera
 **/
+ (BOOL)supportsVideo;

- (void)syncSelectedCamera;

@end
