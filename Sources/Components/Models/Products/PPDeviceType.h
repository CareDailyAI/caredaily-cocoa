//
//  PPDeviceType.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
//#import "PPUser.h"
#import "PPDeviceTypeAttribute.h"


typedef NS_OPTIONS(NSInteger, PPDeviceTypeId)  {
    PPDeviceTypeIdNone = 0,
    PPDeviceTypeIdUnknown = 0,
    PPDeviceTypeIdFirstTimeSetup = 1,
    PPDeviceTypeIdMobileHub = 3,
    PPDeviceTypeIdPeoplePowerHub = 4,
    PPDeviceTypeIdCrowdfunding = 8,
    PPDeviceTypeIdThermostat = 11,
    PPDeviceTypeIdNextekPsm = 12,
    PPDeviceTypeIdHDBox808SmartPlug = 15,
    PPDeviceTypeIdIBeacon = 16,
    PPDeviceTypeIdOpenTokMobileCamera = 21,
    PPDeviceTypeIdWebCamera = 22,
    PPDeviceTypeIdAndroidMobileCamera = 23,
    PPDeviceTypeIdiOSMobileCamera = 24,
    PPDeviceTypeIdPresenceTouchpad = 25,
    PPDeviceTypeIdiOSPictureFrame = 26,
    PPDeviceTypeIdAndroidPictureFrame = 27,
    
    PPDeviceTypeIdAIOXGateway = 31,
    PPDeviceTypeIdEWIGGateway = 32,
    PPDeviceTypeIdAWSIOTGateway = 34,
    PPDeviceTypeIdDevelcoX5Gateway = 35,
    PPDeviceTypeIdDevelcoGatewayDP0X = 36,
    PPDeviceTypeIdDevelcoGatewayDP2X = 37,
    
    PPDeviceTypeIdQmote = 120,
    PPDeviceTypeIdLintAlertProPlus = 130,
    PPDeviceTypeIdLondonHydroGreenButton = 200,
    
    // Dead
    // PPDeviceTypeIdGroups = 500,
    // PPDeviceTypeIdMessages = 501,
    // PPDeviceTypeIdChallenges = 502,
    // PPDeviceTypeIdPoints = 503,
    
    PPDeviceTypeIdTedLoad1000 = 1000,
    PPDeviceTypeIdTedSolar1001 = 1001,
    PPDeviceTypeIdTedNet1002 = 1002,
    PPDeviceTypeIdTedStandalone1003 = 1003,
    PPDeviceTypeIdTedGateway1004 = 1004,
    PPDeviceTypeIdBlueLine = 1100,
    
    PPDeviceTypeIdMonsterThreeSocketMonitorControl = 2013,
    PPDeviceTypeIdMonsterOneSocketMonitorControl = 2012,
    PPDeviceTypeIdMonsterOneSocketMonitor = 2014,
    
    PPDeviceTypeIdRobotGalileo = 3100,
    PPDeviceTypeIdRobotGalileoBluetooth = 3101,
    PPDeviceTypeIdRobotKubiBluetooth = 3102,
    PPDeviceTypeIdRobotP360 = 3103,
    
    PPDeviceTypeIdNetatmoHealthCoach = 4200,
    PPDeviceTypeIdNetatmoWeatherStationIndoor = 4201,
    PPDeviceTypeIdNetatmoWeatherStationOutDoor = 4202,
    PPDeviceTypeIdNetatmoVirtualGateway = 4203,
    PPDeviceTypeIdNetatmoWelcomeCamera = 4204,
    
    PPDeviceTypeIdSensiboThermostat = 4220,
    PPDeviceTypeIdHoneywellThermostat = 4230,
    PPDeviceTypeIdEcobeeThermostat = 4240,
    PPDeviceTypeIdEmersonThermostat = 4260,
    
    PPDeviceTypeIdIndoorCamera = 7000,
    PPDeviceTypeIdFoscamIPCamera = 7001,
    PPDeviceTypeIdAMTKIPCamera = 7002,
    
    PPDeviceTypeIdGEInWallSwitch = 9001,
    PPDeviceTypeIdSmartenitSiren = 9002,
    PPDeviceTypeIdGreenPeakHumidityAndTemperatureSensor = 9003,
    
    PPDeviceTypeIdLinkHighSiren = 9009,
    PPDeviceTypeIdDoorLock = 9010,
    PPDeviceTypeIdEWIDButton = 9014,
    PPDeviceTypeIdLargeLoadController = 9017,

    PPDeviceTypeIdDevelcoButton = 9101,
    PPDeviceTypeIdDevelcoSiren = 9102,
    PPDeviceTypeIdDevelcoKeypad = 9103,
    PPDeviceTypeIdDevelcoSmokeAlarm = 9112,
    PPDeviceTypeIdDevelcoDoorWindowSensor = 9114,
    PPDeviceTypeIdDevelcoWatarSensor = 9117,
    PPDeviceTypeIdDevelcoSmartPlug = 9135,
    PPDeviceTypeIdDevelcoMovementSensor = 9138,
    
    PPDeviceTypeIdGreenPeakDoorWindowSensor = 10014,
    PPDeviceTypeIdGreenPeakLeakDetector = 10017,
    PPDeviceTypeIdGreenPeakMovementSensor = 10019,
    PPDeviceTypeIdGreenPeakGateway = 10031,
    PPDeviceTypeIdGreenPeakTemperatureSensor = 10033,
    PPDeviceTypeIdGreenPeakHumiditySensor = 10034,
    PPDeviceTypeIdCentralitePlug = 10035,
    
    PPDeviceTypeIdGELightBulb = 10036,
    PPDeviceTypeIdCentraliteThermostat = 10037,
    PPDeviceTypeIdMotionDetector = 10038,
    
};

