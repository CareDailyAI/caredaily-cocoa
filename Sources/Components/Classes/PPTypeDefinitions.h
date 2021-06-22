//
//  PPTypeDefinitions.h
//  Peoplepower
//
//  Created by Destry Teeter on 11/4/20.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#ifndef PPTypeDefinitions_h
#define PPTypeDefinitions_h

// MARK: - Cloud Connectivity

typedef NS_OPTIONS(NSInteger, PPCloudConnectivityConnected) {
    PPCloudConnectivityConnectedNone = -1,
    PPCloudConnectivityConnectedFalse = 0,
    PPCloudConnectivityConnectedTrue = 1
};

// MARK: Server

typedef NS_OPTIONS(NSInteger, PPCloudConnectivityVersion) {
    PPCloudConnectivityVersionNone = -1,
};

typedef NS_OPTIONS(NSInteger, PPCloudConnectivityPort) {
    PPCloudConnectivityPortNone = -1,
};

typedef NS_OPTIONS(NSInteger, PPCloudConnectivitySSL) {
    PPCloudConnectivitySSLNone = -1,
    PPCloudConnectivitySSLFalse = 0,
    PPCloudConnectivitySSLTrue = 1
};

// MARK: - Login and Logout

typedef NS_OPTIONS(NSInteger, PPLoginExpiryType) {
    PPLoginExpiryTypeNever = -1,
    PPLoginExpiryTypeNotSet = 0,
};

typedef NS_OPTIONS(NSInteger, PPLoginNotificationType) {
    PPLoginNotificationTypeNone = -1,
    PPLoginNotificationTypeEmail = 1,
    PPLoginNotificationTypeSMS = 2,
};

typedef NS_OPTIONS(NSInteger, PPLoginKeyType) {
    PPLoginKeyTypeDefault = 0,
    PPLoginKeyTypeTempKey = 1,
    PPLoginKeyTypeAnalytic = 14
};

// MARK: Operation Token

/**
 * Opeartion Token types
 */
typedef NS_OPTIONS(NSInteger, PPOperationTokenType) {
    PPOperationTokenTypeUserRegistration = 1
};

// MARK: - User Accounts

typedef NS_OPTIONS(NSInteger, PPUserAccountAuthorizationType) {
    PPUserAccountAuthorizationTypeNone = -1,
    PPUserAccountAuthorizationTypeDeviceAuthenticationToken = 0,
    PPUserAccountAuthorizationTypeStreamingSessionId = 1
};

typedef NS_OPTIONS(NSInteger, PPUserAccountSendAsRequest) {
    PPUserAccountSendAsRequestNone = -1,
    PPUserAccountSendAsRequestFalse = 0,
    PPUserAccountSendAsRequestTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPUserAccountsMerge) {
    PPUserAccountsMergeNone = -1,
    PPUserAccountsMergeFalse = 0,
    PPUserAccountsMergeTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPUserAccountsStateOverwrite) {
    PPUserAccountsStateOverwriteNone = -1,
    PPUserAccountsStateOverwriteFalse = 0,
    PPUserAccountsStateOverwriteTrue = 1
};

// MARK: Location

typedef NS_OPTIONS(NSInteger, PPLocationType) {
    PPLocationTypeNone = -1,
    PPLocationTypeResidence = 10,
    PPLocationTypeGeneralBusiness = 20,
    PPLocationTypeGovernment = 21,
    PPLocationTypeLodging = 22,
    PPLocationTypeRestaurant = 23,
    PPLocationTypeRetail = 24,
    PPLocationTypeOffice = 25
};

typedef NS_OPTIONS(NSInteger, PPLocationUsagePeriod) {
    PPLocationUsagePeriodNone = -1,
    PPLocationUsagePeriodDay = 1,
    PPLocationUsagePeriodNight = 2,
    PPLocationUsagePeriodBoth = 3
};

typedef NS_OPTIONS(NSInteger, PPLocationStoriesNumber) {
    PPLocationStoriesNumberNone = -1
};

typedef NS_OPTIONS(NSInteger, PPLocationRoomsNumber) {
    PPLocationRoomsNumberNone = -1
};

typedef NS_OPTIONS(NSInteger, PPLocationBathroomsNumber) {
    PPLocationBathroomsNumberNone = -1
};

typedef NS_OPTIONS(NSInteger, PPLocationOccupantsNumber) {
    PPLocationOccupantsNumberNone = -1
};

typedef NS_OPTIONS(NSInteger, PPLocationHeatingType) {
    PPLocationHeatingTypeNone = 0,
    PPLocationHeatingTypeElectric = 1 << 0,
    PPLocationHeatingTypeNaturalGas = 1 << 1,
    PPLocationHeatingTypePropane = 1 << 2,
    PPLocationHeatingTypeOil = 1 << 3,
    PPLocationHeatingTypeBiomass = 1 << 4,
    PPLocationHeatingTypeOther = 1 << 7
};

typedef NS_OPTIONS(NSInteger, PPLocationOwner) {
    PPLocationOwnerNone = -1,
    PPLocationOwnerFalse = 0,
    PPLocationOwnerTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPLocationCoolingType) {
    PPLocationCoolingTypeNone = 0,
    PPLocationCoolingTypeCentralAC = 1 << 0,
    PPLocationCoolingTypeWindowAC = 1 << 1,
    PPLocationCoolingTypeOpenWindows = 1 << 2,
    PPLocationCoolingTypeOther = 1 << 7
};

typedef NS_OPTIONS(NSInteger, PPLocationWaterHeaterType) {
    PPLocationWaterHeaterTypeNone = 0,
    PPLocationWaterHeaterTypeElectric = 1 << 0,
    PPLocationWaterHeaterTypeNaturalGas = 1 << 1,
    PPLocationWaterHeaterTypePropane = 1 << 2,
    PPLocationWaterHeaterTypeOil = 1 << 3,
    PPLocationWaterHeaterTypeBiomass = 1 << 4,
    PPLocationWaterHeaterTypeSolar = 1 << 5,
    PPLocationWaterHeaterTypeOther = 1 << 7
};

typedef NS_OPTIONS(NSInteger, PPLocationThermostatType) {
    PPLocationThermostatTypeNone = 0,
    PPLocationThermostatTypeNonProgrammable = 1,
    PPLocationThermostatTypeProgrammable = 2,
    PPLocationThermostatTypeInternetConnected = 3
};

typedef NS_OPTIONS(NSInteger, PPLocationId) {
    PPLocationIdNone = -1
};

typedef NS_OPTIONS(NSInteger, PPLocationAccess) {
    PPLocationAccessNone = -1,
    PPLocationAccessNoAccess = 0,
    PPLocationAccessRead = 10,
    PPLocationAccessControl = 20,
    PPLocationAccessAdmin = 30,
};

typedef NS_OPTIONS(NSInteger, PPLocationCategory) {
    PPLocationCategoryNone = -1,
    PPLocationCategoryNoCategory = 0,
    PPLocationCategoryHomeowner = 1,
    PPLocationCategorySupporter = 2,
    PPLocationCategoryReminders = 3,
};

typedef NS_OPTIONS(NSInteger, PPLocationFileUploadPolicy) {
    PPLocationFileUploadPolicyNone = -1,
    PPLocationFileUploadPolicyKeepOldFiles = 0,
    PPLocationFileUploadPolicyAutomaticallyDeleteOldFiles = 1,
};

typedef NS_OPTIONS(NSInteger, PPDeviceShared) {
    PPDeviceSharedNone = -1,
    PPDeviceSharedFalse = 0,
    PPDeviceSharedTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPLocationTemporary) {
    PPLocationTemporaryNone  = -1,
    PPLocationTemporaryFalse = 0,
    PPLocationTemporaryTrue  = 1
};

typedef NS_OPTIONS(NSInteger, PPLocationTest) {
    PPLocationTestNone  = -1,
    PPLocationTestFalse = 0,
    PPLocationTestTrue  = 1
};

typedef NS_OPTIONS(NSInteger, PPLocationCodeType) {
    PPLocationCodeTypeNone     = -1,
    PPLocationCodeTypeManual   = 1,
    PPLocationCodeTypeCard     = 2,
    PPLocationCodeTypeCombined = 3,
    PPLocationCodeTypeKeypad   = 4,
};

// MARK: Location Community

typedef NS_OPTIONS(NSInteger, PPCommunityId) {
    PPCommunityIdNone = -1
};

// MARK: Location Space

typedef NS_OPTIONS(NSInteger, PPLocationSpaceId) {
    PPLocationSpaceIdNone = -1
};

typedef NS_OPTIONS(NSInteger, PPLocationSpaceType) {
    PPLocationSpaceTypeNone         = -1,
    PPLocationSpaceTypeUndefined    = 0,
    PPLocationSpaceTypeKitchen      = 1,
    PPLocationSpaceTypeBedroom      = 2,
    PPLocationSpaceTypeBathroom     = 3,
    PPLocationSpaceTypeHallway      = 4,
    PPLocationSpaceTypeLivingRoom   = 5,
    PPLocationSpaceTypeDiningRoom   = 6,
    PPLocationSpaceTypeFamilyRoom   = 7,
    PPLocationSpaceTypeLaundryRoom  = 8,
    PPLocationSpaceTypeOffice       = 9,
    PPLocationSpaceTypeStairs       = 10,
    PPLocationSpaceTypeGarage       = 11,
    PPLocationSpaceTypeBasement     = 12,
    PPLocationSpaceTypeOther        = 13,
    PPLocationSpaceTypeCouch        = 14,
    PPLocationSpaceTypeChair        = 15,
};

// MARK: Location Size

typedef NS_OPTIONS(NSInteger, PPLocationSizeContent) {
    PPLocationSizeContentNone = -1
};

// MARK: Location Scene Event

typedef NS_OPTIONS(NSInteger, PPLocationSceneEventSourceType) {
    PPLocationSceneEventSourceTypeNone = -1,
    PPLocationSceneEventSourceTypeUserApp = 0,
    PPLocationSceneEventSourceTypeRule = 1,
    PPLocationSceneEventSourceTypeBot = 2
};

// MARK: Location Narrative

typedef NS_OPTIONS(NSInteger, PPLocationNarrativeId) {
    PPLocationNarrativeIdNone = -1
};

typedef NS_OPTIONS(NSInteger, PPLocationNarrativeTime) {
    PPLocationNarrativeTimeNone = -1
};

typedef NS_OPTIONS(NSInteger, PPLocationNarrativePriority) {
    PPLocationNarrativePriorityNone = -1,
    PPLocationNarrativePriorityDebug = 0,
    PPLocationNarrativePriorityInfo = 1,
    PPLocationNarrativePriorityWarning = 2,
    PPLocationNarrativePriorityCritical = 3
};

typedef NS_OPTIONS(NSInteger, PPLocationNarrativeRowCount) {
    PPLocationNarrativeRowCountNone = -1
};

// MARK: User

typedef NS_OPTIONS(NSInteger, PPUserId) {
    PPUserIdNone = -1
};

typedef NS_OPTIONS(NSInteger, PPUserPermission) {
    PPUserPermissionNone = -1,
    PPUserPermissionAccessAnyObjects = 0, // System admin
    PPUserPermissionGrantRoles = 1,
    PPUserPermissionReportsAccess = 2,
    PPUserPermissionOrganizationAdmin = 3,
    PPUserPermissionDevicesAndUserAccess = 4,
    PPUserPermissionPaidServicesAdministrator = 5
};

typedef NS_OPTIONS(NSInteger, PPUserPhoneType) {
    PPUserPhoneTypeNone = -1,
    PPUserPhoneTypeUnknown = 0,
    PPUserPhoneTypeCell = 1,
    PPUserPhoneTypeHome = 2,
    PPUserPhoneTypeWork = 3,
    PPUserPhoneTypeOffice = 4
};

typedef NS_OPTIONS(NSInteger, PPUserEmailVerificationType) {
    PPUserEmailVerificationTypeNone = 1,
    PPUserEmailVerificationTypeEmail = 0,
    PPUserEmailVerificationTypeSMS = 2
};

typedef NS_OPTIONS(NSInteger, PPUserAnonymousType) {
    PPUserAnonymousTypeNone = -1,
    PPUserAnonymousTypeNotAnonymous = 0,
    PPUserAnonymousTypeAnonymous = 1
};
typedef NS_OPTIONS(NSInteger, PPUserSMSStatus) {
    PPUserSMSStatusNone = -1,
    PPUserSMSStatusUnknown = 0,
    PPUserSMSStatusVerified = 1,
    PPUserSMSStatusNotVerified = 2,
    PPUserSMSStatusInvalid = 3
};

typedef NS_OPTIONS(NSInteger, PPUserAvatarFileId) {
    PPUserAvatarFileIdNone = -1,
};

// MARK: User Email

typedef NS_OPTIONS(NSInteger, PPUserEmailStatus) {
    PPUserEmailStatusNone = -1,
    PPUserEmailStatusOK = 0,
    PPUserEmailStatusHardBound = 1,
    PPUserEmailStatusSpamComplaint = 2,
    PPUserEmailStatusBadAddress = 3,
    PPUserEmailStatusSpamNotification = 4,
};

typedef NS_OPTIONS(NSInteger, PPUserEmailVerified) {
    PPUserEmailVerifiedNone = -1,
    PPUserEmailVerifiedFalse = 0,
    PPUserEmailVerifiedTrue = 1
};

// MARK: User Badge

typedef NS_OPTIONS(NSInteger, PPUserBadgeType) {
    PPUserBadgeTypeNone = 0,
    PPUserBadgeTypeNewMessage = 1,
    PPUserBadgeTypeNewChallenge = 2,
    PPUserBadgeTypeNewVideoAlert = 3,
    PPUserBadgeTypeNewDeviceRegistered = 4,
    PPUserBadgeTypeNewFriendOrSharedDevice = 5,
    PPUserBadgeTypeNewCommunityNotification = 6,
};

typedef NS_OPTIONS(NSInteger, PPUserBadgeCount) {
    PPUserBadgeCountNone = -1,
};

// MARK: User Code

typedef NS_OPTIONS(NSInteger, PPUserCodeType) {
    PPUserCodeTypeManual   = 1,
    PPUserCodeTypeCard     = 2,
    PPUserCodeTypeCombined = 3,
    PPUserCodeTypeKeypad   = 4,
};

typedef NS_OPTIONS(NSInteger, PPUserCodeExpiry) {
    PPUserCodeExpiryNone    = -1,
    PPUserCodeExpiryDefault = 60
};

typedef NS_OPTIONS(NSInteger, PPUserCodeVerified) {
    PPUserCodeVerifiedNone    = -1,
    PPUserCodeVerifiedFalse   = 0,
    PPUserCodeVerifiedTrue    = 1,
};

// MARK: User Service

typedef NS_OPTIONS(NSInteger, PPUserServiceAmount) {
    PPUserServiceAmountNone = -1,
};

// MARK: Countries States and Timezones

typedef NS_OPTIONS(NSInteger, PPCountryId) {
    PPCountryIdNone = -1
};

typedef NS_OPTIONS(NSInteger, PPStateId) {
    PPStateIdNone = -1
};

typedef NS_OPTIONS(NSInteger, PPPreferredCountry) {
    PPPreferredCountryNone = -1,
    PPPreferredCountryFalse = 0,
    PPPreferredCountryTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPPreferredState) {
    PPPreferredStateNone = -1,
    PPPreferredStateFalse = 0,
    PPPreferredStateTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPDaylightSavingsTime) {
    PPDaylightSavingsTimeNone = -1,
    PPDaylightSavingsTimeFalse = 0,
    PPDaylightSavingsTimeTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPTimezoneOffset) {
    PPTimezoneOffsetNone = -1
};

// MARK: User Analytics

typedef NS_OPTIONS(NSInteger, PPAnalyticsLoggingLevels) {
    // Only critical logging elements (open app, create account, market)
    ANALYTICS_LEVEL_CRITICAL = 0,
    
    // New features we're testing + critical logging elements
    ANALYTICS_LEVEL_ALERT = 1,
    
    // Log the normal user flow
    ANALYTICS_LEVEL_INFO = 2,
    
    // Add trace level debugging
    ANALYTICS_LEVEL_DEBUG = 3,
};

typedef NS_OPTIONS(NSInteger, PPAnalyticsLoggingLevelTimeIntevals) {
    ANALYTICS_TIME_INTERVAL_CRITICAL = 5,
    ANALYTICS_TIME_INTERVAL_ALERT    = 30,
    ANALYTICS_TIME_INTERVAL_INFO     = 120,
    ANALYTICS_TIME_INTERVAL_DEBUG    = 0,
};

// MARK: - Devices

typedef NS_OPTIONS(NSInteger, PPDevicesExist) {
    PPDevicesExistNone = -1,
    PPDevicesExistFalse = 0,
    PPDevicesExistTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPDevicesUseSSL) {
    PPDevicesUseSSLNone = -1,
    PPDevicesUseSSLFalse = 0,
    PPDevicesUseSSLTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPDevicesPort) {
    PPDevicesPortNone = -1,
};

typedef NS_OPTIONS(NSInteger, PPDevicesAuthToken) {
    PPDevicesAuthTokenNone = -1,
    PPDevicesAuthTokenNoAuthenticationTokenNeeded = 0,
    PPDevicesAuthTokenRequestAuthenticationToken = 1
};

typedef NS_OPTIONS(NSInteger, PPDevicesCheckPersistent) {
    PPDevicesCheckPersistentNone = -1,
    PPDevicesCheckPersistentFalse = 0,
    PPDevicesCheckPersistentTrue
};

typedef NS_OPTIONS(NSInteger, PPDevicesKeepOnAccount) {
    PPDevicesKeepOnAccountNone = -1,
    PPDevicesKeepOnAccountFalse = 0,
    PPDevicesKeepOnAccountTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPDevicesKeepSlave) {
    PPDevicesKeepSlaveNone = -1,
    PPDevicesKeepSlaveFalse = 0,
    PPDevicesKeepSlaveTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPDevicesKeepSlaveOnGateway) {
    PPDevicesKeepSlaveOnGatewayNone = -1,
    PPDevicesKeepSlaveOnGatewayFalse = 0,
    PPDevicesKeepSlaveOnGatewayTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPDevicesClear) {
    PPDevicesClearNone = -1,
    PPDevicesClearFalse = 0,
    PPDevicesClearTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceActivationSendEmail) {
    PPDeviceActivationSendEmailNone = -1,
    PPDeviceActivationSendEmailFalse = 0,
    PPDeviceActivationSendEmailTrue = 1
};

// MARK: Device

typedef NS_OPTIONS(NSInteger, PPHistoricalMeasurementsAggregation) {
    PPHistoricalMeasurementsAggregationDefault = 0,
    PPHistoricalMeasurementsAggregationMinimum = 1,
    PPHistoricalMeasurementsAggregationMaximum = 2,
    PPHistoricalMeasurementsAggregationMedian = 3,
    PPHistoricalMeasurementsAggregationTimeDistributedAverage = 4,
    PPHistoricalMeasurementsAggregationAverage = 5
};

typedef NS_OPTIONS(NSInteger, PPDeviceConnected) {
    PPDeviceConnectedNone = -1,
    PPDeviceConnectedFalse = 0,
    PPDeviceConnectedTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceNewDevice) {
    PPDeviceNewDeviceNone = -1,
    PPDeviceNewDeviceFalse = 0,
    PPDeviceNewDeviceTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceRestricted) {
    PPDeviceRestrictedNone = -1,
    PPDeviceRestrictedFalse = 0,
    PPDeviceRestrictedTrue = 1
};

// MARK: Proxies

typedef NS_OPTIONS(NSInteger, PPDeviceProxyReliabilityBufferType) {
    PPDeviceProxyReliabilityBufferTypeCommandResponses,
    PPDeviceProxyReliabilityBufferTypeMeasurement,
    PPDeviceProxyReliabilityBufferTypeAlert
};

typedef NS_OPTIONS(NSInteger, PPDeviceProxyLocalProgress) {
    PPDeviceProxyLocalProgressNone                  = -1,
    PPDeviceProxyLocalProgressDefault               = 0,
    PPDeviceProxyLocalProgressInitializingProxy     = 10,
    PPDeviceProxyLocalProgressProxyInitialized      = 20,
    PPDeviceProxyLocalProgressInitializingWebsocket = 30,
    PPDeviceProxyLocalProgressGatheringServer       = 40,
    PPDeviceProxyLocalProgressServerDefined         = 50,
    PPDeviceProxyLocalProgressWebSocketConnecting   = 60,
    PPDeviceProxyLocalProgressWebSocketConnected    = 70,
    PPDeviceProxyLocalProgressWebsocketInitialized  = 80,
    
    PPDeviceProxyLocalProgressPlayerOff             = 1,
    PPDeviceProxyLocalProgressPlayerConfiguration   = 31,
    PPDeviceProxyLocalProgressPlayerConnecting      = 61,
    PPDeviceProxyLocalProgressPlayerConnected       = 91,
    
    PPDeviceProxyLocalProgressFinished              = 100
};

typedef NS_OPTIONS(NSInteger, PPDeviceProxyPlayerStatus) {
    PPDeviceProxyPlayerStatusConnectionErrorNotReachable = 0,
    PPDeviceProxyPlayerStatusConnectionErrorWWAN = 1,
    PPDeviceProxyPlayerStatusConnectionErrorWiFi = 2,
    PPDeviceProxyPlayerStatusVideoDisabled = 3,
    PPDeviceProxyPlayerStatusDisconnected = 4,
    PPDeviceProxyPlayerStatusInterrupted = 5
};

typedef NS_OPTIONS(NSInteger, PPDeviceProxyLocalRegistrationAttempts) {
    PPDeviceProxyLocalRegistrationAttemptsNone = -1,
    PPDeviceProxyLocalRegistrationAttemptsMax = 10
};

typedef NS_OPTIONS(NSInteger, PPDeviceProxyLocalInitializationAttempts) {
    PPDeviceProxyLocalInitializationAttemptsNone = -1,
    PPDeviceProxyLocalInitializationAttemptsMax = 9
};

// MARK: Cameras

typedef NS_OPTIONS(NSInteger, PPVideoTokenProvider) {
    PPVideoTokenProviderNone = -1,
    PPVideoTokenProviderUndefined = 0,
    PPVideoTokenProviderVidyo = 1,
    PPVideoTokenProviderTwilio = 2
};

typedef NS_OPTIONS(NSInteger, PPVideoTokenAuthType) {
    PPVideoTokenAuthTypeNone = -1,
    PPVideoTokenAuthTypeDeviceAuthToken = 0,
    PPVideoTokenAuthTypeStreamingId = 1
};

typedef NS_OPTIONS(NSInteger, PPVideoTokenExpireTimeInterval) {
    PPVideoTokenExpireTimeIntervalNone = -1,
    PPVideoTokenExpireTimeIntervalDefault = 3600
};

// MARK: Websocket

typedef NS_OPTIONS(NSInteger, PPWebSocketResourceEndpoint) {
    PPWebSocketResourceEndpointCamera = 0,
    PPWebSocketResourceEndpointViewer = 1,
    PPWebSocketResourceEndpointDefault = 2
};

/** Viewer status */
typedef NS_OPTIONS(NSInteger, PPWebSocketViewerStatus) {
    PPWebSocketViewerDisconnected = -1,
    PPWebSocketViewerNoChange = 0,
    PPWebSocketViewerConnected = 1,
};

/** Goals */
typedef NS_OPTIONS(NSInteger, PPWebSocketGoal) {
    PPWebSocketGoalAuth        = 1, // websocket session authentication request and response
    PPWebSocketGoalPresence    = 2, // availability of subscriptions within current scope that available for current user
    PPWebSocketGoalSubscribe   = 3, // subscription to specific data coming from other sources
    PPWebSocketGoalUnsubscribe = 4, // unsubscribe from a single subscription
    PPWebSocketGoalStatus      = 5, // status of current subscriptions
    PPWebSocketGoalData        = 6, // data event from the server
};

/** Types */
typedef NS_OPTIONS(NSInteger, PPWebSocketType) {
    PPWebSocketTypeNarratives               = 1, // Narratives
    PPWebSocketTypeOrganizationNarratives   = 2, // Organization Narratives
    PPWebSocketTypeLocationStates           = 3, // Location States
};

/** Operation
 * The client can subscribe on specific action on the data object. The operation field is a bimask of possible actions between 1 to 7
 */
typedef NS_OPTIONS(NSInteger, PPWebSocketOperation) {
    PPWebSocketOperationCreate      = 1 << 0, //
    PPWebSocketOperationUpdate      = 1 << 1, // availability of subscriptions within current scope that available for current user
    PPWebSocketOperationDelete     = 1 << 2, // subscription to specific data coming from other sources
};

typedef NS_OPTIONS(NSInteger, PPWebSocketErrorCode) {
    PPWebSocketErrorCodeSuccess = 0,
    PPWebSocketErrorCodeInternalError = 1,
    PPWebSocketErrorCodeWrongAPIKey = 2,
    PPWebSocketErrorCodeWrongAuthToken = 3,
    PPWebSocketErrorCodeWrongDeviceID = 4,
    PPWebSocketErrorCodeWrongSessionID = 5,
    PPWebSocketErrorCodeCameraNotConnected = 6,
    PPWebSocketErrorCodeCameraConnected = 7,
    PPWebSocketErrorCodeWrongParameterValue = 8,
    PPWebSocketErrorCodeMissingMandatoryParameter = 9,
    PPWebSocketErrorCodePing = 10,
    PPWebSocketErrorCodeServiceTemporarilyUnavailable = 30,
};

// MARK: Device Activation Info

typedef NS_OPTIONS(NSInteger, PPDeviceActivationInfoPort) {
    PPDeviceActivationInfoPortNone = -1
};

typedef NS_OPTIONS(NSInteger, PPDeviceActivationInfoSSL) {
    PPDeviceActivationInfoSSLNone = -1,
    PPDeviceActivationInfoSSLFalse = 0,
    PPDeviceActivationInfoSSLTrue
};

// MARK: Firmware Updates

typedef NS_OPTIONS(NSInteger, PPDeviceFirmwareUpdateStatus) {
    PPDeviceFirmwareUpdateStatusNone = -1,
    PPDeviceFirmwareUpdateStatusDone = 0,
    PPDeviceFirmwareUpdateStatusAvailable = 1,
    PPDeviceFirmwareUpdateStatusApproved = 2,
    PPDeviceFirmwareUpdateStatusDecline = 3,
    PPDeviceFirmwareUpdateStatusStarted = 4,
};

typedef NS_OPTIONS(NSInteger, PPDeviceFirmwareUpdateJobId) {
    PPDeviceFirmwareUpdateJobIdNone = -1
};

// MARK: - Device Measurements

typedef NS_OPTIONS(NSInteger, PPDeviceMeasurementsHistoryInterval) {
    PPDeviceMeasurementsHistoryIntervalNone = -1
};

typedef NS_OPTIONS(NSInteger, PPDeviceMeasurementsHistoryAggregation) {
    PPDeviceMeasurementsHistoryAggregationNone = -1,
    PPDeviceMeasurementsHistoryAggregationLastValueBeforeIntervalPoint = 0,
    PPDeviceMeasurementsHistoryAggregationMinimumValue = 1,
    PPDeviceMeasurementsHistoryAggregationMaximumValue = 2,
    PPDeviceMeasurementsHistoryAggregationMedianValue = 3,
    PPDeviceMeasurementsHistoryAggregationTimeDistributedAverageValue = 4,
    PPDeviceMeasurementsHistoryAggregationAverageValue = 5
};

typedef NS_OPTIONS(NSInteger, PPDeviceMeasurementsHistoryReduceNoise) {
    PPDeviceMeasurementsHistoryReduceNoiseNone = -1,
    PPDeviceMeasurementsHistoryReduceNoiseFalse = 0,
    PPDeviceMeasurementsHistoryReduceNoiseTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceMeasurementsHistoryRowCount) {
    PPDeviceMeasurementsHistoryRowCountNone = -1,
    PPDeviceMeasurementsHistoryRowCountMinimum = 1,
    PPDeviceMeasurementsHistoryRowCountMaximum = 1000
};

typedef NS_OPTIONS(NSInteger, PPDeviceMeasurementsDataRequestByEmail) {
    PPDeviceMeasurementsDataRequestByEmailNone = -1,
    PPDeviceMeasurementsDataRequestByEmailFalse = 0,
    PPDeviceMeasurementsDataRequestByEmailTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceMeasurementsCommandType) {
    PPDeviceMeasurementsCommandTypeNone     = -1,
    PPDeviceMeasurementsCommandTypeSet      = 0,
    PPDeviceMeasurementsCommandTypeGet      = 4,
    PPDeviceMeasurementsCommandTypeUpdate   = 5,
    PPDeviceMeasurementsCommandTypeDelete   = 6,
};

typedef NS_OPTIONS(NSInteger, PPDeviceMeasurementsAlertId) {
    PPDeviceMeasurementsAlertIdNone = -1
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersSystemMode) {
    PPDeviceParametersSystemModeOff = 0,
    PPDeviceParametersSystemModeAuto = 1,
    PPDeviceParametersSystemModeCool = 3,
    PPDeviceParametersSystemModeHeat = 4,
    PPDeviceParametersSystemModeEmergencyHeat = 5,
    PPDeviceParametersSystemModePrecooling = 6,
    PPDeviceParametersSystemModeFanOnly = 7,
    PPDeviceParametersSystemModeDry = 8,
    PPDeviceParametersSystemModeAuxiliaryHeat = 9,
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersSystemModeStatus) {
    PPDeviceParametersSystemModeStatusOff = 0,
    PPDeviceParametersSystemModeStatusCool = 1,
    PPDeviceParametersSystemModeStatusHeat = 2,
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersFanMode) {
    PPDeviceParametersFanModeOff = 0,
    PPDeviceParametersFanModeLow = 1,
    PPDeviceParametersFanModeMedium = 2,
    PPDeviceParametersFanModeHigh = 3,
    PPDeviceParametersFanModeOn = 4,
    PPDeviceParametersFanModeAuto = 5,
    PPDeviceParametersFanModeSmart = 6,
    PPDeviceParametersFanModeCirculate = 7,
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersFanModeSequence) {
    PPDeviceParametersFanModeSequenceLowMedHigh = 0,
    PPDeviceParametersFanModeSequenceLowHigh = 1,
    PPDeviceParametersFanModeSequenceLowMedHighAuto = 2,
    PPDeviceParametersFanModeSequenceLowHighAuto = 3,
    PPDeviceParametersFanModeSequenceOnAuto = 4
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersSwingMode) {
    PPDeviceParametersSwingModeStopped = 0,
    PPDeviceParametersSwingModeRangeFull = 1,
    PPDeviceParametersSwingModeRangeTop = 2,
    PPDeviceParametersSwingModeRangeMiddle = 3,
    PPDeviceParametersSwingModeRangeBottom = 4,
    PPDeviceParametersSwingModeFixedTop = 5,
    PPDeviceParametersSwingModeFixedMiddleTop = 6,
    PPDeviceParametersSwingModeFixedMiddle = 7,
    PPDeviceParametersSwingModeFixedMiddleBottom = 8,
    PPDeviceParametersSwingModeFixedBottom = 9
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersState) {
    PPDeviceParametersStateOff = 0,
    PPDeviceParametersStateOn = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersOutletStatus) {
    PPDeviceParametersOutletStatusOff = 0,
    PPDeviceParametersOutletStatusOn = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersPowerStatus) {
    PPDeviceParametersPowerStatusOff = 0,
    PPDeviceParametersPowerStatusOn = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersDoorStatus) {
    PPDeviceParametersDoorStatusClosed = 0,
    PPDeviceParametersDoorStatusOpen = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersVibrationStatus) {
    PPDeviceParametersVibrationStatusStill = 0,
    PPDeviceParametersVibrationStatusMoved = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersMotionStatus) {
    PPDeviceParametersMotionStatusNoMotion = 0,
    PPDeviceParametersMotionStatusMotion = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersWaterLeak) {
    PPDeviceParametersWaterLeakDry = 0,
    PPDeviceParametersWaterLeakWet = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersLockStatus) {
    PPDeviceParametersLockStatusUnlocked = 0,
    PPDeviceParametersLockStatusLocked = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersLockStatusAlarm) {
    PPDeviceParametersLockStatusAlarmOK = 0,
    PPDeviceParametersLockStatusAlarmDeadboltJammed = 1,
    PPDeviceParametersLockStatusAlarmLockResetFactoryDefaults = 2,
    PPDeviceParametersLockStatusAlarmRFModulePowerCycled = 3,
    PPDeviceParametersLockStatusAlarmWrongCodeEntryLimit = 4,
    PPDeviceParametersLockStatusAlarmFrontEscutcheonRemoved = 5,
    PPDeviceParametersLockStatusAlarmDoorForcedOpen = 6,
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersButtonStatus) {
    PPDeviceParametersButtonStatusReleased = 0,
    PPDeviceParametersButtonStatusPressed = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersAlarmStatus) {
    PPDeviceParametersAlarmStatusInactive = 0,
    PPDeviceParametersAlarmStatusActive = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersAlarmWarnSmartenit) {
    PPDeviceParametersAlarmWarnSmartenitSecurityDrill = -1,
    PPDeviceParametersAlarmWarnSmartenitStop = 0,
    PPDeviceParametersAlarmWarnSmartenitBurglar = 1,
    PPDeviceParametersAlarmWarnSmartenitFire = 2,
    PPDeviceParametersAlarmWarnSmartenitEmergency = 3,
    PPDeviceParametersAlarmWarnSmartenitChinese1 = 4,
    PPDeviceParametersAlarmWarnSmartenitChinese2 = 5,
    PPDeviceParametersAlarmWarnSmartenitChinese3 = 6,
    PPDeviceParametersAlarmWarnSmartenitChinese4 = 7,
    PPDeviceParametersAlarmWarnSmartenitChinese5 = 8,
    PPDeviceParametersAlarmWarnSmartenitChinese6 = 9,
    PPDeviceParametersAlarmWarnSmartenitChinese7 = 10,
    PPDeviceParametersAlarmWarnSmartenitChinese8 = 13,
    PPDeviceParametersAlarmWarnSmartenitClickOnce = 11,
    PPDeviceParametersAlarmWarnSmartenitClickMulitple = 12,
    PPDeviceParametersAlarmWarnSmartenitNoSound = 14,
    PPDeviceParametersAlarmWarnSmartenitDoorbell = 15
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersAlarmWarnLinkHigh) {
    PPDeviceParametersAlarmWarnLinkHighSecurityDrill = -1,
    PPDeviceParametersAlarmWarnLinkHighAlarm = 1,
    PPDeviceParametersAlarmWarnLinkHighDog = 2,
    PPDeviceParametersAlarmWarnLinkHighWarning = 3,
    PPDeviceParametersAlarmWarnLinkHighBling = 4,
    PPDeviceParametersAlarmWarnLinkHighBird = 5,
    PPDeviceParametersAlarmWarnLinkHighDroid = 6,
    PPDeviceParametersAlarmWarnLinkHighLock = 7,
    PPDeviceParametersAlarmWarnLinkHighPhaser = 8,
    PPDeviceParametersAlarmWarnLinkHighDoorbel = 9,
    PPDeviceParametersAlarmWarnLinkHighGunCock = 10,
    PPDeviceParametersAlarmWarnLinkHighGunShot = 11,
    PPDeviceParametersAlarmWarnLinkHighSwitch = 12,
    PPDeviceParametersAlarmWarnLinkHighTrumpet = 13,
    PPDeviceParametersAlarmWarnLinkHighWhistle = 14
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersAlarmWarnDevelco) {
    PPDeviceParametersAlarmWarnDevelcoSilence = 0,
    PPDeviceParametersAlarmWarnDevelcoBurglar = 1,
    PPDeviceParametersAlarmWarnDevelcoFire = 2,
    PPDeviceParametersAlarmWarnDevelcoEmergency = 3,
    PPDeviceParametersAlarmWarnDevelcoPanicP = 4,
    PPDeviceParametersAlarmWarnDevelcoPanicF = 5,
    PPDeviceParametersAlarmWarnDevelcoPanicE = 6,
    PPDeviceParametersAlarmWarnDevelcoBeepBeepWelcome = 12,
    PPDeviceParametersAlarmWarnDevelcoBeepWelcome = 13,
    PPDeviceParametersAlarmWarnDevelcoBeepBeep = 14,
    PPDeviceParametersAlarmWarnDevelcoBeep = 15,
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersAlarmDuration) {
    PPDeviceParametersAlarmDurationStop = 0,
    PPDeviceParametersAlarmDurationOnce = 1,
    PPDeviceParametersAlarmDurationPlayForXSeconds = 2
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersAlarmStrobe) {
    PPDeviceParametersAlarmStrobeOff = 0,
    PPDeviceParametersAlarmStrobeOn = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersAlarmSquawk) {
    PPDeviceParametersAlarmSquawkArmed = 0,
    PPDeviceParametersAlarmSquawkDisarmed = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersAlarmLevel) {
    PPDeviceParametersAlarmLevelLow       = 0,
    PPDeviceParametersAlarmLevelMedium    = 1,
    PPDeviceParametersAlarmLevelHigh      = 2,
    PPDeviceParametersAlarmLevelVeryHight = 3
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersIBeaconStatus) {
    PPDeviceParametersIBeaconStatusOn = 0,
    PPDeviceParametersIBeaconStatusOff = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersIBeaconProximity) {
    PPDeviceParametersIBeaconProximityUnknown = 0,
    PPDeviceParametersIBeaconProximityImmediate = 1,
    PPDeviceParametersIBeaconProximityNear = 2,
    PPDeviceParametersIBeaconProximityFar = 3
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersSigStatus) {
    PPDeviceParametersSigStatusOff = 0,
    PPDeviceParametersSigStatusOn = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersSigCurMaxLed) {
    PPDeviceParametersSigCurMaxLedNone = 0,
    PPDeviceParametersSigCurMaxLedOK = 3,
    PPDeviceParametersSigCurMaxLedWarning = 4,
    PPDeviceParametersSigCurMaxLedBlocked = 5
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersNamHealthIdx) {
    PPDeviceParametersNamHealthIdxHealthy = 0,
    PPDeviceParametersNamHealthIdxFine = 1,
    PPDeviceParametersNamHealthIdxFair = 2,
    PPDeviceParametersNamHealthIdxPoor = 3,
    PPDeviceParametersNamHealthIdxUnhealthy = 4
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersSelectedCamera) {
    PPDeviceParametersSelectedCameraFront = 0,
    PPDeviceParametersSelectedCameraRear = 1,
    PPDeviceParametersSelectedCameraRearOnly = 2,
    PPDeviceParametersSelectedCameraNone = 3,
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersAccessCameraSettings) {
    PPDeviceParametersAccessCameraSettingsOff = 0,
    PPDeviceParametersAccessCameraSettingsOn = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersAudioStreaming) {
    PPDeviceParametersAudioStreamingOff = 0,
    PPDeviceParametersAudioStreamingOn = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersVideoStreaming) {
    PPDeviceParametersVideoStreamingOff = 0,
    PPDeviceParametersVideoStreamingOn = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersHDStatus) {
    PPDeviceParametersHDStatusOff = 0,
    PPDeviceParametersHDStatusOn = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersRapidMotionStatus) {
    PPDeviceParametersRapidMotionStatusMinProVideo = 60,
    PPDeviceParametersRapidMotionStatusMin = 300,
    PPDeviceParametersRapidMotionStatusDefault = 1800,
    PPDeviceParametersRapidMotionStatusMax = 3600
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersBatteryLevel) {
    PPDeviceParametersBatteryLevelDead = 0,
    PPDeviceParametersBatteryLevelFull = 100
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersCharging) {
    PPDeviceParametersChargingFalse = 0,
    PPDeviceParametersChargingTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersCameraMotionStatus) {
    PPDeviceParametersCameraMotionStatusDisabledByRule = -1,
    PPDeviceParametersCameraMotionStatusDisabled = 0,
    PPDeviceParametersCameraMotionStatusEnabled = 1,
    PPDeviceParametersCameraMotionStatusEnabledByRule = 2,
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersAudioStatus) {
    PPDeviceParametersAudioStatusNoAudio = 0,
    PPDeviceParametersAudioStatusAudio = 1,
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersAutoFocus) {
    PPDeviceParametersAutoFocusShouldFocus = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersRecordSeconds) {
    PPDeviceParametersRecordSecondsMinimum = 5,
    PPDeviceParametersRecordSecondsDefault = 30,
    PPDeviceParametersRecordSecondsMaximum = 60,
    PPDeviceParametersRecordSecondsMaximumProVideo = 300
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersMotionSensitiviy) {
    PPDeviceParametersMotionSensitiviyTiny = 0,
    PPDeviceParametersMotionSensitiviySmall = 10,
    PPDeviceParametersMotionSensitiviyNormal = 20,
    PPDeviceParametersMotionSensitiviyLarge = 30,
    PPDeviceParametersMotionSensitiviyHuge = 40
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersAudioSensitiviy) {
    PPDeviceParametersAudioSensitiviyTiny = 0,
    PPDeviceParametersAudioSensitiviySmall = 10,
    PPDeviceParametersAudioSensitiviyNormal = 20,
    PPDeviceParametersAudioSensitiviyLarge = 30,
    PPDeviceParametersAudioSensitiviyHuge = 40
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersRobotConnected) {
    PPDeviceParametersRobotConnectedNone = 0,
    PPDeviceParametersRobotConnectedGalileo = 1,
    PPDeviceParametersRobotConnectedKubi = 2,
    PPDeviceParametersRobotConnectedRomo = 3,
    PPDeviceParametersRobotConnectedGalileoBT = 4,
    PPDeviceParametersRobotConnected360 = 5,
    PPDeviceParametersRobotConnectedUnknown = 6
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersRobotMotionDirection) {
    PPDeviceParametersRobotMotionDirectionAll = 0,
    PPDeviceParametersRobotMotionDirectionRight = 10,
    PPDeviceParametersRobotMotionDirectionLeft = 20,
    PPDeviceParametersRobotMotionDirectionUp = 30,
    PPDeviceParametersRobotMotionDirectionDown = 40
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersRobotVantageConfigurationStatus) {
    PPDeviceParametersRobotVantageConfigurationStatusHardReset = -5,
    PPDeviceParametersRobotVantageConfigurationStatusWarmReset = -4,
    PPDeviceParametersRobotVantageConfigurationStatusResetUART = -3,
    PPDeviceParametersRobotVantageConfigurationStatusResetUARTQueue = -2,
    PPDeviceParametersRobotVantageConfigurationStatusRebootMotorControlBoard = -1,
    PPDeviceParametersRobotVantageConfigurationStatusReady = 0,
    PPDeviceParametersRobotVantageConfigurationStatusConfigureVantage = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersRobotOrientation) {
    PPDeviceParametersRobotOrientationShouldFlip = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersTwitterAutoShare) {
    PPDeviceParametersTwitterAutoShareOff = 0,
    PPDeviceParametersTwitterAutoShareOn = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersTwitterReminder) {
    PPDeviceParametersTwitterReminderOff = 0,
    PPDeviceParametersTwitterReminderOn = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersTwitterStatus) {
    PPDeviceParametersTwitterStatusOff = 0,
    PPDeviceParametersTwitterStatusOn = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersMotionCountDownTime) {
    PPDeviceParametersMotionCountDownTimeMinimum = 5,
    PPDeviceParametersMotionCountDownTimeDefault = 30,
    PPDeviceParametersMotionCountDownTimeMaximum = 60
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersBlackoutScreenOn) {
    PPDeviceParametersBlackoutScreenOnOff = 0,
    PPDeviceParametersBlackoutScreenOnOn = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersMotionActivity) {
    PPDeviceParametersMotionActivityNone = 0,
    PPDeviceParametersMotionActivityDetected = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersAudioActivity) {
    PPDeviceParametersAudioActivityNone = 0,
    PPDeviceParametersAudioActivityDetected = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersOutputVolume) {
    PPDeviceParametersOutputVolumeMuted = 0,
    PPDeviceParametersOutputVolumeMax = 16
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersRecordStatus) {
    PPDeviceParametersRecordStatusNotRecording = 0,
    PPDeviceParametersRecordStatusRecording = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersWarningStatus) {
    PPDeviceParametersWarningStatusOff = 0,
    PPDeviceParametersWarningStatusOn = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersRecordFullDuration) {
    PPDeviceParametersRecordFullDurationOff = 0,
    PPDeviceParametersRecordFullDurationOn = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersSupportsVideoCall) {
    PPDeviceParametersSupportsVideoCallFalse = 0,
    PPDeviceParametersSupportsVideoCallTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersFlashOn) {
    PPDeviceParametersFlashOnNoFlash = -1,
    PPDeviceParametersFlashOnOff = 0,
    PPDeviceParametersFlashOnOn = 1,
    PPDeviceParametersFlashOnWasOn = 2
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersSelectedFlash) {
    PPDeviceParametersSelectedFlashNone = -1,
    PPDeviceParametersSelectedFlashOff = 0,
    PPDeviceParametersSelectedFlashOn = 1,
    PPDeviceParametersSelectedFlashWasOn = 2,
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersCaptureImage) {
    PPDeviceParametersCaptureImageDisabled = -1,
    PPDeviceParametersCaptureImageEnabled = 0,
    PPDeviceParametersCaptureImageAlert = 1,
    PPDeviceParametersCaptureImageNoAlert = 2,
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersAlarm) {
    PPDeviceParametersAlarmOff = 0,
    PPDeviceParametersAlarmOn = 0x1,
    PPDeviceParametersAlarmBeep1 = 0x2,
    PPDeviceParametersAlarmBeep2 = 0x3,
    PPDeviceParametersAlarmBeep3 = 0x4,
    
    // 0x5 through 0x0FFF represent "Beep for this many seconds" starting at a rate of 1 beep every 2 seconds, and steadily increasing to a rate of 1 beep every 100 ms
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersCountdown) {
    PPDeviceParametersCountdownOff = -1,
    PPDeviceParametersCountdownOffAndClose = 0,
    PPDeviceParametersCountdownOn = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersVisualCountdown) {
    PPDeviceParametersVisualCountdownOff = 0,
    PPDeviceParametersVisualCountdownOn = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersAlertDuration) {
    PPDeviceParametersAlertDurationNone = -1,
    PPDeviceParametersAlertDurationDefault = 30
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersAlertPriority) {
    PPDeviceParametersAlertPriorityNone = -1,
    PPDeviceParametersAlertPriorityDebug = 0,
    PPDeviceParametersAlertPriorityInfo = 1,
    PPDeviceParametersAlertPriorityWarning = 2,
    PPDeviceParametersAlertPriorityCritical = 3
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersAlertStatus) {
    PPDeviceParametersAlertStatusNone = 0,
    PPDeviceParametersAlertStatusAlerting = 1,
    PPDeviceParametersAlertStatusDismissed = 2
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersNetType) {
    PPDeviceParametersNetTypeEthernet = 1,
    PPDeviceParametersNetTypeWiFi     = 2,
    PPDeviceParametersNetTypeCellular = 3
};