typedef NS_OPTIONS(NSInteger, PPDeviceTypeCategory) {
    PPDeviceTypeCategoryNone = -1,
    
    PPDeviceTypeCategoryMeter = 1,
    PPDeviceTypeCategorySmartPlug = 2,
    PPDeviceTypeCategorySolar = 3,
    PPDeviceTypeCategoryThermostat = 4,
    PPDeviceTypeCategoryLock = 5,
    PPDeviceTypeCategoryMobileCamera = 6,
    PPDeviceTypeCategoryVideo = 7,
    
    PPDeviceTypeCategoryReserved = 0, // Reserved
    PPDeviceTypeCategoryTemporary = 50, // Temporary categories / anything you want to define
    PPDeviceTypeCategoryAdministrativeTools = 1000, // Administrative Tools
    PPDeviceTypeCategoryAlarms = 2000, // Alarms
    PPDeviceTypeCategoryAnalytics = 3000, // Analytics
    PPDeviceTypeCategoryAppliances = 4000, // Appliances
    PPDeviceTypeCategoryAudio = 5000, // Audio
    PPDeviceTypeCategoryCameras = 6000, // Cameras
    PPDeviceTypeCategoryClimateControl = 7000, // Climate Control
    PPDeviceTypeCategoryDisplays = 8000, // Displays
    PPDeviceTypeCategoryEnvironmental = 9000, // Environmental
    PPDeviceTypeCategoryHealth = 10000, // Health
    PPDeviceTypeCategoryLighting = 11000, // Lighting
    PPDeviceTypeCategoryLocks = 12000, // Locks
    PPDeviceTypeCategoryMedia = 13000, // Media
    PPDeviceTypeCategoryMeters = 14000, // Meters
    PPDeviceTypeCategoryPerimeterMonitoring = 15000, // Perimeter Monitoring
    PPDeviceTypeCategoryRemoteControls = 16000, // Remote Controls
    PPDeviceTypeCategoryRobotics = 17000, // Robotics
    PPDeviceTypeCategoryRouters = 18000, // Routers / Gateways / Set-top Boxes
    PPDeviceTypeCategorySecurity = 19000, // Security
    PPDeviceTypeCategorySensors = 20000, // Sensors
    PPDeviceTypeCategoryShades = 21000, // Shades
    PPDeviceTypeCategorySocial = 22000, // Social
    PPDeviceTypeCategorySwitches = 23000, // Switches
    PPDeviceTypeCategoryToys = 24000, // Toys
    PPDeviceTypeCategoryTransportation = 25000, // Transportation
    PPDeviceTypeCategoryVideos = 26000, // Videos
    PPDeviceTypeCategoryWater = 27000, // Water
};

typedef NS_OPTIONS(NSInteger, PPDeviceTypeEditable) {
    PPDeviceTypeEditableNone = -1,
    PPDeviceTypeEditableFalse = 0,
    PPDeviceTypeEditableTrue = 1,
};

@interface PPDeviceType : PPBaseModel

@property (nonatomic) PPDeviceTypeId typeId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic) PPDeviceTypeEditable editable;
@property (nonatomic, strong) PPUser *createdBy;
@property (nonatomic, strong) NSDate *creationDate;
@property (nonatomic, strong) RLMArray<PPDeviceTypeAttribute *><PPDeviceTypeAttribute> *attributes;

- (id)initWithTypeId:(PPDeviceTypeId)typeId name:(NSString *)name editable:(PPDeviceTypeEditable)editable createdBy:(PPUser *)createdBy creationDate:(NSDate *)creationDate attributes:(RLMArray *)attributes;

+ (PPDeviceType *)initWithDictionary:(NSDictionary *)typeDict;

+ (NSString *)stringify:(PPDeviceType *)deviceType;

#pragma mark - Helper Methods

- (BOOL)isEqualToDeviceType:(PPDeviceType *)deviceType;

- (void)sync:(PPDeviceType *)deviceType;

@end