typedef NS_OPTIONS(NSInteger, PPDeviceParametersIlluminance) {
    PPDeviceParametersIlluminanceDark       = 0,
    PPDeviceParametersIlluminanceDim        = 20,
    PPDeviceParametersIlluminanceLight      = 50,
    PPDeviceParametersIlluminanceBright     = 250,
    PPDeviceParametersIlluminanceVeryBright = 100000
};

typedef NS_OPTIONS(NSInteger, PPDeviceCommandId) {
    PPDeviceCommandIdNone = -1,
};

typedef NS_OPTIONS(NSInteger, PPDeviceCommandResult) {
    PPDeviceCommandResultNone = -1,
};

typedef NS_OPTIONS(NSInteger, PPDeviceCommandType) {
    PPDeviceCommandTypeNone = -1,
    PPDeviceCommandTypeSet = 0,
    PPDeviceCommandTypeDelete = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceCommandTimeout) {
    PPDeviceCommandTimeoutNone = -1,
    PPDeviceCommandTimeoutDefault = 60
};

typedef NS_OPTIONS(NSInteger, PPDeviceDataRequestType) {
    PPDeviceDataRequestTypeParameters = 1, // Device Parameters
    PPDeviceDataRequestTypeActivities = 2
};

typedef NS_OPTIONS(NSInteger, PPDeviceDataRequestOdered) {
    PPDeviceDataRequestOderedNone = -2,
    PPDeviceDataRequestOderedDesc = -1,
    PPDeviceDataRequestOderedAsc  = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceDataRequestCompression) {
    PPDeviceDataRequestCompressionNone          = -1,
    PPDeviceDataRequestCompressionLZ4           = 0, // Default
    PPDeviceDataRequestCompressionZIP           = 1,
    PPDeviceDataRequestCompressionNoCompression = 2
};

// MARK: - Communications
// MARK: Notification

typedef NS_OPTIONS(NSInteger, PPNotificationSubscriptionType) {
    PPNotificationSubscriptionTypeNone = -1,
    PPNotificationSubscriptionTypeAll = 0, // Email and Push; Configurable;
    PPNotificationSubscriptionTypeMarketing = 1, // Email; Configurable;
    PPNotificationSubscriptionTypeDeviceSharing = 2, // Email and Push; Configurable;
    PPNotificationSubscriptionTypeOrganizations = 3, // Email and Push;
    PPNotificationSubscriptionTypeAnalytics = 4, // Email and Push; Configurable;
    PPNotificationSubscriptionTypeQuestions = 5, // Email and Push; Configurable;
    PPNotificationSubscriptionTypeUserAccountCreationFollowup = 6, // Email;
    PPNotificationSubscriptionTypeDeviceAlerts = 7, // Email and Push; Configurable;
    PPNotificationSubscriptionTypeExternalNotifications = 8, // Email and Push; Configurable;
    PPNotificationSubscriptionTypeInAppMessage = 9, // Push;
    PPNotificationSubscriptionTypeNewDeviceAdded = 10, // Push;
    PPNotificationSubscriptionTypeAccountIssues = 11, // Push;
    PPNotificationSubscriptionTypeAddingFriends = 12, // Email and Push;
    PPNotificationSubscriptionTypeNotificationByOAuthClient = 13, // Email and Push; Configurable;
    PPNotificationSubscriptionTypeAddingCircleMembers = 15, // Email and Push;
    PPNotificationSubscriptionTypeDeviceFirmwareUpdate = 16, // Push;
    PPNotificationSubscriptionTypeSMSSubscription = 17, // Push;
    PPNotificationSubscriptionTypeErrorsWithOAuthApps = 18, // Push;
    PPNotificationSubscriptionTypeBotErrorsToDevelopers = 19, // Email;
    PPNotificationSubscriptionTypeAppBadgeChange = 20 // Push;
};

typedef NS_OPTIONS(NSInteger, PPNotificationSubscriptionEmailEnabled) {
    PPNotificationSubscriptionEmailEnabledNone = -1,
    PPNotificationSubscriptionEmailEnabledFalse = 0,
    PPNotificationSubscriptionEmailEnabledTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPNotificationSubscriptionPushEnabled) {
    PPNotificationSubscriptionPushEnabledNone = -1,
    PPNotificationSubscriptionPushEnabledFalse = 0,
    PPNotificationSubscriptionPushEnabledTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPNotificationSubscriptionSMSEnabled) {
    PPNotificationSubscriptionSMSEnabledNone = -1,
    PPNotificationSubscriptionSMSEnabledFalse = 0,
    PPNotificationSubscriptionSMSEnabledTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPNotificationSubscriptionEmailPeriod) {
    PPNotificationSubscriptionEmailPeriodNone = -1,
    PPNotificationSubscriptionEmailPeriodAllTheTime = 0
};

typedef NS_OPTIONS(NSInteger, PPNotificationSubscriptionPushPeriod) {
    PPNotificationSubscriptionPushPeriodNone = -1,
    PPNotificationSubscriptionPushPeriodAllTheTime = 0
};

typedef NS_OPTIONS(NSInteger, PPNotificationSubscriptionSMSPeriod) {
    PPNotificationSubscriptionSMSPeriodNone = -1,
    PPNotificationSubscriptionSMSPeriodAllTheTime = 0
};

typedef NS_OPTIONS(NSInteger, PPNotificationSubscriptionSupportsBadgeIcons) {
    PPNotificationSubscriptionSupportsBadgeIconsNone = -1,
    PPNotificationSubscriptionSupportsBadgeIconsFalse = 0,
    PPNotificationSubscriptionSupportsBadgeIconsTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPNotificationDeliveryType) {
    PPNotificationDeliveryTypeNone = -1,
    PPNotificationDeliveryTypePushNotification = 1,
    PPNotificationDeliveryTypeEmail = 2,
    PPNotificationDeliveryTypeSMS = 3,
};

typedef NS_OPTIONS(NSInteger, PPNotificationSourceType) {
    PPNotificationSourceTypeNone = -1,
    PPNotificationSourceTypeExternalAPICall = 0,
    PPNotificationSourceTypeRule = 1,
    PPNotificationSourceTypeBot = 2,
    PPNotificationSourceTypeDeviceFirmwareUpdate = 4,
    PPNotificationSourceTypeInternalSystemLogic = 5,
    PPNotificationSourceTypeCloudBusinessLogic = 6
};

typedef NS_OPTIONS(NSInteger, PPNotificationSourceId) {
    PPNotificationSourceIdNone = -1
};

typedef NS_OPTIONS(NSInteger, PPNotificationSentCount) {
    PPNotificationSentCountNone = -1
};

// MARK: Messages

typedef NS_OPTIONS(NSInteger, PPNotificationPushMessageType) {
    PPNotificationPushMessageTypeNone = -1,
    PPNotificationPushMessageTypeDefault = 0
};

typedef NS_OPTIONS(NSInteger, PPNotificationEmailMessageHTML) {
    PPNotificationEmailMessageHTMLNone = -1,
    PPNotificationEmailMessageHTMLFalse = 0,
    PPNotificationEmailMessageHTMLTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPNotificationSMSMessageCategory) {
    PPNotificationSMSMessageCategoryDefault = 0
};

typedef NS_OPTIONS(NSInteger, PPNotificationSMSMessageIndividual) {
    PPNotificationSMSMessageIndividualNone = -1,
    PPNotificationSMSMessageIndividualFalse = 0,
    PPNotificationSMSMessageIndividualTrue = 1
};

// MARK: Support Ticket

typedef NS_OPTIONS(NSInteger, PPSupportTicketType) {
    PPSupportTicketTypeProblem      = 1,
    PPSupportTicketTypeIncident     = 2,
    PPSupportTicketTypeQuestion     = 3,
    PPSupportTicketTypeTask         = 4,
};

typedef NS_OPTIONS(NSInteger, PPSupportTicketPriority) {
    PPSupportTicketPriorityLow          = 1,
    PPSupportTicketPriorityMedium       = 2,
    PPSupportTicketPriorityHigh         = 3,
    PPSupportTicketPriorityUrgent       = 4,
};

// MARK: Crowd Feedback

typedef NS_OPTIONS(NSInteger, PPCrowdFeedbacksStartPosition) {
    PPCrowdFeedbacksStartPositionNone = -1
};

typedef NS_OPTIONS(NSInteger, PPCrowdFeedbacksLength) {
    PPCrowdFeedbacksLengthNone = -1
};

typedef NS_OPTIONS(NSInteger, PPCrowdFeedbacksDisabled) {
    PPCrowdFeedbacksDisabledNone = -1,
    PPCrowdFeedbacksDisabledFalse = 0,
    PPCrowdFeedbacksDisabledTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPCrowdFeedbackId) {
    PPCrowdFeedbackIdNone = -1
};

typedef NS_OPTIONS(NSInteger, PPCrowdFeedbackType) {
    PPCrowdFeedbackTypeNone = -1,
    PPCrowdFeedbackTypeNewFeatureRequest = 1,
    PPCrowdFeedbackTypeNewProblemReport = 2,
};

typedef NS_OPTIONS(NSInteger, PPCrowdFeedbackProductId) {
    PPCrowdFeedbackProductIdNone = -1
};

typedef NS_OPTIONS(NSInteger, PPCrowdFeedbackProductCategory) {
    PPCrowdFeedbackProductCategoryNone = -1
};

typedef NS_OPTIONS(NSInteger, PPCrowdFeedbackVotingCount) {
    PPCrowdFeedbackVotingCountNone = -1,
    PPCrowdFeedbackVotingCountZero = 0
};

typedef NS_OPTIONS(NSInteger, PPCrowdFeedbackRank) {
    PPCrowdFeedbackRankNone = -1,
    PPCrowdFeedbackRankRemoveVote = 0,
    PPCrowdFeedbackRankCastVote = 1,
};

typedef NS_OPTIONS(NSInteger, PPCrowdFeedbackEnabled) {
    PPCrowdFeedbackEnabledNone = -1,
    PPCrowdFeedbackEnabledFalse = 0,
    PPCrowdFeedbackEnabledTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPCrowdFeedbackTicketId) {
    PPCrowdFeedbackTicketIdNone = -1
};

// MARK: In-App Messaging

typedef NS_OPTIONS(NSInteger, PPInApMessagingStatus) {
    PPInApMessagingStatusNone = -1,
    PPInApMessagingStatusSentMessages = 0,
    PPInApMessagingStatusInboundUnreadMessages = 1,
    PPInApMessagingStatusInboundReadMessages = 2,
    PPInApMessagingStatusAllInboundMessages = 3
};

typedef NS_OPTIONS(NSInteger, PPInAppMessageType) {
    PPInAppMessageTypeNone = -1,
};

typedef NS_OPTIONS(NSInteger, PPInAppMessageEmail) {
    PPInAppMessageEmailNone = -1,
    PPInAppMessageEmailFalse = 0, // Don't deliver this message over email, default
    PPInAppMessageEmailTrue = 1 // Deliver this message over email
};

typedef NS_OPTIONS(NSInteger, PPInAppMessagePush) {
    PPInAppMessagePushNone = -1,
    PPInAppMessagePushFalse = 0, // Don't deliver this message over push notification, default
    PPInAppMessagePushTrue = 1 // Deliver this message over push notification
};

typedef NS_OPTIONS(NSInteger, PPInAppMessageNotReply) {
    PPInAppMessageNotReplyNone = -1,
    PPInAppMessageNotReplyFalse = 0, // Allow replies, default
    PPInAppMessageNotReplyTrue = 1 // Do not allow replies to this thread
};

typedef NS_OPTIONS(NSInteger, PPInAppMessageChallengeId) {
    PPInAppMessageChallengeIdNone = -1
};

typedef NS_OPTIONS(NSInteger, PPInAppMessageChallengeParticipanStatus) {
    PPInAppMessageChallengeParticipanStatusNone = 0,
    PPInAppMessageChallengeParticipanStatusNotResponded = 1 << 0,
    PPInAppMessageChallengeParticipanStatusOptedIn = 1 << 1,
    PPInAppMessageChallengeParticipanStatusOptedOut = 1 << 2
};

typedef NS_OPTIONS(NSInteger, PPInAppMessageId) {
    PPInAppMessageIdNone = -1
};

typedef NS_OPTIONS(NSInteger, PPInAppMessageMessagesRead) {
    PPInAppMessageMessagesReadNone = -1,
    PPInAppMessageMessagesReadFalse = 0,
    PPInAppMessageMessagesReadTrue = 1
};

// MARK: Questions

typedef NS_OPTIONS(NSInteger, PPQuestionsLimit) {
    PPQuestionsLimitNone = -1,
    PPQuestionsLimitUnlimited = 0 // default
};

typedef NS_OPTIONS(NSInteger, PPQuestionsPublic) {
    PPQuestionsPublicNone = -1,
    PPQuestionsPublicFalse = 0,
    PPQuestionsPublicTrue = 1,
};

typedef NS_OPTIONS(NSInteger, PPQuestionId) {
    PPQuestionIdNone = -1
};

typedef NS_OPTIONS(NSInteger, PPQuestionAggregatePublicly) {
    PPQuestionAggregatePubliclyNone = -1,
    PPQuestionAggregatePubliclyFalse = 0,
    PPQuestionAggregatePubliclyTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPQuestionUrgent) {
    PPQuestionUrgentNone = -1,
    PPQuestionUrgentFalse = 0,
    PPQuestionUrgentTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPQuestionFront) {
    PPQuestionFrontNone = -1,
    PPQuestionFrontFalse = 0,
    PPQuestionFrontTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPQuestionEditable) {
    PPQuestionEditableNone = -1,
    PPQuestionEditableFalse = 0,
    PPQuestionEditableTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPQuestionTotalResponses) {
    PPQuestionTotalResponsesNone = -1
};

typedef NS_OPTIONS(NSInteger, PPQuestionSliderMin) {
    PPQuestionSliderMinNone = -1,
    PPQuestionSliderMinDefault = 0
};

typedef NS_OPTIONS(NSInteger, PPQuestionSliderMax) {
    PPQuestionSliderMaxNone = -1,
    PPQuestionSliderMaxDefault = 100
};

typedef NS_OPTIONS(NSInteger, PPQuestionSliderInc) {
    PPQuestionSliderIncNone = -1,
    PPQuestionSliderIncDefault = 1
};

typedef NS_OPTIONS(NSInteger, PPQuestionSectionId) {
    PPQuestionSectionIdNone = -1
};

typedef NS_OPTIONS(NSInteger, PPQuestionWeight) {
    PPQuestionWeightNone = -1
};

typedef NS_OPTIONS(NSInteger, PPQuestionPoints) {
    PPQuestionPointsNone = -1
};

typedef NS_OPTIONS(NSInteger, PPQuestionCollectionWeight) {
    PPQuestionCollectionWeightDefault = 0
};

typedef NS_OPTIONS(NSInteger, PPQuestionCollectionStatus) {
    PPQuestionCollectionStatusNone = -1
};

typedef NS_OPTIONS(NSInteger, PPQuestionCollectionGeneralPublic) {
    PPQuestionCollectionGeneralPublicNone = -1,
    PPQuestionCollectionGeneralPublicFalse = 0,
    PPQuestionCollectionGeneralPublicTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPResponseOptionId) {
    PPResponseOptionIdNone = -1
};

typedef NS_OPTIONS(NSInteger, PPResponseOptionTotal) {
    PPResponseOptionTotalNone = -1
};

typedef NS_OPTIONS(NSInteger, PPQuestionResponseOptionType) {
    PPQuestionResponseOptionTypeNone = -1, // Not set
    PPQuestionResponseOptionTypeBoolean = 1, // The answer is a 0 or 1.
    PPQuestionResponseOptionTypeMulitpleChoiceSingleSelect = 2, // Requires the "responses" array to list the possible responses. Users can only select one response. Available for anonymous aggregated public reporting. The answer is the ID of the response option.
    PPQuestionResponseOptionTypeMulitpleChoiceMultipleSelect = 4, // A list of checkbox options. Requires the "response" array to list the possible response. Users can select multiple responses. Available for anonymous aggregated public reporting. The answer is a bitmask of selected choices.
    PPQuestionResponseOptionTypeDayOfTheWeek = 6, // Day of the week input. The UI can optimize itself for selecting days of the week [Sun][XXX][Tue][Wed][Thu][XXX][Sat]. The answer is a bitmasked value, days can be logically-OR'd together to specify multiple days of the week, ranging from SUN=0x1 to SAT=0x40.
    PPQuestionResponseOptionTypeSlider = 7, // Answer is the number selected. Slider, with a defined minimum and maximum. By default, minimum = 0 and maximum = 100. For time, the answer is in integer seconds.
    PPQuestionResponseOptionTypeTimeInSecondsSinceMidnight = 8, // This accesses the native UI method of declaring a time. The answer is in integer seconds since midnight.
    PPQuestionResponseOptionTypeDateAndTime = 9, // The answer is in xsd:dateTime format, `YYYY-MM-DDThh:mm:ss[Z|(+|-)hh:mm]`
    PPQuestionResponseOptionTypeTextBox = 10 // Open-ended question. For example, if you were to ask, "Who just walked by the camera?". The answer is a string of text.
};

typedef NS_OPTIONS(NSInteger, PPQuestionDisplayType) {
    PPQuestionDisplayTypeNone = -1,
    PPQuestionDisplayTypeDefault = 0 // Display type dependent upon response type.  This is used for placeholder purposes only
};

typedef NS_OPTIONS(NSInteger, PPQuestionDisplayTypeBoolean) {
    PPQuestionDisplayTypeBooleanNone = -1,
    PPQuestionDisplayTypeBooleanOnOff = 0, // On/Off Switch, default
    PPQuestionDisplayTypeBooleanYesNo = 1, // Yes/No Switch
    PPQuestionDisplayTypeBooleanYes = 2, // Single 'Yes' button only, the question's default value is applied to the button's text. Used to trigger bot actions from the UI
    PPQuestionDisplayTypeBooleanPositiveNegativeIcons = 3, // Thumbs UP/DOWN icons.
};

typedef NS_OPTIONS(NSInteger, PPQuestionDisplayTypeMultipleChoiceSingleSelect) {
    PPQuestionDisplayTypeMultipleChoiceSingleSelectNone = -1,
    PPQuestionDisplayTypeMultipleChoiceSingleSelectRadio = 0, // Radio buttons, default. A list of radio buttons.
    PPQuestionDisplayTypeMultipleChoiceSingleSelectDropDown = 1, // Drop-down list / picker. A drop down list. Same as radio buttons, but can contain more items.
    PPQuestionDisplayTypeMultipleChoiceSingleSelectSlider = 2, // Slider.
    PPQuestionDisplayTypeMultipleChoiceSingleSelectAlert = 3, // Alert.
};

typedef NS_OPTIONS(NSInteger, PPQuestionDisplayTypeMultipleChoiceMultiSelect) {
    PPQuestionDisplayTypeMultipleChoiceMultiSelectNone = -1,
    PPQuestionDisplayTypeMultipleChoiceMultiSelectDefault = 0
};

typedef NS_OPTIONS(NSInteger, PPQuestionDisplayTypeDayOfTheWeek) {
    PPQuestionDisplayTypeDayOfTheWeekNone = -1,
    PPQuestionDisplayTypeDayOfTheWeekMultiDay = 0, // Select mulitple days simultaneously.
    PPQuestionDisplayTypeDayOfTheWeekSingleDay = 1, // Pick a single day only.
};

typedef NS_OPTIONS(NSInteger, PPQuestionDisplayTypeSlider) {
    PPQuestionDisplayTypeSliderNone = -1,
    PPQuestionDisplayTypeSliderInteger = 0, // Integer select, default.
    PPQuestionDisplayTypeSliderFloat = 1, // Floating point select.
    PPQuestionDisplayTypeSliderMinutesSeconds = 2, // Minutes:Seconds
};

typedef NS_OPTIONS(NSInteger, PPQuestionDisplayTypeTimeInSecondsSinceMidnight) {
    PPQuestionDisplayTypeTimeInSecondsSinceMidnightNone = -1,
    PPQuestionDisplayTypeTimeInSecondsSinceMidnightHoursMinutesSeconds = 0, // Hours:Minutes:Seconds (am|pm), default.
    PPQuestionDisplayTypeTimeInSecondsSinceMidnightHoursMinutes = 1 // Hours:Minutes (am|pm)
};

typedef NS_OPTIONS(NSInteger, PPQuestionDisplayTypeDateAndTime) {
    PPQuestionDisplayTypeDateAndTimeNone = -1,
    PPQuestionDisplayTypeDateAndTimeDateTime = 0, // Date and time, default.
    PPQuestionDisplayTypeDateAndTimeTime = 1 // Time only.
};

typedef NS_OPTIONS(NSInteger, PPQuestionDisplayTypeTextBox) {
    PPQuestionDisplayTypeTextBoxNone = -1,
    PPQuestionDisplayTypeTextBoxDefault = 0
};

typedef NS_OPTIONS(NSInteger, PPQuestionAnswerStatus) {
    PPQuestionAnswerStatusNone = -1,
    PPQuestionAnswerStatusDelayed = 0, // Delayed, the question will be asked in the future
    PPQuestionAnswerStatusReady = 1, // Ready to be asked, but it is queued
    PPQuestionAnswerStatusAvailable = 2, // Available
    PPQuestionAnswerStatusSkipped = 3, // Skipped, the user is going to answer it later
    PPQuestionAnswerStatusAnswered = 4, // Answered
    PPQuestionAnswerStatusNoAnswer = 5, // No answer, the user is not going to answer on it
};

typedef NS_OPTIONS(NSInteger, PPQuestionAnswerValid) {
    PPQuestionAnswerValidNone = -1,
    PPQuestionAnswerValidFalse = 0,
    PPQuestionAnswerValidTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPQuestionAnswerPoints) {
    PPQuestionAnswerPointsNone = -1
};

typedef NS_OPTIONS(NSInteger, PPQuestionAnswerModified) {
    PPQuestionAnswerModifiedNone = -1,
    PPQuestionAnswerModifiedFalse = 0,
    PPQuestionAnswerModifiedTrue = 1
};

// MARK: SMS Group Texting

typedef NS_OPTIONS(NSInteger, PPSMSSubcriberCommunicationCategory) {
    PPSMSSubcriberCommunicationCategoryNone = -1,
    PPSMSSubcriberCommunicationCategoryMeOnly = 0,
    PPSMSSubcriberCommunicationCategoryGeneralFriends = 1,
    PPSMSSubcriberCommunicationCategoryFamilyCaregivers = 2
};

typedef NS_OPTIONS(NSInteger, PPSMSSubscriberStatus) {
    PPSMSSubscriberStatusNone = -1,
    PPSMSSubscriberStatusSubscribed = 1,
    PPSMSSubscriberStatusOptOut = 2,
    PPSMSSubscriberStatusInvalid = 3, // SMS cannot be sent to this number
};

// MARK: Surveys

typedef NS_OPTIONS(NSInteger, PPSurveyQuestionId) {
    PPSurveyQuestionIdNone = -1
};
typedef NS_OPTIONS(NSInteger, PPSurveyQuestionSliderValue) {
    PPSurveyQuestionSliderValueNone = -1
};

// MARK: - System and User Properties

typedef NS_OPTIONS(NSInteger, PPSystemPropertyPublic) {
    PPSystemPropertyPublicFalse = 0,
    PPSystemPropertyPublicTrue = 1
};

// MARK: - File Management

typedef NS_OPTIONS(NSInteger, PPFileManagementAuthorizationType) {
    PPFileManagementAuthorizationTypeNone = -1,
    PPFileManagementAuthorizationTypeDeviceAuthenticationToken = 0,
    PPFileManagementAuthorizationTypeStreamingSessionId = 1
};

typedef NS_OPTIONS(NSInteger, PPFileOwners) {
    PPFileOwnersNone = -1,
    PPFileOwnersOwnFiles = 1,
    PPFileOwnersSharedFiles = 2,
    PPFileOwnersOwnAndSharedFiles = 3,
    PPFileOwnersOwnDeletedFiles = 4
};

typedef NS_OPTIONS(NSInteger, PPFileRecover) {
    PPFileRecoverNone = -1,
    PPFileRecoverFalse = 0,
    PPFileRecoverTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPFileId) {
    PPFileIdNone = -1
};

typedef NS_OPTIONS(NSInteger, PPFileFilesAction) {
    PPFileFilesActionNone = -1,
    PPFileFilesActionOldFileDeleted = 1,
    PPFileFilesActionNotEnoughSpace = 2
};

typedef NS_OPTIONS(NSInteger, PPFileContent) {
    PPFileContentNone = -1,
    PPFileContentFalse = 0,
    PPFileContentTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPFileThumbnail) {
    PPFileThumbnailNone = -1,
    PPFileThumbnailFalse = 0,
    PPFileThumbnailTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPFileIncomplete) {
    PPFileIncompleteNone = -1,
    PPFileIncompleteFalse = 0,
    PPFileIncompleteTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPFileFragments) {
    PPFileFragmentsNone = -1
};

typedef NS_OPTIONS(NSInteger, PPFileFragmentIndex) {
    PPFileFragmentIndexNone = -1
};

typedef NS_OPTIONS(signed long long, PPFileTotalFileSpace) {
    PPFileTotalFileSpaceNone = -1
};

typedef NS_OPTIONS(signed long long, PPFileUsedFileSpace) {
    PPFileUsedFileSpaceNone = -1
};

typedef NS_OPTIONS(NSInteger, PPFileTwitterShare) {
    PPFileTwitterShareNone = -1,
    PPFileTwitterShareFalse = 0,
    PPFileTwitterShareTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPFilePublicAccess) {
    PPFilePublicAccessNone = -1,
    PPFilePublicAccessFalse = 0,
    PPFilePublicAccessTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPFileAttach) {
    PPFileAttachNone = -1,
    PPFileAttachFalse = 0,
    PPFileAttachTrue = 1
};

typedef NS_OPTIONS(long long, PPFileSize) {
    PPFileSizeNone = -1
};

typedef NS_OPTIONS(NSInteger, PPFileDuration) {
    PPFileDurationNone = -1
};

typedef NS_OPTIONS(NSInteger, PPFileShared) {
    PPFileSharedNone = -1,
    PPFileSharedCurrentUserFileNotShared = 0,
    PPFileSharedSharedUserFileNotDeletable = 1,
    PPFileSharedSharedUserFileDeletable = 2
};

typedef NS_OPTIONS(NSInteger, PPFileRotate) {
    PPFileRotateNone = -1
};

typedef NS_OPTIONS(NSInteger, PPFileViewCount) {
    PPFileViewCountNone = -1
};

typedef NS_OPTIONS(NSInteger, PPFileViewed) {
    PPFileViewedNone = -1,
    PPFileViewedFalse = 0,
    PPFileViewedTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPFileFavourite) {
    PPFileFavouriteNone = -1,
    PPFileFavouriteFalse = 0,
    PPFileFavouriteTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPFileFileType) {
    PPFileFileTypeNone = -1,
    PPFileFileTypeAny = 0,
    PPFileFileTypeVideo = 1,
    PPFileFileTypeImage = 2,
    PPFileFileTypeAudio = 3,
    PPFileFileTypeBitmapMask = 4,
    PPFileFileTypeTextLog = 5
};

typedef NS_OPTIONS(NSInteger, PPFileCount) {
    PPFileCountNone = 0,
};

typedef NS_OPTIONS(NSInteger, PPFileStoragePolicy) {
    PPFileStoragePolicyNone = -1
};

typedef NS_OPTIONS(NSInteger, PPFileUploadUrl) {
    PPFileUploadUrlNone = -1,
    PPFileUploadUrlFalse = 0,
    PPFileUploadUrlTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPFileM3U8) {
    PPFileM3U8None = -1,
    PPFileM3U8False = 0,
    PPFileM3U8True = 1
};

typedef NS_OPTIONS(NSInteger, PPFileURLExpiration) {
    PPFileURLExpirationNone = -1,
    PPFileURLExpirationFalse = 0,
    PPFileURLExpirationTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPFileTagAppId) {
    PPFileTagAppIdNone = -1
};

typedef NS_OPTIONS(NSInteger, PPFileSummaryAggregation) {
    PPFileSummaryAggregationNone = -1,
    PPFileSummaryAggregationHour = 1,
    PPFileSummaryAggregationDay = 2,
    PPFileSummaryAggregationMonth = 3,
    PPFileSummaryAggregationWeek = 4 // 7-day week from Sunday to Saturday
};

typedef NS_OPTIONS(NSInteger, PPFileSummaryDetails) {
    PPFileSummaryDetailsNone = -1,
    PPFileSummaryDetailsFalse = 0,
    PPFileSummaryDetailsTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPFileSummaryTotal) {
    PPFileSummaryTotalNone = -1
};

typedef NS_OPTIONS(long long, PPFileSummarySize) {
    PPFileSummarySizeNone = -1
};

typedef NS_OPTIONS(long long, PPFileSummaryDuration) {
    PPFileSummaryDurationNone = -1
};

typedef NS_OPTIONS(long long, PPFileSummaryViewed) {
    PPFileSummaryViewedNone = -1
};

typedef NS_OPTIONS(long long, PPFileSummaryFavourite) {
    PPFileSummaryFavouriteNone = -1
};

// MARK: - Application Files

typedef NS_OPTIONS(NSInteger, PPApplicationFileId) {
    PPApplicationFileIdNone = -1
};

typedef NS_OPTIONS(NSInteger, PPApplicationFileFileType) {
    PPApplicationFileFileTypeNone = -1,
    PPApplicationFileFileTypeUserImage = 1,
    PPApplicationFileFileTypeLocationImage = 2,
    PPApplicationFileFileTypeDeviceImage = 3,
    PPApplicationFileFileTypeBitmapMask = 4,
    PPApplicationFileFileTypeAny = 5
};

typedef NS_OPTIONS(long long, PPApplicationFileSize) {
    PPApplicationFileSizeNone = -1
};

typedef NS_OPTIONS(NSInteger, PPApplicationFilePublicAccess) {
    PPApplicationFilePublicAccessNone = -1,
    PPApplicationFilePublicAccessFalse = 0,
    PPApplicationFilePublicAccessTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPApplicationFileAttach) {
    PPApplicationFileAttachNone = -1,
    PPApplicationFileAttachFalse = 0,
    PPApplicationFileAttachTrue = 1
};

// MARK: - Rules

typedef NS_OPTIONS(NSInteger, PPRulesVersion) {
    PPRulesVersionNone = -1,
};

typedef NS_OPTIONS(NSInteger, PPRulesDetails) {
    PPRulesDetailsNone = -1,
    PPRulesDetailsFalse = 0, // Only return the high level information about the rule, including the id, description text, on/off status, whether the rule is a default rule, and whether the rule is hidden and not editable, default
    PPRulesDetailsTrue = 1 // Return details for this rule, including all the triggers, states, and actions that compose the rule.
};

typedef NS_OPTIONS(NSInteger, PPRuleId) {
    PPRuleIdNone = -1,
};

typedef NS_OPTIONS(NSInteger, PPRuleStatus) {
    PPRuleStatusNone = -1,
    PPRuleStatusIncomplete = 0,
    PPRuleStatusActive = 1,
    PPRuleStatusInactive = 2
};

typedef NS_OPTIONS(NSInteger, PPRuleHidden) {
    PPRuleHiddenNone = -1,
    PPRuleHiddenFalse = 0,
    PPRuleHiddenTrue = 1,
};

typedef NS_OPTIONS(NSInteger, PPRuleDefault) {
    PPRuleDefaultNone = -1,
    PPRuleDefaultFalse = 0,
    PPRuleDefaultTrue = 1,
};

typedef NS_OPTIONS(NSInteger, PPRuleComponentId) {
    PPRuleComponentIdNone = -1,
};

typedef NS_OPTIONS(NSInteger, PPRuleComponentType) {
    PPRuleComponentTypeNone = -1,
};

typedef NS_OPTIONS(NSInteger, PPRuleComponentDisplayType) {
    PPRuleComponentDisplayTypeNone = -1,
    PPRuleComponentDisplayTypeTriggerSchedule = 11, // This type of trigger is based on a schedule. For example, "If the time is 8:00 PM on school nights".
    PPRuleComponentDisplayTypeTriggerEvent = 12, // Location event, such as 'HOME', 'AWAY', etc.
    PPRuleComponentDisplayTypeTriggerDeviceAlert = 13, // Device alert like "motion detected"
    PPRuleComponentDisplayTypeTriggerNewDeviceData = 14, // Measurements
    PPRuleComponentDisplayTypeTriggerCountdown = 15, // Check, if something did not happen in specified period of time
    PPRuleComponentDisplayTypeStateGeneralCondition = 21, // Type 21 simply means this phrase is a state condition. This is the only 'type' field available for a state.
    PPRuleComponentDisplayTypeStateLocation = 22, // This phrase is to say "I am home" or "I am away"
    PPRuleComponentDisplayTypeStateDeviceParameter = 23, // This phrase is to specify a state for a device parameter, such as "temperature is greater than 73 degrees Fahrenheit" for example.
    PPRuleComponentDisplayTypeActionPushNotification = 31, // Send a push notification to the user
    PPRuleComponentDisplayTypeActionEmail = 32, // Send an email notification to the user
    PPRuleComponentDisplayTypeActionSendCommand = 33, // Send a command to a device
    PPRuleComponentDisplayTypeActionEvent = 34, // Set a new location event, such as 'HOME', 'AWAY', etc.
    PPRuleComponentDisplayTypeActionCallCenter = 35,
};

typedef NS_OPTIONS(NSInteger, PPRuleComponentTimezone) {
    PPRuleComponentTimezoneNone = -1,
    PPRuleComponentTimezoneFalse = 0,
    PPRuleComponentTimezoneTrue = 1,
};

typedef NS_OPTIONS(NSInteger, PPRuleComponentStateType) {
    PPRuleComponentStateTypeState = 0,
    PPRuleComponentStateTypeAnd = 1,
    PPRuleComponentStateTypeOr = 2
};

typedef NS_OPTIONS(NSInteger, PPRuleComponentParameterCategory) {
    PPRuleComponentParameterCategoryNone = -1,
    PPRuleComponentParameterCategoryUserInputRequired = 1, // This parameter in a rule phrase requires some user input to define
    PPRuleComponentParameterCategoryCronExpression = 2, // This parameter will fire periodically, based on a cron job
    PPRuleComponentParameterCategoryLocationID = 4, // This parameter requires the user to specify a location
    PPRuleComponentParameterCategoryDeviceID = 5, // This parameter requires a device
    PPRuleComponentParameterCategoryIndex = 6, // This parameter requires the user to specify a part of a device (i.e. Socket 0, Socket 1, Socket 2, etc.)
    PPRuleComponentParameterCategoryTime = 7, // This parameter fires at a specific time
    PPRuleComponentParameterCategoryDayOfWeek = 8, // This parameter fires on certain days
    PPRuleComponentParameterCategoryLocationEvent = 9, // Location event, such as 'HOME', 'AWAY', etc.
    PPRuleComponentParameterCategoryNotificationText = 10, // This parameter requires the notification text to send to the user, which is generated by the UI with optional help from the individual rule phrases.
    PPRuleComponentParameterCategoryParameterName = 11, // Specify a parameter name from the device
    PPRuleComponentParameterCategoryPropertyName = 12, // Specify a property name from the device
    PPRuleComponentParameterCategoryEnumeration = 13, // A list of id/name pairs
    PPRuleComponentParameterCategoryAppName = 14, // Application name
    PPRuleComponentParameterCategorySelectingEnumeration = 15, // A list of id/name pairs selecting by other parameter value
};

typedef NS_OPTIONS(NSInteger, PPRuleComponentParameterInputType) {
    PPRuleComponentParameterInputTypeNone = -1,
    PPRuleComponentParameterInputTypeInteger = 1, // Present the user input as an integer
    PPRuleComponentParameterInputTypeFloat = 2, // Present the user input as a float
};

typedef NS_OPTIONS(NSInteger, PPRuleComponentParameterOptional) {
    PPRuleComponentParameterOptionalNone = -1,
    PPRuleComponentParameterOptionalFalse = 0,
    PPRuleComponentParameterOptionalTrue = 1,
};

typedef NS_OPTIONS(NSInteger, PPRuleComponentParameterMinValue) {
    PPRuleComponentParameterMinValueNone = -1,
};

typedef NS_OPTIONS(NSInteger, PPRuleComponentParameterMaxValue) {
    PPRuleComponentParameterMaxValueNone = -1,
};

typedef NS_OPTIONS(NSInteger, PPRuleCalendarInclude) {
    PPRuleCalendarIncludeNone = -1,
    PPRuleCalendarIncludeFalse = 0,
    PPRuleCalendarIncludeTrue = 1,
};

typedef NS_OPTIONS(NSInteger, PPRuleCalendarTime) {
    PPRuleCalendarTimeNone = -1,
};

typedef NS_OPTIONS(NSInteger, PPRuleCalendarDaysOfWeek) {
    PPRuleCalendarDaysOfWeekNone      = 0,
    PPRuleCalendarDaysOfWeekSunday    = 1 << 0,
    PPRuleCalendarDaysOfWeekMonday    = 1 << 1,
    PPRuleCalendarDaysOfWeekTuesday   = 1 << 2,
    PPRuleCalendarDaysOfWeekWednesday = 1 << 3,
    PPRuleCalendarDaysOfWeekThursday  = 1 << 4,
    PPRuleCalendarDaysOfWeekFriday    = 1 << 5,
    PPRuleCalendarDaysOfWeekSaturday  = 1 << 6,
};

// MARK: - Paid Services

typedef NS_OPTIONS(NSInteger, PPPaidServicesResultCode) {
    PPPaidServicesResultCodeSuccess = 0,
    PPPaidServicesResultCodeReceiptNotFound = 6,
    PPPaidServicesResultCodeReceiptAlreadySubmittedByDifferentUser = 7,
    PPPaidServicesResultCodeReceiptInvalidOrExpired = 8,
    PPPaidServicesResultCodeReceiptAlreadySubmitted = 26
};

typedef NS_OPTIONS(NSInteger, PPPaidServicesServicePaymentType) {
    PPPaidServicesServicePaymentTypeNone = -1,
    PPPaidServicesServicePaymentTypeBraintree = 3
};

typedef NS_OPTIONS(NSInteger, PPPaidServicesHiddenPrices) {
    PPPaidServicesHiddenPricesNone = -1,
    PPPaidServicesHiddenPricesFalse = 0,
    PPPaidServicesHiddenPricesTrue = 1,
};

typedef NS_OPTIONS(NSInteger, PPServicePlanId) {
    PPServicePlanIdNone = -1,
};

typedef NS_OPTIONS(NSInteger, PPServicePlanAvailable) {
    PPServicePlanAvailableNone = -1,
    PPServicePlanAvailableFalse = 0,
    PPServicePlanAvailableTrue
};

typedef NS_OPTIONS(NSInteger, PPServicePlanSubscribed) {
    PPServicePlanSubscribedNone = -1,
    PPServicePlanSubscribedFalse = 0,
    PPServicePlanSubscribedTrue
};

typedef NS_OPTIONS(NSInteger, PPServicePlanStatus) {
    PPServicePlanStatusNone = -2,
    PPServicePlanStatusInitial = -1,
    PPServicePlanStatusActive = 0,
    PPServicePlanStatusExpiredOrCanceled = 1
};

typedef NS_OPTIONS(NSInteger, PPServicePlanPriceId) {
    PPServicePlanPriceIdNone = -1,
};

typedef NS_OPTIONS(NSInteger, PPServicePlanSoftwareSubscriptionUserPlanId) {
    PPServicePlanSoftwareSubscriptionUserPlanIdNone = -1
};

typedef NS_OPTIONS(NSInteger, PPServicePlanSoftwareSubscriptionType) {
    PPServicePlanSoftwareSubscriptionTypeNone = -1,
    PPServicePlanSoftwareSubscriptionTypeOneTimePurchase = 1,
    PPServicePlanSoftwareSubscriptionTypeWeeklySubscription = 2,
    PPServicePlanSoftwareSubscriptionTypeMonthlySubscription = 3,
    PPServicePlanSoftwareSubscriptionTypeAnnualSubscription = 4,
};

typedef NS_OPTIONS(NSInteger, PPServicePlanSoftwareSubscriptionPaymentType) {
    PPServicePlanSoftwareSubscriptionPaymentTypeNone = 1,
    PPServicePlanSoftwareSubscriptionPaymentTypeManual = 0,
    PPServicePlanSoftwareSubscriptionPaymentTypeAppleInAppPurchase = 1,
    PPServicePlanSoftwareSubscriptionPaymentTypePaypal = 2,
    PPServicePlanSoftwareSubscriptionPaymentTypeBraintree = 3,
};

typedef NS_OPTIONS(NSInteger, PPServicePlanSoftwareSubscriptionFree) {
    PPServicePlanSoftwareSubscriptionFreeNone = -1,
    PPServicePlanSoftwareSubscriptionFreeFalse = 0,
    PPServicePlanSoftwareSubscriptionFreeTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPServicePlanSoftwareSubscriptionDuration) {
    PPServicePlanSoftwareSubscriptionDurationNone = -1,
};

typedef NS_OPTIONS(NSInteger, PPServicePlanSoftwareSubscriptionSandbox) {
    PPServicePlanSoftwareSubscriptionSandboxNone = -1,
    PPServicePlanSoftwareSubscriptionSandboxFalse = 0,
    PPServicePlanSoftwareSubscriptionSandboxTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPStoreProductId) {
    PPStoreProductIdNone = -1,
};

typedef NS_OPTIONS(NSInteger, PPStoreProductImageHeight) {
    PPStoreProductImageHeightNone = -1,
};

// MARK: - Professional Monitoring

typedef NS_OPTIONS(NSInteger, PPCallCenterStatus) {
    PPCallCenterStatusNone = -1,
    PPCallCenterStatusUnavailable = 0, // The service never purchased
    PPCallCenterStatusAvailable = 1, // The service purchased, but the user does not have enough information for registration
    PPCallCenterStatusRegistration = 2, // pending    The registration process has not been completed yet
    PPCallCenterStatusRegistered = 3, // Registration completed
    PPCallCenterStatusCancellation = 4, // pending    The cancellation has not been completed yet
    PPCallCenterStatusCanceled = 5, // Cancellation completed
};

typedef NS_OPTIONS(NSInteger, PPCallCenterAlertStatus) {
    PPCallCenterAlertStatusNone = -1,
    PPCallCenterAlertStatusDefault = 0, // An alert never raised
    PPCallCenterAlertStatusRaised = 1, // An alert raised, but the call center not contacted yet
    PPCallCenterAlertStatusReported = 3, // The alert reported to the call center
};

typedef NS_OPTIONS(NSInteger, PPCallCenterContactPhoneType) {
    PPCallCenterContactPhoneTypeNone = -1,
    PPCallCenterContactPhoneTypeUnknown = 0,
    PPCallCenterContactPhoneTypeCell = 1,
    PPCallCenterContactPhoneTypeHome = 2,
    PPCallCenterContactPhoneTypeWork = 3,
    PPCallCenterContactPhoneTypeOffice = 4
};

typedef NS_OPTIONS(NSInteger, PPCallCenterAlertSourceType) {
    PPCallCenterAlertSourceTypeNone = 1,
    PPCallCenterAlertSourceTypeUnknown = 0, // Unknown
    PPCallCenterAlertSourceTypeRule = 1, // Raised by a rule
    PPCallCenterAlertSourceTypeBotengine = 2, // Raised by a botengine app
    PPCallCenterAlertSourceTypeApp = 3, // Raised by an app API
};

// MARK: - Dynamic User Interfaces

typedef NS_OPTIONS(NSInteger, PPDynamicUILocationTotalsType) {
    PPDynamicUILocationTotalsTypeAll = -1,
    PPDynamicUILocationTotalsTypeDevices = 1 << 0,
    PPDynamicUILocationTotalsTypeFiles = 1 << 1,
    PPDynamicUILocationTotalsTypeRules = 1 << 2,
    PPDynamicUILocationTotalsTypeFriends = 1 << 3
};

typedef NS_OPTIONS(NSInteger, PPDynamicUIScreenOrder) {
    PPDynamicUIScreenOrderNone = -1,
};

typedef NS_OPTIONS(NSInteger, PPDynamicUIScreenSectionOrder) {
    PPDynamicUIScreenSectionOrderNone = -1,
};

typedef NS_OPTIONS(NSInteger, PPDynamicUIScreenSectionItemOrder) {
    PPDynamicUIScreenSectionItemOrderNone = -1,
};

// MARK: - Energy Management

typedef NS_OPTIONS(NSInteger, PPEnergyManagementAggregation) {
    PPEnergyManagementAggregationNone = -1,
    PPEnergyManagementAggregationDoNotSplitData = 0,
    PPEnergyManagementAggregationSplitByHour = 1,
    PPEnergyManagementAggregationSplitByDay = 2,
    PPEnergyManagementAggregationSplitByMonth = 3,
    PPEnergyManagementAggregationSplitOn7DayWeek = 4, // Sunday to Saturday
    PPEnergyManagementAggregationSplitOn5DayWeek = 5, // Monday to Friday, then 2-day weekend
    PPEnergyManagementAggregationSplitByUsersUtilityBillingPeriod = 6,
};

typedef NS_OPTIONS(NSInteger, PPEnergyManagementReducesNoise) {
    PPEnergyManagementReducesNoiseNone = -1,
    PPEnergyManagementReducesNoiseFalse = 0,
    PPEnergyManagementReducesNoiseTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPEnergyManagementBillingInfoFilter) {
    PPEnergyManagementBillingInfoFilterNone = -1,
    PPEnergyManagementBillingInfoFilterGetAllDate = 0,
    PPEnergyManagementBillingInfoFilterGetDataForBillingDate = 1,
    PPEnergyManagementBillingInfoFilterGetDataForBudget = 2,
    PPEnergyManagementBillingInfoFilterGetAllRateInformation = 4,
    PPEnergyManagementBillingInfoFilterGetCurrentBillingRate = 8
};

typedef NS_OPTIONS(NSInteger, PPEnergyManagementUsageExternal) {
    PPEnergyManagementUsageExternalNone = -1,
    PPEnergyManagementUsageExternalPreferExternallyUploadedData = 0, // Default
    PPEnergyManagementUsageExternalPreferInternallyGeneratedData = 1,
    PPEnergyManagementUsageExternalReturnOnlyExternallyUploadedData = 2,
    PPEnergyManagementUsageExternalReturnOnlyInternallyGeneratedData = 3,
    PPEnergyManagementUsageExternalReturnBothInternallyAndExternallyGeneratedData = 4
};

typedef NS_OPTIONS(NSInteger, PPEnergyManagementUtilityBillId) {
    PPEnergyManagementUtilityBillIdNone = -1,
};

typedef NS_OPTIONS(NSInteger, PPEnergyManagementUtilityBillDaysNumber) {
    PPEnergyManagementUtilityBillDaysNumberNone = -1,
};

typedef NS_OPTIONS(NSInteger, PPEnergyManagementBillingInfoBillingDay) {
    PPEnergyManagementBillingInfoBillingDayNone = -1,
};

typedef NS_OPTIONS(NSInteger, PPEnergyManagementBillingInfoBudgetMonth) {
    PPEnergyManagementBillingInfoBudgetMonthNone = -1,
    PPEnergyManagementBillingInfoBudgetMonthJanuary = 1,
    PPEnergyManagementBillingInfoBudgetMonthFebruary = 2,
    PPEnergyManagementBillingInfoBudgetMonthMarch = 3,
    PPEnergyManagementBillingInfoBudgetMonthApril = 4,
    PPEnergyManagementBillingInfoBudgetMonthMay = 5,
    PPEnergyManagementBillingInfoBudgetMonthJune = 6,
    PPEnergyManagementBillingInfoBudgetMonthJuly = 7,
    PPEnergyManagementBillingInfoBudgetMonthAugust = 8,
    PPEnergyManagementBillingInfoBudgetMonthSeptember = 9,
    PPEnergyManagementBillingInfoBudgetMonthOctober = 10,
    PPEnergyManagementBillingInfoBudgetMonthNovember = 11,
    PPEnergyManagementBillingInfoBudgetMonthDecember = 12
};

typedef NS_OPTIONS(NSInteger, PPEnergyManagementBillingInfoUtilityId) {
    PPEnergyManagementBillingInfoUtilityIdNone = -1,
};

typedef NS_OPTIONS(NSInteger, PPEnergyManagementBillingInfoBillingRateId) {
    PPEnergyManagementBillingInfoBillingRateIdNone = -1,
};

typedef NS_OPTIONS(NSInteger, PPEnergyManagementBillingInfoBillingRateType) {
    PPEnergyManagementBillingInfoBillingRateTypeNone = -3,
    PPEnergyManagementBillingInfoBillingRateTypeManual = -2,
    PPEnergyManagementBillingInfoBillingRateTypeUnknown = -1,
    PPEnergyManagementBillingInfoBillingRateTypeResidentialAndCommercial = 0,
    PPEnergyManagementBillingInfoBillingRateTypeResidential = 1,
    PPEnergyManagementBillingInfoBillingRateTypeCommercial = 2
};

typedef NS_OPTIONS(NSInteger, PPEnergyManagementBillingInfoBillingRateTypical) {
    PPEnergyManagementBillingInfoBillingRateTypicalNone = -1,
    PPEnergyManagementBillingInfoBillingRateTypicalFalse = 0,
    PPEnergyManagementBillingInfoBillingRateTypicalTrue = 1
};

// MARK: - Weather

typedef NS_OPTIONS(NSInteger, PPWeatherManagementForecastHours) {
    PPWeatherManagementForecastHoursNone = -1,
    PPWeatherManagementForecastHours6 = 6,
    PPWeatherManagementForecastHours12 = 12,
    PPWeatherManagementForecastHours24 = 24, // default
    PPWeatherManagementForecastHours48 = 48,
};

// MARK: - Products

typedef NS_OPTIONS(NSInteger, PPDeviceTypesOwn) {
    PPDeviceTypesOwnNone = -1,
    PPDeviceTypesOwnFalse = 0,
    PPDeviceTypesOwnTrue = 1,
};

typedef NS_OPTIONS(NSInteger, PPDeviceTypesSimple) {
    PPDeviceTypesSimpleNone = -1,
    PPDeviceTypesSimpleFalse = 0,
    PPDeviceTypesSimpleTrue = 1,
};

typedef NS_OPTIONS(NSInteger, PPDeviceTypesDetails) {
    PPDeviceTypesDetailsNone = -1,
    PPDeviceTypesDetailsFalse = 0,
    PPDeviceTypesDetailsTrue = 1,
};

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
    PPDeviceTypeIdiOSProxy = 28,
    PPDeviceTypeIdAppleHealthKit = 29,
    
    PPDeviceTypeIdAIOXGateway = 31,
    PPDeviceTypeIdDevelcoGatewayDP4X = 32,
    PPDeviceTypeIdAWSIOTGateway = 34,
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
    
    PPDeviceTypeIdVayyarHome = 2000,
    
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
    PPDeviceTypeIdNabtoCamera = 7007,
    
    PPDeviceTypeIdGEInWallSwitch = 9001,
    PPDeviceTypeIdSmartenitSiren = 9002,
    PPDeviceTypeIdGreenPeakHumidityAndTemperatureSensor = 9003,
    
    PPDeviceTypeIdLinkHighSiren = 9009,
    PPDeviceTypeIdDoorLock = 9010,
    PPDeviceTypeIdEWIDButton = 9014,
    PPDeviceTypeIdLargeLoadController = 9017,
    
    PPDeviceTypeIdGEInWallSwitchDimmable = 9018,
    
    PPDeviceTypeIdDevelcoButton = 9101,
    PPDeviceTypeIdDevelcoSiren = 9102,
    PPDeviceTypeIdDevelcoKeypad = 9103,
    PPDeviceTypeIdDevelcoMultiButton = 9106,
    PPDeviceTypeIdDevelcoAirQualitySensor = 9107,
    PPDeviceTypeIdDevelcoHeatSensor = 9108,
    PPDeviceTypeIdDevelcoSmokeAlarm = 9112,
    PPDeviceTypeIdDevelcoDoorWindowSensor = 9114,
    PPDeviceTypeIdDevelcoWatarSensor = 9117,
    PPDeviceTypeIdDevelcoTouchSensor = 9119,
    PPDeviceTypeIdDevelcoHumiditySensor = 9134,
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

typedef NS_OPTIONS(NSInteger, PPDeviceTypeAttributeExtended) {
    PPDeviceTypeAttributeExtendedNone = -1,
    PPDeviceTypeAttributeExtendedFalse = 0,
    PPDeviceTypeAttributeExtendedTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceTypeParameterEditable) {
    PPDeviceTypeParameterEditableNone = -1,
    PPDeviceTypeParameterEditableFalse = 0,
    PPDeviceTypeParameterEditableTrue = 1,
};

typedef NS_OPTIONS(NSInteger, PPDeviceTypeParameterNumeric) {
    PPDeviceTypeParameterNumericNone = -1,
    PPDeviceTypeParameterNumericFalse = 0,
    PPDeviceTypeParameterNumericTrue = 1,
};

typedef NS_OPTIONS(NSInteger, PPDeviceTypeParameterProfiled) {
    PPDeviceTypeParameterProfiledNone = -1,
    PPDeviceTypeParameterProfiledFalse = 0,
    PPDeviceTypeParameterProfiledTrue = 1,
};

typedef NS_OPTIONS(NSInteger, PPDeviceTypeParameterConfigured) {
    PPDeviceTypeParameterConfiguredNone = -1,
    PPDeviceTypeParameterConfiguredFalse = 0,
    PPDeviceTypeParameterConfiguredTrue = 1,
};

typedef NS_OPTIONS(NSInteger, PPDeviceTypeParameterHistorical) {
    PPDeviceTypeParameterHistoricalNone = -1,
    PPDeviceTypeParameterHistoricalCurrentStateOnly = 0,
    PPDeviceTypeParameterHistoricalEvery15Minutes = 1,
    PPDeviceTypeParameterHistoricalAllValues = 2
};

typedef NS_OPTIONS(NSInteger, PPDeviceTypeParameterScale) {
    PPDeviceTypeParameterScaleNone = -1
};

typedef NS_OPTIONS(NSInteger, PPDeviceTypeParameterAdjustment) {
    PPDeviceTypeParameterAdjustmentNone = -1,
    PPDeviceTypeParameterAdjustmentFalse = 0,
    PPDeviceTypeParameterAdjustmentTrue = 1,
};

/**
 * For displayType we're using the same structure as at Questions API (exception is a text box). It's combination of the IDs for general type of the element and it's sub-function.
 * Example: "10" (same as "1") - on/off switch, "91" - single date picker...
 **/
typedef NS_OPTIONS(NSInteger, PPDeviceTypeParameterDisplayType) {
    PPDeviceTypeParameterDisplayTypeNone                    = -1,
    PPDeviceTypeParameterDisplayTypeBoolean                 = 1,  // - Boolean (for parameters with 0/1 values only)
    PPDeviceTypeParameterDisplayTypeBooleanOnOff            = 10, // - on/off switch (default)
    PPDeviceTypeParameterDisplayTypeBooleanYesNo            = 11, // - yes/no checkbox
    PPDeviceTypeParameterDisplayTypeBooleanYes              = 12, // - single "yes" button only as a button
    PPDeviceTypeParameterDisplayTypeSelect                  = 2,  // - Select
    PPDeviceTypeParameterDisplayTypeSelectRadio             = 20, // - radio buttons (default)
    PPDeviceTypeParameterDisplayTypeSelectDropDown          = 21, // - dropdown with options
    PPDeviceTypeParameterDisplayTypeMultiSelect             = 4,  // - Select with multiple choices
    PPDeviceTypeParameterDisplayTypeMultiSelectRadio        = 40, // - checkboxes or multiple-able radio buttons (default)
    PPDeviceTypeParameterDisplayTypeMultiSelectDropDown     = 41, // - dropdown with multiple selection enabled
    PPDeviceTypeParameterDisplayTypeTextbox                 = 5,  // - Textbox (text input)
    PPDeviceTypeParameterDisplayTypeDayOfWeek               = 6,  // - Day of the week
    PPDeviceTypeParameterDisplayTypeDayOfWeekMulti          = 60, // - choose multiple days simultaneously (default)
    PPDeviceTypeParameterDisplayTypeDayOfWeekSingle         = 61, // - pick a single day only
    PPDeviceTypeParameterDisplayTypeSlider                  = 7,  // - Slider (range)
    PPDeviceTypeParameterDisplayTypeSliderInteger           = 70, // - integer selection between min and max (default is 0 to 100, default)
    PPDeviceTypeParameterDisplayTypeSliderFloat             = 71, // - floating point selector (e.g. in a range from 0 to 1)
    PPDeviceTypeParameterDisplayTypeSliderMinutesSeconds    = 72, // - as a minutes:seconds format between a min and max (e.g. from 0 to 5 minutes)
    PPDeviceTypeParameterDisplayTypeTime                    = 8,  // - Time (in seconds)
    PPDeviceTypeParameterDisplayTypeTimeHoursMinutesSeconds = 80, // - as hours:minutes:seconds (am/pm, default)
    PPDeviceTypeParameterDisplayTypeTimeHoursMinutes        = 81, // - as hours:minutes (am/pm)
    PPDeviceTypeParameterDisplayTypeDateTime                = 9,  // - Datetime
    PPDeviceTypeParameterDisplayTypeDateTimePicker          = 90, // - date and time picker (default)
    PPDeviceTypeParameterDisplayTypeDateTimeDateOnly        = 91, // - date only
};

/**
 * Property called valueType is only for frontend specific logic to give an idea how that parameter values should be calculated/processed at UI level.
 **/
typedef NS_OPTIONS(NSInteger, PPDeviceTypeParameterValueType) {
    PPDeviceTypeParameterValueTypeNone          = -1,
    PPDeviceTypeParameterValueTypeAny           = 1, // - Any
    PPDeviceTypeParameterValueTypeNumber        = 2, // - Number
    PPDeviceTypeParameterValueTypeBoolean       = 3, // - Boolean
    PPDeviceTypeParameterValueTypeString        = 4, // - String
    PPDeviceTypeParameterValueTypeArray         = 5, // - Array of any, e.g. [1, "string", 45, true ]
    PPDeviceTypeParameterValueTypeArrayNumeric  = 6, // - Array of numbers, e.g. [1, 3, 77]
    PPDeviceTypeParameterValueTypeArrayString   = 7, // - Array of strings, e.g. ["horn", "bull", "rose"]
    PPDeviceTypeParameterValueTypeObject        = 8, // - Object
};

typedef NS_OPTIONS(NSInteger, PPDeviceTypeRuleComponentTemplateId) {
    PPDeviceTypeRuleComponentTemplateIdNone = -1
};

typedef NS_OPTIONS(NSInteger, PPDeviceTypeRuleComponentTemplateSourceType) {
    PPDeviceTypeRuleComponentTemplateSourceTypeNone = -1,
    PPDeviceTypeRuleComponentTemplateSourceTypeDrools = 0,
    PPDeviceTypeRuleComponentTemplateSourceTypePython = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceTypeRuleComponentTemplateConditionData) {
    PPDeviceTypeRuleComponentTemplateConditionDataNone = -1,
    PPDeviceTypeRuleComponentTemplateConditionDataLocationData = 1 << 0, // Location data, like "HOME" and "AWAY" states.
    PPDeviceTypeRuleComponentTemplateConditionDataDeviceStatus = 1 << 1, // Device status, including the last update date, the last measurement date, the registration date, and whether the device is connected or not.
    PPDeviceTypeRuleComponentTemplateConditionDataDeviceMeasurements = 1 << 2, // Measurements from the device
    PPDeviceTypeRuleComponentTemplateConditionDataLastAlertData = 1 << 3 // The last alert information sent from the device is needed to check the condition of this rule phrase.
};

typedef NS_OPTIONS(NSInteger, PPDeviceTypeGoalId) {
    PPDeviceTypeGoalIdNone = -1
};

typedef NS_OPTIONS(NSInteger, PPDeviceTypeGoalDeviceUsage) {
    PPDeviceTypeGoalDeviceUsageNone = -1
};

typedef NS_OPTIONS(NSInteger, PPDeviceTypeGoalCategories) {
    PPDeviceTypeGoalCategoryNone      = 0,
    PPDeviceTypeGoalCategoryEnergy    = 1 << 0,
    PPDeviceTypeGoalCategorySecurity  = 1 << 1,
    PPDeviceTypeGoalCategoryCare      = 1 << 2,
    PPDeviceTypeGoalCategoryLifestyle = 1 << 3,
    PPDeviceTypeGoalCategoryHealth    = 1 << 4,
    PPDeviceTypeGoalCategoryWellness  = 1 << 5
};

typedef NS_OPTIONS(NSInteger, PPDeviceTypeMediaType) {
    PPDeviceTypeMediaTypeNone = -1,
    PPDeviceTypeMediaTypeVideo = 1,
    PPDeviceTypeMediaTypeImage = 2,
    PPDeviceTypeMediaTypeAudio = 3,
    PPDeviceTypeMediaTypeTextDocument = 4
};

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

typedef NS_OPTIONS(NSInteger, PPDeviceTypeDeviceModelBrandHidden) {
    PPDeviceTypeDeviceModelBrandHiddenNone = -1,
    PPDeviceTypeDeviceModelBrandHiddenFalse = 0,
    PPDeviceTypeDeviceModelBrandHiddenTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceTypeDeviceModelBrandSortId) {
    PPDeviceTypeDeviceModelBrandSortIdNone = -1,
};

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
    PPDeviceTypeStoryTypeBundleV2                           = 9, // Story bundles (kits)
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
    PPDeviceTypeStoryTypeOnboardingApp                      = 50,
    PPDeviceTypeStoryTypeOnboardingPaywall                  = 51,
    PPDeviceTypeStoryTypeOnboardingFeature                  = 52,
};

typedef NS_OPTIONS(NSInteger, PPDeviceTypeStorySortId) {
    PPDeviceTypeStorySortIdNone = -1,
};

typedef NS_OPTIONS(NSInteger, PPDeviceTypeStoryPageIndex) {
    PPDeviceTypeStoryPageIndexNone = -1,
};

typedef NS_OPTIONS(NSInteger, PPDeviceTypeStoryPageDismissible) {
    PPDeviceTypeStoryPageDismissibleNone = -1,
    PPDeviceTypeStoryPageDismissibleFalse = 0,
    PPDeviceTypeStoryPageDismissibleTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceTypeStoryPageHidden) {
    PPDeviceTypeStoryPageHiddenNone = -1,
    PPDeviceTypeStoryPageHiddenFalse = 0,
    PPDeviceTypeStoryPageHiddenTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPDeviceTypeStoryPageActionIndex) {
    PPDeviceTypeStoryPageActionIndexActionNone = -1,
};

typedef NS_OPTIONS(NSInteger, PPDeviceTypeStoryPageActionType) {
    PPDeviceTypeStoryPageActionTypeNone         = -1,
    PPDeviceTypeStoryPageActionTypeStoryLink    = 1, // Link to another story
    PPDeviceTypeStoryPageActionTypeInAppLink    = 2, // In-app link
    PPDeviceTypeStoryPageActionTypeTakePhoto    = 3, // Make photo
    PPDeviceTypeStoryPageActionTypeRecordAudio  = 4, // Record audio
    PPDeviceTypeStoryPageActionTypeOpenContacts = 5, // Open Contacts
    PPDeviceTypeStoryPageActionTypeWiFiConfig   = 6, // Configure WiFi
    PPDeviceTypeStoryPageActionTypeSupport      = 7, // Contact Support
    PPDeviceTypeStoryPageActionTypeScanQR       = 8, // Open QR scanner
};

typedef NS_OPTIONS(NSInteger, PPDeviceTypeStoryPageActionStyle) {
    PPDeviceTypeStoryPageActionStyleNone = -1,
    PPDeviceTypeStoryPageActionStyleButton = 1,
    PPDeviceTypeStoryPageActionStyleLink = 2,
};

// MARK: - Clouds Integration

typedef NS_OPTIONS(NSInteger, PPCloudsIntegrationCloudMicroService) {
    PPCloudsIntegrationCloudMicroServiceNone = -1,
    PPCloudsIntegrationCloudMicroServiceFalse = 0,
    PPCloudsIntegrationCloudMicroServiceTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPCloudsIntegrationCloudMicroServiceRuntime) {
    PPCloudsIntegrationCloudMicroServiceRuntimePython_2_7 = 1,
    PPCloudsIntegrationCloudMicroServiceRuntimePython_3_6 = 2,
    PPCloudsIntegrationCloudMicroServiceRuntimeNodeJS_4_3 = 3
};

typedef NS_OPTIONS(NSInteger, PPCloudsIntegrationCloudMicroServiceVersionStatus) {
    PPCloudsIntegrationCloudMicroServiceVersionStatusDevelopment = 1,
    PPCloudsIntegrationCloudMicroServiceVersionStatusSubmittedForReview = 2,
    PPCloudsIntegrationCloudMicroServiceVersionStatusUnderReview = 3,
    PPCloudsIntegrationCloudMicroServiceVersionStatusPublished = 4,
    PPCloudsIntegrationCloudMicroServiceVersionStatusAdminRejected = 5,
    PPCloudsIntegrationCloudMicroServiceVersionStatusDeveloperRejected = 6,
    PPCloudsIntegrationCloudMicroServiceVersionStatusReplacedByNewerVersion = 7
};

typedef NS_OPTIONS(NSInteger, PPCloudsIntegrationClientApplicationId) {
    PPCloudsIntegrationClientApplicationIdNone = -1,
    PPCloudsIntegrationClientApplicationIdUnknown = 0,
    PPCloudsIntegrationClientApplicationIdSAMI = 1,
    PPCloudsIntegrationClientApplicationIdTwitter = 2,
    PPCloudsIntegrationClientApplicationIdLondonHydro = 3,
    PPCloudsIntegrationClientApplicationIdPresence = 4,
    PPCloudsIntegrationClientApplicationIdLondonHydroTestLab = 5,
    PPCloudsIntegrationClientApplicationIdNetatmo = 6,
    PPCloudsIntegrationClientApplicationIdSensibo = 7,
    PPCloudsIntegrationClientApplicationIdHoneywell = 8,
    PPCloudsIntegrationClientApplicationIdLogitech = 9,
    PPCloudsIntegrationClientApplicationIdEcobee = 10
};

typedef NS_OPTIONS(NSInteger, PPCloudsIntegrationClientActive) {
    PPCloudsIntegrationClientActiveNone = -1,
    PPCloudsIntegrationClientActiveFalse = 0,
    PPCloudsIntegrationClientActiveTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPCloudsIntegrationClientAutoRefresh) {
    PPCloudsIntegrationClientAutoRefreshNone = -1,
    PPCloudsIntegrationClientAutoRefreshFalse = 0,
    PPCloudsIntegrationClientAutoRefreshTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPCloudsIntegrationHostApproved) {
    PPCloudsIntegrationHostApprovedNone = -1,
    PPCloudsIntegrationHostApprovedFalse = 0,
    PPCloudsIntegrationHostApprovedTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPCloudsIntegrationHostAutoRefresh) {
    PPCloudsIntegrationHostAutoRefreshNone = -1,
    PPCloudsIntegrationHostAutoRefreshFalse = 0,
    PPCloudsIntegrationHostAutoRefreshTrue = 1
};

// MARK: - Community

typedef NS_OPTIONS(NSInteger, PPCommunityFileComplete) {
    PPCommunityFileCompleteNone = -1,
    PPCommunityFileCompleteFalse = 0,
    PPCommunityFileCompleteTrue = 1,
};

typedef NS_OPTIONS(NSInteger, PPCommunityPostId) {
    PPCommunityPostIdNone = -1
};

typedef NS_OPTIONS(NSInteger, PPCommunityPostType) {
    PPCommunityPostTypeIndividual = 1,
    PPCommunityPostTypeLocation = 2,
    PPCommunityPostTypeCommunity = 3
};

typedef NS_OPTIONS(NSInteger, PPCommunityPostStatus) {
    PPCommunityPostStatusNone = -1,
    PPCommunityPostStatusInactive = 0,
    PPCommunityPostStatusActive = 1,
    PPCommunityPostStatusRejected = 2
};

typedef NS_OPTIONS(NSInteger, PPCommunityModerator) {
    PPCommunityModeratorNone = -1,
    PPCommunityModeratorFalse = 0,
    PPCommunityModeratorTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPCommunityEventAllDay) {
    PPCommunityEventAllDayNone = -1,
    PPCommunityEventAllDayFalse = 0,
    PPCommunityEventAllDayTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPCommunityReactionType) {
    PPCommunityReactionTypeNone = -1,
    PPCommunityReactionTypeRemove = 0,
    PPCommunityReactionTypeLike = 1,
    PPCommunityReactionTypeLove = 2,
    PPCommunityReactionTypeHaha = 3,
    PPCommunityReactionTypeWow = 4,
    PPCommunityReactionTypeSad = 5,
    PPCommunityReactionTypeAngry = 6,
    PPCommunityReactionTypeFlagged = 7,
};

typedef NS_OPTIONS(NSInteger, PPCommunityCommentId) {
    PPCommunityCommentIdNone = -1
};

// MARK: - Friends

typedef NS_OPTIONS(NSInteger, PPFriendshipId) {
    PPFriendshipIdNone = -1,
};

typedef NS_OPTIONS(NSInteger, PPFriendshipBlocked) {
    PPFriendshipBlockedNone = -1,
    PPFriendshipBlockedFalse = 0,
    PPFriendshipBlockedTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPFriendshipDeviceMute) {
    PPFriendshipDeviceMuteNone = -1,
    PPFriendshipDeviceMuteFalse = 0,
    PPFriendshipDeviceMuteTrue = 1
};

// MARK: - Circles

typedef NS_OPTIONS(NSInteger, PPCircleId) {
    PPCircleIdNone = -1,
};

typedef NS_OPTIONS(NSInteger, PPCircleAdmin) {
    PPCircleAdminNone = -1,
    PPCircleAdminFalse = 0,
    PPCircleAdminTrue = 1,
};

typedef NS_OPTIONS(NSInteger, PPCircleStatus) {
    PPCircleStatusNone = -1,
    PPCircleStatusFreeCircle = 1,
    PPCircleStatusPremiumCircle = 2
};

typedef NS_OPTIONS(long long, PPCircleData) {
    PPCircleDataNone = 0,
};

typedef NS_OPTIONS(NSInteger, PPCircleMemberStatus) {
    PPCircleMemberStatusNone = -1,
    PPCircleMemberStatusInvited = 0,
    PPCircleMemberStatusOptIn = 1,
    PPCircleMemberStatusOptOut = 2
};

typedef NS_OPTIONS(NSInteger, PPCircleMemberAdmin) {
    PPCircleMemberAdminNone = -1,
    PPCircleMemberAdminFalse = 0,
    PPCircleMemberAdminTrue = 1,
};

typedef NS_OPTIONS(NSInteger, PPCircleMemberPhoneStatus) {
    PPCircleMemberPhoneStatusNone = -1,
    PPCircleMemberPhoneStatusUnknown = 0,
    PPCircleMemberPhoneStatusVerified = 1, // verification code sent and verified
    PPCircleMemberPhoneStatusAllowed = 2, // mobile phone number, which can receive SMS, but not verified yet
    PPCircleMemberPhoneStatusInvalid = 3 // invalid phone number
};

typedef NS_OPTIONS(NSInteger, PPCircleFileWidth) {
    PPCircleFileWidthNone = -1,
};

typedef NS_OPTIONS(NSInteger, PPCircleFileHeight) {
    PPCircleFileHeightNone = -1,
};

typedef NS_OPTIONS(NSInteger, PPCirclePostId) {
    PPCirclePostIdNone = -1
};

typedef NS_OPTIONS(NSInteger, PPCirclePostDeleted) {
    PPCirclePostDeletedNone = -1,
    PPCirclePostDeletedFalse = 0,
    PPCirclePostDeletedTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPCirclePostDisplayTime) {
    PPCirclePostDisplayTimeNone = 0
};

typedef NS_OPTIONS(NSInteger, PPCircleReactionType) {
    PPCircleReactionTypeNone = -1,
    PPCircleReactionTypeRemovePreviousReaction = 0,
    PPCircleReactionTypeLike = 1,
    PPCircleReactionTypeLove = 2,
    PPCircleReactionTypeHaHa = 3,
    PPCircleReactionTypeWow = 4,
    PPCircleReactionTypeSad = 5,
    PPCircleReactionTypeAngry = 6
};

// MARK: - Reports

typedef NS_OPTIONS(NSInteger, PPDeviceAlertCount) {
    PPDeviceAlertCountNone = -1,
};

// MARK: - Botengine

typedef NS_OPTIONS(NSInteger, PPBotengineAppCategory) {
    PPBotengineAppCategoryNone      = 0,
    PPBotengineAppCategoryEnergy    = 1 << 0,
    PPBotengineAppCategorySecurity  = 1 << 1,
    PPBotengineAppCategoryCare      = 1 << 2,
    PPBotengineAppCategoryLifestyle = 1 << 3,
    PPBotengineAppCategoryHealth    = 1 << 4,
    PPBotengineAppCategoryWellness  = 1 << 5
};

typedef NS_OPTIONS(NSInteger, PPBotengineAppExecutionTrigger) {
    PPBotengineAppExecutionTriggerNone                       = 0,
    PPBotengineAppExecutionTriggerSchedule                   = 0x01,
    PPBotengineAppExecutionTriggerLocationEvent              = 0x02,
    PPBotengineAppExecutionTriggerDeviceAlert                = 0x04,
    PPBotengineAppExecutionTriggerDeviceMeasurements         = 0x08,
    PPBotengineAppExecutionTriggerQuestionAnswer             = 0x10,
    PPBotengineAppExecutionTriggerDeviceFiles                = 0x20,
    PPBotengineAppExecutionTriggerAlertCountdownTimer        = 0x40,
    PPBotengineAppExecutionTriggerMeasurementsCountdownTimer = 0x80
};

typedef NS_OPTIONS(NSInteger, PPBotengineAppAccessCategory) {
    PPBotengineAppAccessCategoryLocations = 1,
    PPBotengineAppAccessCategoryDeviceFiles = 2,
    PPBotengineAppAccessCategoryCallCenter = 3,
    PPBotengineAppAccessCategoryDevices = 4
};

typedef NS_OPTIONS(NSInteger, PPBotengineAppCommunicationsCategory) {
    PPBotengineAppCommunicationsCategoryMeOnly = 0,
    PPBotengineAppCommunicationsCategoryGeneralFriends = 1,
    PPBotengineAppCommunicationsCategoryCaregivers = 2,
    PPBotengineAppCommunicationsCategoryOrganizationGroup = 3,
    PPBotengineAppCommunicationsCategoryOrganizationAdmins = 4
};

typedef NS_OPTIONS(NSInteger, PPBotengineAppInstanceId) {
    PPBotengineAppInstanceIdNone = -1
};

typedef NS_OPTIONS(NSInteger, PPBotengineAppInstanceStatus) {
    PPBotengineAppInstanceStatusUndefined = -1,
    PPBotengineAppInstanceStatusIncomplete = 0,
    PPBotengineAppInstanceStatusActive     = 1,
    PPBotengineAppInstanceStatusInactive   = 2
};

typedef NS_OPTIONS(NSInteger, PPBotengineAppInstanceDataStreamBitmask) {
    PPBotengineAppInstanceDataStreamBitmaskUndefined      = 0,
    PPBotengineAppInstanceDataStreamBitmaskInvdividual    = 1 << 0,
    PPBotengineAppInstanceDataStreamBitmaskOrganizational = 1 << 1,
    PPBotengineAppInstanceDataStreamBitmaskCircle         = 1 << 2
};

typedef NS_OPTIONS(NSInteger, PPBotengineAppReviewVote) {
    PPBotengineAppReviewVoteDown = -1,
    PPBotengineAppReviewVoteDelete = 0,
    PPBotengineAppReviewVoteUp = 1
};

/*
 The type of the bot. Depending of the type, the bot is available for purchase either for locations, organizations or circles.
 */
typedef NS_OPTIONS(NSInteger, PPBotengineAppType) {
    PPBotengineAppTypeNone = -1,
    PPBotengineAppTypeUserLocations = 0, // The bot is intended for purchase by users for locations (default type)
    PPBotengineAppTypeOrganizationAdminOrganizations = 1, // The bot is intended for purchase by organization admins for their organizations
    PPBotengineAppTypeOrganizationLocations = 2, // The bot is intended for purchase for the organization locations only
    PPBotengineAppTypeCircleUserCircles = 3, // The bot is intended for purchase by the circle users for their circles
};

// MARK: - Organization

typedef NS_OPTIONS(NSInteger, PPOrganizationUserTotals) {
    PPOrganizationUserTotalsNone = -1,
    PPOrganizationUserTotalsFalse = 0,
    PPOrganizationUserTotalsTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPOrganizationAverageBills) {
    PPOrganizationAverageBillsNone = -1,
    PPOrganizationAverageBillsFalse = 0,
    PPOrganizationAverageBillsTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPOrganizationId) {
    PPOrganizationIdNone = -1
};

typedef NS_OPTIONS(NSInteger, PPOrganizationStatus) {
    PPOrganizationStatusNone = -2,
    PPOrganizationStatusRejected = -1,
    PPOrganizationStatusApplied = 0,
    PPOrganizationStatusAccepted = 1,
};

typedef NS_OPTIONS(NSInteger, PPOrganizationPoints) {
    PPOrganizationPointsNone = -1
};

typedef NS_OPTIONS(NSInteger, PPOrganizationPointsLevel) {
    PPOrganizationPointsLevelNone = -1
};

typedef NS_OPTIONS(NSInteger, PPOrganizationGroupId) {
    PPOrganizationGroupIdNone = -1
};

typedef NS_OPTIONS(NSInteger, PPOrganizationGroupOrganizationId) {
    PPOrganizationGroupOrganizationIdNone = -1
};

typedef NS_OPTIONS(NSInteger, PPOrganizationGroupPoints) {
    PPOrganizationGroupPointsNone = -1
};

typedef NS_OPTIONS(NSInteger, PPOrganizationGroupType) {
    PPOrganizationGroupTypeNone = -1,
    PPOrganizationGroupTypeResidential = 0,
    PPOrganizationGroupTypeBusiness = 1,
};

typedef NS_OPTIONS(NSInteger, PPOrganizationObjectPrivateContent) {
    PPOrganizationObjectPrivateContentNone = -1,
    PPOrganizationObjectPrivateContentFalse = 0,
    PPOrganizationObjectPrivateContentTrue = 1,
};

typedef NS_OPTIONS(NSInteger, PPOrganizationObjectParent) {
    PPOrganizationObjectParentNone = -1,
    PPOrganizationObjectParentFalse = 0,
    PPOrganizationObjectParentTrue = 1,
};

// MARK: - Networking

typedef NS_OPTIONS(NSInteger, PPCloudEngineType) {
    PPCloudEngineTypeDefault,
    PPCloudEngineTypeApp,
    PPCloudEngineTypeAppWebsocket,
    PPCloudEngineTypeAppStripped,
    PPCloudEngineTypeAdmin,
    PPCloudEngineTypeProxy,
    PPCloudEngineTypeStreaming,
    PPCloudEngineTypeReport
};

// MARK: -
// MARK: - Categories

// MARK: -
// MARK: - Defines -

// MARK: - Cloud Connectivity

#define CLOUD_CONNECTIVITY_SERVER_TYPE_APP_API @"appapi"
#define CLOUD_CONNECTIVITY_SERVER_TYPE_DEVICE_IO @"deviceio"
#define CLOUD_CONNECTIVITY_SERVER_TYPE_DEVICE_WS @"devicews"
#define CLOUD_CONNECTIVITY_SERVER_TYPE_STREAMING @"streaming"
#define CLOUD_CONNECTIVITY_SERVER_TYPE_WEB_APP @"webapp"
#define CLOUD_CONNECTIVITY_SERVER_TYPE_WS_API @"wsapi"

// MARK: - User Accounts

#define DEFAULT_LOCATION_NAME @"home"
#define EVENT_HOME @"HOME"
#define EVENT_AWAY @"AWAY"
#define EVENT_VACATION @"VACATION"
#define EVENT_SLEEP @"SLEEP"
#define EVENT_STAY @"STAY"
#define EVENT_TEST @"TEST"

// MARK: - Devices

// MARK: Device

#define DEVICE_NAME @"name"
#define DEVICE_CONNECTED @"connected"
#define DEVICE_RESTRICTED @"restricted"
#define DEVICE_SHARED @"shared"
#define DEVICE_NEW_DEVICE @"newDevice"
#define DEVICE_GOAL_ID @"goalId"
#define DEVICE_LAST_DATA_RECEIVED_DATE @"lastDataReceivedDate"
#define DEVICE_LAST_MEASURE_DATE @"lastMeasureDate"
#define DEVICE_LAST_CONNECTED_DATE @"lastConnectedDate"
#define DEVICE_ICON @"icon"
#define DEVICE_LOCATION_ID @"locationId"

// MARK: Picture Frame

// PictureFrame parameter refresh interval
#define PICTURE_FRAME_REFRESH_INTERVAL 150

// Streaming connection attemp limit
#define PICTURE_FRAME_STREAMING_CONNECTION_ATTEMPT_LIMIT 5

// Camera output volume
#define PICTURE_FRAME_VOLUME_OUTPUT_MAXIMUM 16
#define PICTURE_FRAME_VOLUME_OUTPUT_DEFAULT 8

// MARK: Proxies

#define DEFAULT_DEVICE_PROXY_ALERT_ID_LIMIT 1000
#define PROVIDEO_CACHE_REFRESH_TIME_SECONDS 60
#define FILE_UPLOAD_ATTEMPT_LIMIT 1
#define PROXY_DEFAULT_POST_FILE_RETRY_INTERVAL 20


#define PPDeviceProxyRegisterFailed 100
#define PPDeviceProxyUnreUngisterFailed 101

#define DEVICE_LOCAL_INITIALIZATION_DELAY 3.0
#define DEVICE_LOCAL_INITIALIZATION_DELAY_EXTENDED 30.0

#define WS_PARAMS @"params"
#define COMMAND_NAME @"name"
#define COMMAND_INDEX @"index"
#define COMMAND_SET_VALUE @"setValue"
#define COMMAND_VALUE @"value"
#define SESSION_ID @"sessionId"

#define DEVICE_CAMERA_LOCAL_VERIFY_VIEWERS_AFTER_SEC 10.0
#define DEVICE_CAMERA_LOCAL_VERIFY_VIEWERS_AFTER_SEC_PERIODICALLY 15.0

#define STREAM_ERROR @"streamError"
#define STREAM_STATUS @"ppc.streamStatus"
#define STREAM_ID @"streamId"
#define RESULT_CODE @"resultCode"
#define RECORD_STREAM @"recordStream"

#define VIDEO_CALL_SESSION_DETAILS @"ppc.videoCallSessionDetails"
#define VIDEO_CALL_ACTIVE_SESSION_ID @"ppc.videoCallAnswerSessionId"
#define VIDEO_CALL_NOW_STREAMING_SESSION_ID @"ppc.videoCallNowStreamingSessionId"
#define VIDEO_CALL_HANGUP_WITH_SESSION_ID @"ppc.videoCallHangUpSessionId"
#define VIDEO_CALL_IS_BUSY @"ppc.videoCallIsBusy"

#define DEVICE_CAMERA_LOCAL_RESTART_INTERVAL 86400

// MARK: Cameras

// Camera parameter refresh interval
#define CAMERA_REFRESH_INTERVAL 150

// Motion recording duration
#define CAMERA_MOTION_RECORDING_DURATION_FREE_MAX 60
#define CAMERA_MOTION_RECORDING_DURATION_PRO_MAX 300
#define CAMERA_MOTION_RECORDING_DURATION_MIN 5
#define CAMERA_MOTION_RECORDING_DURATION_DEFAULT 30

// Motion recording thumbnail interval
#define CAMERA_MOTION_RECORDING_THUMBNAIL_INTERVAL 1

// Motion detection reset interval
#define CAMERA_MOTION_DETECTION_RESET_INTERVAL 5

// Motion detection countdown duration
#define CAMERA_MOTION_DETECTION_COUNTDOWN_DEFAULT 30

// Streaming connection attemp limit
#define CAMERA_STREAMING_CONNECTION_ATTEMPT_LIMIT 5

// Motion detection sensitivity
#define CAMERA_MOTION_DETECTION_SENSITIVITY_DEFAULT PPDeviceParametersMotionSensitiviyNormal

// Motion recording interval
#define CAMERA_MOTION_RECORDING_INTERVAL_FREE_MIN 300
#define CAMERA_MOTION_RECORDING_INTERVAL_PRO_MIN 60
#define CAMERA_MOTION_RECORDING_INTERVAL_MAX 3600
#define CAMERA_MOTION_RECORDING_INTERVAL_DEFAULT 1800

// Camera output volume
#define CAMERA_VOLUME_OUTPUT_MAXIMUM 16
#define CAMERA_VOLUME_OUTPUT_DEFAULT 8

// MARK: Firmware Updates

#define FIRMWARE_UPDATE_INDEX_BLE 0
#define FIRMWARE_UPDATE_INDEX_MOTOR 1

// MARK: Device Measurements

#define DEVICE_PARAMETER_KEY_VALUE @"value"
#define DEVICE_PARAMETER_KEY_DEVICE_TYPE_ID @"deviceTypeId"
#define DEVICE_PARAMETER_KEY_INDEX @"index"

// Climate Control
#define FAN_MODE @"fanMode"
#define FAN_MODE_SEQUENCE @"fanModeSequence"
#define FAN_MODE_VALUES @"fanModeValues"
#define SYSTEM_MODE @"systemMode"
#define SYSTEM_MODE_VALUES @"systemModeValues"
#define SYSTEM_MODE_STATUS @"systemModeStatus"
#define COOLING_SETPOINT @"coolingSetpoint"
#define MIN_COOLING_SETPOINT @"minCoolingSetpoint"
#define MAX_COOLING_SETPOINT @"maxCoolingSetpoint"
#define HEATING_SETPOINT @"heatingSetpoint"
#define MIN_HEATING_SETPOINT @"minHeatingSetpoint"
#define MAX_HEATING_SETPOINT @"maxHeatingSetpoint"
#define HEAT_COOL_MIN_DELTA @"heatCoolMinDelta"
#define TEMP_VALUES @"tempValues"
#define POWER_STATUS @"powerStatus"
#define SWING_MODE @"swingMode"
#define SWING_MODE_VALUES @"swingModeValues"

// Temperature
#define DEG_C @"degC"
#define INTERNAL_DEG_C @"internalDegC"

// Humidity
#define RELATIVE_HUMIDITY @"relativeHumidity"

// Light
#define STATE @"state"
#define CURRENT_LEVEL @"currentLevel"
#define ILLUMINANCE @"illuminance"

// Plug
#define OUTLET_STATUS @"outletStatus"
#define POWER @"power"
#define ENERGY @"energy"

// Entry Sensor
#define DOOR_STATUS @"doorStatus"

// Touch Sensor
#define VIBRATION_STATUS @"vibrationStatus"

// Motion Sensor
#define MOTION_STATUS @"motionStatus"

// Water Sensor
#define WATER_LEAK @"waterLeak"

// Lock
#define LOCK_STATUS @"lockStatus"
#define LOCK_STATUS_ALARM @"lockStatusAlarm"

// Button
#define BUTTON_STATUS @"buttonStatus"

// Alarm
#define ALARM_STATUS @"alarmStatus"
#define ALARM_WARN @"ppc.alarmWarn"
#define ALARM_DURATION @"ppc.alarmDuration"
#define ALARM_STROBE @"ppc.alarmStrobe"
#define ALARM_SQUAWK @"ppc.alarmSquawk"
#define MODE @"ppc.mode"
#define ALARM_LEVEL @"ppc.alarmLevel"

// iBeacon
#define IBEACON_STATUS @"ppc.iBeaconStatus"
#define IBEACON_PROXIMITY @"ppc.iBeaconProximity"

// LintAlert
#define SIG_STATUS @"sig.status"
#define SIG_CUR_MAX_LED @"sig.curMaxLed"
#define SIG_TABLE @"sig.table"
#define SIG_PRESSURE @"sig.pressure"
#define SIG_WCI_PRESSURE @"sig.wciPressure"
#define SIG_CLEAN @"sig.clean"

// Netatmo
#define NAM_HEALTH_IDX @"nam.healthIdx"

// Camera and others (previously existing)
#define CAMERA_NAME @"ppc.cameraName"
#define RECORD_STATUS @"recordStatus"
#define ACCESS_CAMERA_SETTINGS @"accessCameraSettings"
#define AUDIO_STREAMING @"audioStreaming"
#define VIDEO_STREAMING @"videoStreaming"
#define HD_STATUS @"ppc.hdStatus"
#define RAPID_MOTION_STATUS @"ppc.rapidMotionStatus"
#define BATTERY_LEVEL @"batteryLevel"
#define CHARGING @"ppc.charging"
#define MOTION_DETECTION_STATUS @"motionDetectionStatus" // Use MOTION_STATUS for device<>parameter mapping.  This is only used for UI string<>parameter mapping
#define AUTO_FOCUS @"ppc.autoFocus"
#define AUDIO_STATUS @"audioStatus"
#define SELECTED_CAMERA @"selectedCamera"
#define RECORD_SECONDS @"ppc.recordSeconds"
#define MOTION_SENSITIVITY @"ppc.motionSensitivity"
#define AUDIO_SENSITIVITY @"ppc.audioSensitivity"
#define TIMEZONE_ID @"timeZoneId"
#define MOTION_ACTIVITY @"ppc.motionActivity"
#define AUDIO_ACTIVITY @"ppc.audioActivity"
#define VERSION @"version"
#define ROBOT_CONNECTED @"ppc.robotConnected"
#define ROBOT_MOTION_DIRECTION @"ppc.robotMotionDirection"
#define ROBOT_VANTAGE_SPHERICAL_COORDINATES @"ppc.robotVantageSphericalCoordinates"
#define ROBOT_VANTAGE_TIME @"ppc.robotVantageTimer"
#define ROBOT_VANTAGE_NAME @"ppc.robotVantageName"
#define ROBOT_VANTAGE_SEQUENCE @"ppc.robotVantageSequence"
#define ROBOT_VANTAGE_MOVE_TO_INDEX @"ppc.robotVantageMoveToIndex"
#define ROBOT_VANTAGE_CONFIGURATION_STATUS @"ppc.robotVantageConfigurationStatus"
#define ROBOT_ORIENTATION @"ppc.robotOrientation"
#define AVAILABLE_BYTES @"ppc.availableBytes"
#define TWITTER_AUTO_SHARE @"twitterAutoShare"
#define TWITTER_DESCRIPTION @"twitterDescription"
#define TWITTER_REMINDER @"ppc.twitterReminder"
#define TWITTER_STATUS @"ppc.twitterStatus"
#define MOTION_COUNTDOWN_TIME @"ppc.motionCountDownTime"
#define BLACKOUT_SCREEN_ON @"ppc.blackoutScreenOn"
#define WARNING_STATUS @"ppc.warningStatus"
#define WARNING_TEXT @"ppc.warningText"
#define KEYPAD_STATUS @"ppc.keypadStatus"
#define RECORD_FULL_DURATION @"ppc.recordFullDuration"
#define FLASH_ON @"ppc.flashOn"
#define SUPPORTS_VIDEO_CALL @"ppc.supportsVideoCall"
#define OUTPUT_VOLUME @"ppc.outputVolume"
#define CAPTURE_IMAGE @"ppc.captureImage"
#define ALARM @"ppc.alarm"
#define PLAY_SOUND @"ppc.playSound"
#define COUNTDOWN @"ppc.countdown"
#define VISUAL_COUNTDOWN @"ppc.visualCountdown"
#define MOTION_ALARM @"ppc.motionAlarm"
#define FIRMWARE @"firmware"
#define MODEL @"model"
#define FIRMWARE_UPDATE_STATUS @"firmwareUpdateStatus"
#define FIRMWARE_URL @"firmwareUrl"
#define FIRMWARE_CHECK_SUM @"firmwareCheckSum"
#define NETWORK_TYPE @"netType"

// Picture Frame
#define ALERT_TITLE @"ppc.alertTitle"
#define ALERT_SUBTITLE @"ppc.alertSubtitle"
#define ALERT_QUESTION_ID @"ppc.alertQuestionId"
#define ALERT_MESSAGE @"ppc.alertMessage"
#define ALERT_ICON @"ppc.alertIcon"
#define ALERT_TIMESTAMP_MS @"ppc.alertTimestampMs"
#define ALERT_DURATION_MS @"ppc.alertDurationMs"
#define ALERT_PRIORITY @"ppc.alertPriority"
#define ALERT_STATUS @"ppc.alertStatus"

// Messaging
#define NOTIFICATION @"ppc.notification"

// MARK: - System and User Properties

#define SYSTEM_PROPERTY_CACHE_REFRESH_TIME_SECONDS 21600
#define USER_PROPERTY_CACHE_REFRESH_TIME_SECONDS 30

#define USER_PROPERTY_DEFAULT_USER_TEMPERATURE @"F"
#define USER_PROPERTY_DEFAULT_USER_TIME_FORMAT @"12"
#define USER_PROPERTY_DEFAULT_USER_CURRENCY @"USD"
#define USER_PROPERTY_DEFAULT_USER_CURRENCY_COUNTRY @"United States"
#define USER_PROPERTY_NUMERIC_CODE @"numericCode"
#define USER_PROPERTY_DURESS_CODE @"duressCode"
#define USER_PROPERTY_USER_TIME @"user-time"
#define USER_PROPERTY_USER_TEMPERATURE @"user-temperature"
#define USER_PROPERTY_USER_CURRENCY_CODE @"user-currencyCode"
#define USER_PROPERTY_USER_CURRENCY_SYMBOL @"user-currencySymbol"
#define USER_PROPERTY_USER_CURRENCY_COUNTRY @"user-currencyCountry"

#define USER_PROPERTY_SERVICE_START_DATE(serviceName)   [NSString stringWithFormat:@"%@.startDate", serviceName]
#define USER_PROPERTY_END_OF_LIFE_NOTICE(appName)       [NSString stringWithFormat:@"%@-end_of_life_notice", appName]
#define SYSTEM_PROPERTY_PASSWORD_REGEX(appName)         [NSString stringWithFormat:@"%@-password_regex", appName]
#define SYSTEM_PROPERTY_IOS_VERSION(appName)            [NSString stringWithFormat:@"ios-version-%@", appName]
#define SYSTEM_PROPERTY_TERMS_OF_SERVICE(appName)       [NSString stringWithFormat:@"%@-tos", appName]
#define SYSTEM_PROPERTY_LOCATION_ACCESS(appName)        [NSString stringWithFormat:@"%@-LocationAccess", appName]
#define SYSTEM_PROPERTY_END_OF_LIFE_DATE(appName)       [NSString stringWithFormat:@"%@-end_of_life_date", appName]
#define SYSTEM_PROPERTY_ASK_SMART_HOME(appName)         [NSString stringWithFormat:@"%@-ask_smart_home", appName]
#define SYSTEM_PROPERTY_AOG_SMART_HOME(appName)         [NSString stringWithFormat:@"%@-aog_smart_home", appName]

#define SYSTEM_PROPERTY_DEFAULT_PASSWORD_REGEX @"^.{8,}$"
#define SYSTEM_PROPERTY_CALL_CENTER_SUPPORTED_STATE_IDS @"call_center-supported_state_ids"
#define SYSTEM_PROPERTY_ANALYTICS_QUIET @"analytics-quiet"
#define SYSTEM_PROPERTY_ANALYTICS_LEVEL @"analytics-level"
#define SYSTEM_PROPERTY_PERSISTENT_TIMEOUT @"persistent-timeout"
#define SYSTEM_PROPERTY_POST_FILE_RETRY_INTERVAL @"post-file-retry-interval"
#define SYSTEM_PROPERTY_IOS_DEDICATED_CAMERA_URL @"ios-dedicatedCameraUrl"
#define SYSTEM_PROPERTY_SYSTEM_WEB_CACHE_KEY @"system-web_cache_key"
#define SYSTEM_PROPERTY_IOS_PLAYER_MAX_SECONDS_BEFORE_ABORT_READ_FRAME @"ios-player_max_seconds_before_abort_read_frame"
#define SYSTEM_PROPERTY_IOS_LOG_STREAMING_STATISTICS_ON_WOOPRA @"ios-log_streaming_statistics_on_woopra"
#define SYSTEM_PROPERTY_IOS_MAXIMUM_RETRY_CONNECTION_ATTEMPTS_BEFORE_WARNING @"ios-maximum_retry_connection_attempts_before_warning"
#define SYSTEM_PROPERTY_IOS_COUNTDOWN_TIMER_WARNING_DURATION_SECONDS @"ios-countdown_timer_warning_duration_seconds"
#define SYSTEM_PROPERTY_IOS_FREE_COUNTDOWN_TIMER_TOTAL_SECONDS @"ios-free-countdown_timer_total_seconds"
#define SYSTEM_PROPERTY_IOS_FREE_MAXIMUM_LIVE_STREAMING_RECORDING_SECONDS @"ios-free-maximum_live_streaming_recording_seconds"
#define SYSTEM_PROPERTY_IOS_FREE_DEFAULT_RESOLUTION @"ios-free-default_resolution"
#define SYSTEM_PROPERTY_IOS_FREE_DEFAULT_MAXIMUM_BITRATE @"ios-free-default_maximum_bitrate"
#define SYSTEM_PROPERTY_IOS_FREE_DEFAULT_FRAMES_PER_SECOND @"ios-free-default_frames_per_second"
#define SYSTEM_PROPERTY_IOS_FREE_DEFAULT_KEY_FRAME_INTERVAL @"ios-free-default_key_frame_interval"
#define SYSTEM_PROPERTY_IOS_FREE_DEFAULT_AUDIO_RATE @"ios-free-default_audio_rate"
#define SYSTEM_PROPERTY_IOS_FREE_DEFAULT_BUFFER_LENGTH @"ios-free-default_buffer_length"
#define SYSTEM_PROPERTY_IOS_PRO_COUNTDOWN_TIMER_TOTAL_SECONDS @"ios-pro-countdown_timer_total_seconds"
#define SYSTEM_PROPERTY_IOS_PRO_MAXIMUM_LIVE_STREAMING_RECORDING_SECONDS @"ios-pro-maximum_live_streaming_recording_seconds"
#define SYSTEM_PROPERTY_IOS_PRO_DEFAULT_RESOLUTION @"ios-pro-default_resolution"
#define SYSTEM_PROPERTY_IOS_PRO_DEFAULT_MAXIMUM_BITRATE @"ios-pro-default_maximum_bitrate"
#define SYSTEM_PROPERTY_IOS_PRO_DEFAULT_FRAMES_PER_SECOND @"ios-pro-default_frames_per_second"
#define SYSTEM_PROPERTY_IOS_PRO_DEFAULT_KEY_FRAME_INTERVAL @"ios-pro-default_key_frame_interval"
#define SYSTEM_PROPERTY_IOS_PRO_DEFAULT_AUDIO_RATE @"ios-pro-default_audio_rate"
#define SYSTEM_PROPERTY_IOS_PRO_DEFAULT_BUFFER_LENGTH @"ios-pro-default_buffer_length"
#define SYSTEM_PROPERTY_IOS_SLOW_DEFAULT_RESOLUTION @"ios-slow-default_resolution"
#define SYSTEM_PROPERTY_IOS_SLOW_DEFAULT_MAXIMUM_BITRATE @"ios-slow-default_maximum_bitrate"
#define SYSTEM_PROPERTY_IOS_SLOW_DEFAULT_FRAMES_PER_SECOND @"ios-slow-default_frames_per_second"
#define SYSTEM_PROPERTY_IOS_SLOW_DEFAULT_KEY_FRAME_INTERVAL @"ios-slow-default_key_frame_interval"
#define SYSTEM_PROPERTY_IOS_SLOW_DEFAULT_AUDIO_RATE @"ios-slow-default_audio_rate"
#define SYSTEM_PROPERTY_IOS_SLOW_DEFAULT_BUFFER_LENGTH @"ios-slow-default_buffer_length"
#define SYSTEM_PROPERTY_IOS_VIDEO_CALL_DEFAULT_RESOLUTION @"ios-videocall-default_resolution"
#define SYSTEM_PROPERTY_IOS_VIDEO_CALL_DEFAULT_MAXIMUM_BITRATE @"ios-videocall-default_maximum_bitrate"
#define SYSTEM_PROPERTY_IOS_VIDEO_CALL_DEFAULT_FRAMES_PER_SECOND @"ios-videocall-default_frames_per_second"
#define SYSTEM_PROPERTY_IOS_VIDEO_CALL_DEFAULT_KEY_FRAME_INTERVAL @"ios-videocall-default_key_frame_interval"
#define SYSTEM_PROPERTY_IOS_VIDEO_CALL_DEFAULT_AUDIO_RATE @"ios-videocall-default_audio_rate"
#define SYSTEM_PROPERTY_IOS_VIDEO_CALL_DEFAULT_BUFFER_LENGTH @"ios-videocall-default_buffer_length"
#define SYSTEM_PROPERTY_IOS_SLOW_VIDEO_CALL_DEFAULT_RESOLUTION @"ios-slow-videocall-default_resolution"
#define SYSTEM_PROPERTY_IOS_SLOW_VIDEO_CALL_DEFAULT_MAXIMUM_RESOLUTION @"ios-slow-videocall-default_maximum_bitrate"
#define SYSTEM_PROPERTY_IOS_SLOW_VIDEO_CALL_DEFAULT_FRAMES_PER_SECOND @"ios-slow-videocall-default_frames_per_second"
#define SYSTEM_PROPERTY_IOS_SLOW_VIDEO_CALL_DEFAULT_KEY_FRAME_INTERVAL @"ios-slow-videocall-default_key_frame_interval"
#define SYSTEM_PROPERTY_IOS_SLOW_VIDEO_CALL_DEFAULT_AUDIO_RATE @"ios-slow-videocall-default_audio_rate"
#define SYSTEM_PROPERTY_IOS_SLOW_VIDEO_CALL_DEFAULT_BUFFER_LENGTH @"ios-slow-videocall-default_buffer_length"
#define SYSTEM_PROPERTY_CAMERA_MOTION_ALERT_PERIOD_SECONDS @"camera-motion_alert_period_seconds"
#define SYSTEM_PROPERTY_CAMERA_QUANTIFY_MOTION @"camera-quantify_motion"
#define SYSTEM_PROPERTY_DEFAULT_GETTING_STARTED_VIDEO_URL @"http://peoplepowerco.com/email/PresenceSetupShort.m4v"
#define SYSTEM_PROPERTY_GETTING_STARTED_VIDEO_URL @"getting-started-video-url"
#define SYSTEM_PROPERTY_GETTING_STARTED_VIDEO_THUMBNAIL_URL @"getting-started-thumbnail-url"
#define SYSTEM_PROPERTY_GETTING_STARTED_VIDEO_ARRAY @"getting-started-video-array"
#define SYSTEM_PROPERTY_GETTING_STARTED_VIDEO_THUMBNAIL_ARRAY @"getting-started-video-thumbnail-array"
#define SYSTEM_PROPERTY_BRANDS @"brands"
#define SYSTEM_PROPERTY_PASSCODE_LOWERCASE @"passcode-lowercase" // BOOL
#define SYSTEM_PROPERTY_COMMUNITY_POST_FILE_CONTENT_LIMIT @"ppc.communityPostFile.contentLimit"
#define SYSTEM_PROPERTY_MMS_NUMBER @"mms_number"

// MARK: - Rules

#define RULE_COMPONENT_STATE_SCHEDULE_COMPONENT_NAME @"schedule"
#define RULE_COMPONENT_STATE_SCHEDULE_COMPONENT_PAMAMETER_NAME_1 @"time1"
#define RULE_COMPONENT_STATE_SCHEDULE_COMPONENT_PAMAMETER_NAME_2 @"time2"

// MARK: - Weather

#define WEATHER_METADATA_UNIT_ENGLISH @"e"
#define WEATHER_METADATA_UNIT_METRIC @"m"
#define WEATHER_METADATA_UNIT_HUBRID @"h" // UK
#define WEATHER_METADATA_UNIT_METRICSI @"s" // Not available for all APIs

// MARK: - Products

#define DEVICE_TYPE_GOAL_CATEGORY_ENERGY @"E"
#define DEVICE_TYPE_GOAL_CATEGORY_SECURITY @"S"
#define DEVICE_TYPE_GOAL_CATEGORY_CARE @"C"
#define DEVICE_TYPE_GOAL_CATEGORY_LIFESTYLE @"L"
#define DEVICE_TYPE_GOAL_CATEGORY_HEALTH @"H"
#define DEVICE_TYPE_GOAL_CATEGORY_WELLNESS @"W"


#define PPDeviceTypeStoryPageStyleDefault @""
#define PPDeviceTypeStoryPageStyleInfo @"info"
#define PPDeviceTypeStoryPageStyleConnect @"connect"
#define PPDeviceTypeStoryPageStylePicture @"picture"
#define PPDeviceTypeStoryPageStyleCalibrate @"calibrate"

// MARK: - Clouds Integration

#define OAUTH_HOST_ERROR_ACCESS_DENIED @"access_denied"
#define OAUTH_HOST_ERROR_UNSUPPORTED_RESPONSE_TYPE @"unsupported_response_type"
#define OAUTH_HOST_ERROR_SERVER_ERROR @"server_error"

#define OAUTH_HOST_CLIENT_ID_AMAZON_ECHO @"AmazonEcho"
#define OAUTH_HOST_CLIENT_ID_GOOGLE_HOME @"GoogleHome"

#define OAUTH_HOST_RESPONSE_TYPE_CODE @"code"

// MARK: - Botengine

#define COMPOSER_APP_CATEGORY_ENERGY @"E"
#define COMPOSER_APP_CATEGORY_SECURITY @"S"
#define COMPOSER_APP_CATEGORY_CARE @"C"
#define COMPOSER_APP_CATEGORY_LIFESTYLE @"L"
#define COMPOSER_APP_CATEGORY_HEALTH @"H"
#define COMPOSER_APP_CATEGORY_WELLNESS @"W"

// MARK: - Networking

#define HTTP_TIMEOUT_WITH_ACTIVE_CAMERA 10
#define HTTP_VIDEO_TIMEOUT 10
#define HTTP_DEFAULT_TIMEOUT 45
#define HTTP_DEFAULT_PERSISTENT_CONNECTION_TIMEOUT 180
#define HTTP_DEFAULT_WEBVIEW_VERSION 4

#define PPVersion_h
#if !TARGET_OS_WATCH
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)
#endif

// MARK: HTTP

#define HTTP_HEADER_API_KEY @"API_KEY"
#define HTTP_HEADER_CIRCLE_KEY @"CIRCLE_KEY"
#define HTTP_HEADER_PASSWORD @"PASSWORD"
#define HTTP_HEADER_PASSCODE @"passcode"
#define HTTP_HEADER_AUTHORIZATION @"Authorization"
#define HTTP_HEADER_PPC_AUTHORIZATION @"PPCAuthorization"
#define HTTP_HEADER_CONTENT_TYPE @"Content-Type"
#define HTTP_HEADER_RANGE @"Range"
#define HTTP_HEADER_CONTENT_RANGE @"Content-Range"
#define HTTP_HEADER_ACCEPT_RANGES @"Accept-Ranges"
#define HTTP_HEADER_CONTENT_DISPOSITION @"Content-Disposition"
#define HTTP_HEADER_CONTENT_LENGTH @"Content-Length"


// MARK: -
// MARK: - Blocks -

@class PPFile;

typedef void (^PPBasicBlock)(void);
typedef void (^PPErrorBlock)(NSError * _Nullable error);
typedef void (^PPBooleanBlock)(BOOL b);
typedef void (^PPNSIntegerBlock)(NSInteger i);
typedef void (^PPNSStringBlock)(NSString * _Nullable s);
typedef void (^PPNSURLBlock)(NSURL * _Nullable u);
typedef void (^PPNSArrayBlock)(NSArray * _Nullable a);
typedef void (^PPNSDictionaryBlock)(NSDictionary * _Nullable a);
typedef void (^PPFileBlock)(PPFile * _Nullable f);

// MARK: - Cloud Connectivity

@class PPCloudConnectivityCloud;
@class PPCloudConnectivityServer;

typedef void (^PPCloudConnectivityAvailabilityBlock)(NSString * _Nullable status, NSError * _Nullable error);
typedef void (^PPCloudConnectivityCloudsBlock)(NSArray * _Nullable clouds, NSError * _Nullable error);
typedef void (^PPCloudConnectivityCloudBlock)(PPCloudConnectivityCloud * _Nullable cloud, NSError * _Nullable error);
typedef void (^PPCloudConnectivityServerBlock)(PPCloudConnectivityServer * _Nullable server, NSError * _Nullable error);
typedef void (^PPCloudConnectivityServerURLBlock)(NSURL * _Nullable url, NSError * _Nullable error);

// MARK: - Operation Token

@class PPOperationToken;

typedef void (^PPLoginBlock)(NSString * _Nullable APIKey, NSDate * _Nullable expireDate, NSError * _Nullable error);
typedef void (^PPOperationTokenBlock)(PPOperationToken * _Nullable operationToken, NSError * _Nullable error);
typedef void (^PPOperationTokenValidityBlock)(BOOL isValid);
typedef void (^PPSignatureKeyBlock)(NSString * _Nullable privateKey, NSError * _Nullable error);

// MARK: - User Accounts

@class PPUser;
@class PPLocation;
@class PPOperationToken;
@class PPCountriesStatesAndTimezones;

typedef void (^PPUserAccountsBlock)(PPUser * _Nullable user, NSError * _Nullable error);
typedef void (^PPUserAccountsServicesBlock)(NSMutableArray * _Nullable services, NSError * _Nullable error);
typedef void (^PPUserAccountsUsersListBlock)(NSArray * _Nullable users, NSError * _Nullable error);
typedef void (^PPUserAccountsRegistrationBlock)(NSString * _Nullable userId, NSString * _Nullable locationId, NSString * _Nullable APIKey, NSDate * _Nullable keyExpireDate, NSError * _Nullable error);
typedef void (^PPUserAccountsLocationSceneBlockBlock)(NSArray * _Nullable sharedDevices, NSArray * _Nullable stopSharingDevices, NSError * _Nullable error);
typedef void (^PPUserAccountsLocationSceneBlockHistoryBlock)(NSArray * _Nullable events, NSError * _Nullable error);
typedef void (^PPUserAccountTermsOfServiceBlock)(NSArray * _Nullable termsOfServices, NSError * _Nullable error);
typedef void (^PPUserAccountCountriesStatesAndTimeszonesBlock)(PPCountriesStatesAndTimezones * _Nullable countriesStatesAndTimezones, NSError * _Nullable error);
typedef void (^PPUserAccountsLocationSpacesBlock)(NSArray * _Nullable spaces, NSError * _Nullable error);
typedef void (^PPUserAccountsUpdateLocationSpacesBlock)(PPLocationSpaceId spaceId, NSError * _Nullable error);
typedef void (^PPUserAccountsPutNarrativeBlock)(PPLocationNarrativeId spaceId, NSError * _Nullable error);
typedef void (^PPUserAccountsNarrativesBlock)(NSArray * _Nullable narratives, NSString * _Nullable nextMarker, NSError * _Nullable error);
typedef void (^PPUserAccountsAddLocationBlock)(PPLocationId locationId, NSError * _Nullable error);
typedef void (^PPUserAccountsLocationPresenceBlock)(NSArray * _Nullable ibeaconUUIDs, NSError * _Nullable error);
typedef void (^PPUserAccountsLocationIdBlock)(PPLocationId locationId, NSError * _Nullable error);
typedef void (^PPUserAccountsStateBlock)(NSDictionary * _Nullable data, NSError * _Nullable error);
typedef void (^PPUserAccountsStatesBlock)(NSArray * _Nullable states, NSError * _Nullable error);
typedef void (^PPUserAccountsUserCodesBlock)(NSArray * _Nullable userCodes, NSError * _Nullable error);

// MARK: - Devices

@class PPDevice;
@class PPDeviceActivationInfo;
@class PPVideoToken;
@class PPDeviceProxy;

typedef void (^PPDevicesRegisterBlock)(NSString * _Nullable deviceId, NSString * _Nullable authToken, PPDeviceTypeId deviceTypeId, PPDevicesExist exist, NSString * _Nullable host, PPDevicesPort port, PPDevicesUseSSL useSsl, NSError * _Nullable error);
typedef void (^PPDevicesBlock)(NSArray * _Nullable devices, NSError * _Nullable error);
typedef void (^PPDeviceBlock)(PPDevice * _Nullable device, PPLocation * _Nullable location, NSError * _Nullable error);
typedef void (^PPDeviceActivationBlock)(PPDeviceActivationInfo * _Nullable deviceActivationInfo, NSError * _Nullable error);
typedef void (^PPDevicePropertiesBlock)(NSArray * _Nullable properties, NSError * _Nullable error);
typedef void (^PPDeviceFirmwareJobsBlock)(NSMutableArray * _Nullable jobs, NSError * _Nullable error);
typedef void (^PPDeviceVideoTokenBlock)(PPVideoToken * _Nullable token, NSError * _Nullable error);
typedef void (^PPFileAcknowledgmentBlock)(PPFileId fileId, PPFileFragments totalFragments, PPFileUsedFileSpace usedSpace, PPFileTotalFileSpace totalSpace, PPFileFilesAction action, PPFileThumbnail thumbnail, PPFileTwitterShare twitterShare, NSError * _Nullable error);
typedef void (^PPProxyRegisterBlock)(PPDeviceProxy * _Nullable device, NSError * _Nullable error);
typedef NSDictionary * _Nonnull (^PPDeviceProxyDeviceCommandBlock)(NSArray * _Nullable parameters);
typedef void (^PPUserAccountsBlock)(PPUser * _Nullable user, NSError * _Nullable error);

// MARK: - Device Measurements

typedef void (^PPDeviceMeasurementsBlock)(NSArray * _Nullable measurements, NSError * _Nullable error);
typedef void (^PPDeviceMeasurementsCommandsBlock)(NSArray * _Nullable commands, NSError * _Nullable error);
typedef void (^PPDeviceMeasurementsReadingsBlock)(NSArray * _Nullable readings, NSError * _Nullable error);
typedef void (^PPDeviceMeasurementsAlertsBlock)(NSArray * _Nullable alerts, NSError * _Nullable error);
typedef void (^PPDeviceMeasurementsUnitsBlock)(NSArray * _Nullable units, NSError * _Nullable error);

// MARK: - Communications

@class PPCrowdFeedbackTicket;

typedef void (^PPNotificationSubscriptionsBlock)(NSArray * _Nullable subscriptions, NSError * _Nullable error);
typedef void (^PPNotificationHistoryBlock)(NSArray * _Nullable notifications, NSError * _Nullable error);
typedef void (^PPCrowdFeedbacksTicketBlock)(PPCrowdFeedbackTicket * _Nullable ticket, NSError * _Nullable error);
typedef void (^PPCrowdFeedbacksBlock)(NSArray * _Nullable feedbacks, NSError * _Nullable error);
typedef void (^PPInAppMessagingBlock)(PPInAppMessageId messageId, NSError * _Nullable error);
typedef void (^PPInAppMessagesBlock)(NSArray * _Nullable messages, NSError * _Nullable error);
typedef void (^PPQuestionsBlock)(NSArray * _Nullable collections, NSArray * _Nullable questions, NSError * _Nullable error);
typedef void (^PPQuestionsAnswersBlock)(NSArray * _Nullable questions, NSError * _Nullable error);
typedef void (^PPSMSGroupTextingSubscribersCallback)(NSArray * _Nullable subscribers, NSError * _Nullable error);
typedef void (^PPSurveyQuestionsBlock)(NSArray * _Nullable questions, NSError * _Nullable error);

// MARK: - System and User Properties

@class PPProperty;
typedef void (^PPSystemPropertyBlock)(PPProperty * _Nullable property, NSError * _Nullable error);
typedef void (^PPSystemPropertiesBlock)(NSArray * _Nullable properties, NSError * _Nullable error);

// MARK: - File Management

typedef void (^PPFileManagementFragmentBlock)(NSString * _Nullable status, PPFile * _Nullable fileFragment, PPFileTotalFileSpace totalFileSpace, PPFileUsedFileSpace usedFileSpace, PPFileTwitterShare twitterShare, NSString * _Nullable twitterAccount, NSString * _Nullable contentUrl, PPFileStoragePolicy storagePolicy, NSDictionary * _Nullable uploadHeaders, NSError * _Nullable error);
typedef void (^PPFileManagementFilesBlock)(NSArray * _Nullable files, PPFileTotalFileSpace totalFileSpace, PPFileUsedFileSpace usedFileSpace, NSString * _Nullable tempKey, NSDate * _Nullable tempKeyExpire, NSError * _Nullable error);
typedef void (^PPFileManagementContentBlock)(NSData * _Nullable fileContent, NSString * _Nullable contentType, NSString * _Nullable contentRange, NSString * _Nullable acceptRanges, NSString * _Nullable contentDisposition,NSInteger statusCode, NSError * _Nullable error);
typedef void (^PPFileManagementDownloadURLBlock)(NSURL * _Nullable contentURL, NSURL * _Nullable thumbnailURL, NSError * _Nullable error);
typedef void (^PPFileManagementFilesSummaryBlock)(NSArray * _Nullable summaries, PPFileTotalFileSpace totalFileSpace, PPFileUsedFileSpace usedFileSpace, NSDate * _Nullable startDate, NSDate * _Nullable endDate, PPFileCount filesCount, NSError * _Nullable error);
typedef void (^PPFileManagementFileDevicesBlock)(NSArray * _Nullable devices, NSError * _Nullable error);
typedef void (^PPFileManagementFileInformationBlock)(PPFile * _Nullable file, NSString * _Nullable tempKey, NSDate * _Nullable tempKeyExpire, NSError * _Nullable error);
typedef void (^PPFileManagementLastNFilesBlock)(NSArray * _Nullable files, NSString * _Nullable tempKey, NSDate * _Nullable tempKeyExpire, NSError * _Nullable error);
typedef void (^PPFileManagementProgressBlock)(NSProgress * _Nullable progress);

// MARK: - Application Files

typedef void (^PPApplicationFileManagementUploadFileBlock)(PPApplicationFileId fileId, NSError * _Nullable error);
typedef void (^PPApplicationFileManagementFilesBlock)(NSArray * _Nullable files, NSString * _Nullable tempKey, NSDate * _Nullable tempKeyExpire, NSError * _Nullable error);
typedef void (^PPApplicationFileManagementContentBlock)(NSData * _Nullable fileContent, NSString * _Nullable contentType, NSString * _Nullable contentRange, NSString * _Nullable acceptRanges, NSString * _Nullable contentDisposition, NSInteger statusCode, NSError * _Nullable error);
typedef void (^PPApplicationFileManagementProgressBlock)(NSProgress * _Nullable progress);

// MARK: - Rules

@class PPRule;

typedef void (^PPRulesComponentsBlock)(NSArray * _Nullable triggers, NSArray * _Nullable states, NSArray * _Nullable actions, NSError * _Nullable error);
typedef void (^PPRulesCreationBlock)(PPRule * _Nullable rule, NSError * _Nullable error);
typedef void (^PPRulesListBlock)(NSArray * _Nullable rules, NSError * _Nullable error);
typedef void (^PPRulesStatusBlock)(NSArray * _Nullable ruleIds, NSError * _Nullable error);

// MARK: - Paid Services

typedef void (^PPPaidServicesServicePlansCallback)(NSArray * _Nullable servicePlans, NSError * _Nullable error);
typedef void (^PPPaidServicePaypalRedirectCallback)(NSURL * _Nullable authenticationUrl, NSError * _Nullable error);
typedef void (^PPPaidServicePaymentProviderCallback)(NSString * _Nullable token, NSError * _Nullable error);
typedef void (^PPPaidServicesSubscriptionsCallback)(NSArray * _Nullable subscriptions, NSError * _Nullable error);
typedef void (^PPPaidServicesTransactionsCallback)(NSArray * _Nullable transactions, NSError * _Nullable error);
typedef void (^PPPaidServicesProductsCallback)(NSArray * _Nullable products, NSString * _Nullable affiliateCode, NSError * _Nullable error);

// MARK: - Professional Monitoring

@class PPCallCenter;

typedef void (^PPCallCenterBlock)(PPCallCenter * _Nullable callCenter, NSError * _Nullable error);
typedef void (^PPCallCenterAlertsBlock)(NSArray * _Nullable alerts, NSError * _Nullable error);

// MARK: - Dynamic User Interfaces

typedef void (^PPDynamicUIBlock)(NSArray * _Nullable screens, NSError * _Nullable error);
typedef void (^PPDynamicUILocationTotalsBlock)(NSDictionary * _Nullable userTotals, NSError * _Nullable error);

// MARK: - Energy Management

@class PPEnergyManagementDeviceUsagePower;
@class PPEnergyManagementDeviceUsageEnergy;
@class PPEnergyManagementBillingInfo;

typedef void (^PPEnergyManagementUsageBlock)(NSArray * _Nullable usages, NSError * _Nullable error);
typedef void (^PPEnergyManagementDeviceUsageBlock)(PPEnergyManagementDeviceUsagePower * _Nullable power, PPEnergyManagementDeviceUsageEnergy * _Nullable energy, NSError * _Nullable error);
typedef void (^PPEnergyManagementAggregatedDeviceUsageBlock)(NSArray * _Nullable usages, NSError * _Nullable error);
typedef void (^PPEnergyManagementBillingInfoBlock)(PPEnergyManagementBillingInfo * _Nullable billingInfo,  NSError * _Nullable error);

// MARK: - Weather

@class PPWeather;

typedef void (^PPWeatherBlock)(PPWeather * _Nullable weather, NSError * _Nullable error);

// MARK: - Products

@class PPDeviceTypeRuleComponentTemplate;
@class PPDeviceTypeInstallationInstructions;

typedef void (^PPDeviceTypesBlock)(NSArray * _Nullable deviceTypes, NSError * _Nullable error);
typedef void (^PPDeviceTypeAttributesBlock)(NSArray * _Nullable deviceTypeAttributes, NSError * _Nullable error);
typedef void (^PPDeviceTypeDeviceParamsBlock)(NSArray * _Nullable deviceParams, NSError * _Nullable error);
typedef void (^PPDeviceTypeRulePhrasesBlock)(NSArray * _Nullable ruleTemplates, NSError * _Nullable error);
typedef void (^PPDeviceTypeRulePhraseBlock)(PPDeviceTypeRuleComponentTemplate * _Nullable ruleTemplate, NSError * _Nullable error);
typedef void (^PPDeviceTypeDefaultRulesBlock)(NSArray * _Nullable rules, NSError * _Nullable error);
typedef void (^PPDeviceTypeGoalsBlock)(NSArray * _Nullable goals, NSError * _Nullable error);
typedef void (^PPDeviceTypeInstallationInstructionsBlock)(PPDeviceTypeInstallationInstructions * _Nullable installationInstructions, NSError * _Nullable error);
typedef void (^PPDeviceTypeMediaBlock)(NSArray * _Nullable medias, NSError * _Nullable error);
typedef void (^PPDeviceTypeDeviceModelsBlock)(NSArray * _Nullable categories, NSError * _Nullable error);
typedef void (^PPDeviceTypeStoriesBlock)(NSArray * _Nullable stories, NSError * _Nullable error);

// MARK: - Clouds Integration

@class PPCloudsIntegrationHostAccessToken;

typedef void (^PPCloudsIntegrationCloudsCallback)(NSMutableArray * _Nullable clouds, NSError * _Nullable error);
typedef void (^PPCloudsIntegrationHostAccessTokenBlock)(PPCloudsIntegrationHostAccessToken * _Nullable accessToken, NSError * _Nullable error);
typedef void (^PPCloudsIntegrationMicroServiceVersionsCallback)(NSMutableArray * _Nullable versions, NSError * _Nullable error);

// MARK: - Community

@class PPCommunityFile;

typedef void (^PPCommunityPostsBlock)(NSArray * _Nullable posts, NSError * _Nullable error);
typedef void (^PPCommunityCreatePostBlock)(PPCommunityPostId postId, NSError * _Nullable error);
typedef void (^PPCommunityCreateCommentBlock)(PPCommunityCommentId commentId, NSError * _Nullable error);
typedef void (^PPCommunityUploadFileBlock)(PPFileId fileId, NSString * _Nullable contentUrl, NSString * _Nullable thumbnailUrl, NSString * _Nullable m3u8Url, NSDictionary * _Nullable uploadHeaders, NSError * _Nullable error);
typedef void (^PPCommunityFilesBlock)(NSArray<PPCommunityFile *> * _Nullable files, NSError * _Nullable error);

// MARK: - Friends

typedef void (^PPFriendsFriendshipBlock)(NSArray * _Nullable friendships, NSError * _Nullable error);

// MARK: - Circles

typedef void (^PPCircleCreationBlock)(PPCircleId circleId, NSError * _Nullable error);
typedef void (^PPCirclesBlock)(NSArray * _Nullable circles, NSError * _Nullable error);
typedef void (^PPCircleFileUploadBlock)(PPFileId fileId, PPFileThumbnail thumbnail, PPCircleData monthlyDataIn, PPCircleData monthlyDataMax, NSError * _Nullable error);
typedef void (^PPCircleFileUploadFragmentBlock)(PPFileThumbnail thumbnail, NSError * _Nullable error);
typedef void (^PPCircleFilesBlock)(NSArray * _Nullable files, NSString * _Nullable tempKey, NSDate * _Nullable tempKeyExpire, PPCircleData monthlyDataIn, PPCircleData monthlyDataMax, NSError * _Nullable error);
typedef void (^PPCircleFileContentBlock)(NSData * _Nullable fileData, NSString * _Nullable contentType, NSString * _Nullable contentRange, NSString * _Nullable acceptRanges, NSString * _Nullable contentDisposition,NSInteger statusCode, NSError * _Nullable error);
typedef void (^PPCircleFileDownloadURLBlock)(NSURL * _Nullable contentURL, NSURL * _Nullable thumbnailURL, NSURL * _Nullable m3u8URL, NSError * _Nullable error);
typedef void (^PPCirclePostMakeBlock)(PPCirclePostId postId, NSError * _Nullable error);
typedef void (^PPCirclePostsBlock)(NSArray * _Nullable posts, NSError * _Nullable error);
typedef void (^PPCircleDevicesBlock)(NSArray * _Nullable devices, NSError * _Nullable error);
typedef void (^PPCircleFileProgressBlock)(NSProgress * _Nullable progress);

// MARK: - Reports

typedef void (^PPReportAlertTypesBlock)(NSArray * _Nullable alerts, NSError * _Nullable error);

// MARK: - Botengine

@class PPBotengineApp;
@class PPBotengineAppRating;

typedef void (^PPBotengineAppsBlock)(NSArray * _Nullable apps, NSError * _Nullable error);
typedef void (^PPBotengineAppObjectBlock)(NSObject * _Nullable appObject, NSError * _Nullable error);
typedef void (^PPBotengineAppInfoBlock)(PPBotengineApp * _Nullable app, NSError * _Nullable error);
typedef void (^PPBotengineAppPurchaseBlock)(NSInteger appInstanceId, NSError * _Nullable error);
typedef void (^PPBotengineAppReviewBlock)(PPBotengineAppRating * _Nullable rating, NSArray * _Nullable reviews, NSError * _Nullable error);
typedef void (^PPBotengineSummaryBlock)(NSArray * _Nullable dataStreams, NSArray * _Nullable microServices, NSError * _Nullable error);

// MARK: - Organization

typedef void (^PPOrganizationsBlock)(NSArray * _Nullable orgs, NSError * _Nullable error);
typedef void (^PPOrganizationsGroupsBlock)(NSArray * _Nullable groups, NSError * _Nullable error);
typedef void (^PPOrganizationsUpdateUserBlock)(PPOrganizationStatus status, NSError * _Nullable error);
typedef void (^PPOrganizationsObjectsAndPropertiesBlock)(NSArray * _Nullable objectsAndProperties, NSError * _Nullable error);

#endif /* PPTypeDefinitions_h */
