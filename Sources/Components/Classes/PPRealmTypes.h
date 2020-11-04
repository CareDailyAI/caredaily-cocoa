//
//  PPRealmTypes.h
//  Peoplepower
//
//  Created by Destry Teeter on 7/6/20.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#ifndef PPRealmTypes_h
#define PPRealmTypes_h

// MARK: - Cloud Connectivity

RLM_ARRAY_TYPE(PPCloudConnectivityServer)
RLM_ARRAY_TYPE(PPCloudConnectivityCloud)

// MARK: - User Accounts

// MARK: Location

RLM_ARRAY_TYPE(PPLocation)
RLM_ARRAY_TYPE(PPLocationCommunity)
RLM_ARRAY_TYPE(PPLocationSpace)
RLM_ARRAY_TYPE(PPLocationOccupantsRange)
RLM_ARRAY_TYPE(PPLocationSize)
RLM_ARRAY_TYPE(PPLocationSceneEvent)
RLM_ARRAY_TYPE(PPLocationNarrative)
RLM_ARRAY_TYPE(PPLocationNarrativeTarget)
RLM_ARRAY_TYPE(PPLocationUserSchedule)

// MARK: User

RLM_ARRAY_TYPE(PPUser)
RLM_ARRAY_TYPE(PPUserEmail)
RLM_ARRAY_TYPE(PPUserBadge)
RLM_ARRAY_TYPE(PPUserTag)
RLM_ARRAY_TYPE(PPUserCode)
RLM_ARRAY_TYPE(PPUserService)
RLM_ARRAY_TYPE(PPUserCommunity)

// MARK: Countries States and Timezones

RLM_ARRAY_TYPE(PPCountry)
RLM_ARRAY_TYPE(PPState)
RLM_ARRAY_TYPE(PPTimezone)

// MARK: - Devices

RLM_ARRAY_TYPE(PPDevice)

// MARK: Picture Frames

RLM_ARRAY_TYPE(PPDevicePictureFrame)
RLM_ARRAY_TYPE(PPDevicePictureFrameLocal)
RLM_ARRAY_TYPE(PPDevicePictureFrameAlert)

// MARK: Cameras

RLM_ARRAY_TYPE(PPDeviceCamera)
RLM_ARRAY_TYPE(PPDeviceCameraLocal)
RLM_ARRAY_TYPE(PPVideoToken)

// MARK: Device Properties

RLM_ARRAY_TYPE(PPDeviceProperty)

// MARK: Device Activation Info

RLM_ARRAY_TYPE(PPDeviceActivationInfo)

// MARK: Firmware Updates

RLM_ARRAY_TYPE(PPDeviceFirmwareUpdateJob)

// MARK: - Device Measurements

RLM_ARRAY_TYPE(PPDeviceMeasurement)
RLM_ARRAY_TYPE(PPDeviceMeasurementsReading)
RLM_ARRAY_TYPE(PPDeviceMeasurementsAlert)
RLM_ARRAY_TYPE(PPDeviceMeasurementUnit)
RLM_ARRAY_TYPE(PPDeviceParameter)
RLM_ARRAY_TYPE(PPDeviceCommand)
RLM_ARRAY_TYPE(PPDeviceParameterRobotVantagePoint)
RLM_ARRAY_TYPE(PPDeviceDataRequest)

// MARK: - Communications

// MARK: Notification

RLM_ARRAY_TYPE(PPNotificationMessage)
RLM_ARRAY_TYPE(PPNotificationMessageModel)
RLM_ARRAY_TYPE(PPNotificationSubscription)
RLM_ARRAY_TYPE(PPNotificationPushMessage)
RLM_ARRAY_TYPE(PPNotificationPushMessageInfo)
RLM_ARRAY_TYPE(PPNotificationEmailMessage)
RLM_ARRAY_TYPE(PPNotificationEmailMessageAttachment)
RLM_ARRAY_TYPE(PPNotificationSMSMessage)
RLM_ARRAY_TYPE(PPNotificationToken)
RLM_ARRAY_TYPE(PPNotification)

// MARK: Crowd Feedback

RLM_ARRAY_TYPE(PPCrowdFeedback)
RLM_ARRAY_TYPE(PPCrowdFeedbackSupport)
RLM_ARRAY_TYPE(PPCrowdFeedbackTicket)

// MARK: In-App Messaging

RLM_ARRAY_TYPE(PPInAppMessage)
RLM_ARRAY_TYPE(PPInAppMessageParameters)
RLM_ARRAY_TYPE(PPInAppMessageRecipient)

// MARK: Questions

RLM_ARRAY_TYPE(PPQuestion)
RLM_ARRAY_TYPE(PPQuestionCollection)
RLM_ARRAY_TYPE(PPQuestionResponseOption)
RLM_ARRAY_TYPE(PPQuestionAnswer)

// MARK: SMS Group Texting

RLM_ARRAY_TYPE(PPSMSSubscriber)

// MARK: Surveys

RLM_ARRAY_TYPE(PPSurveyQuestion)

// MARK: - System and User Properties

RLM_ARRAY_TYPE(PPProperty)

// MARK: - File Management

RLM_ARRAY_TYPE(PPFile)
RLM_ARRAY_TYPE(PPFileTag)
RLM_ARRAY_TYPE(PPFileSummary)

// MARK: - Application Files

RLM_ARRAY_TYPE(PPApplicationFile)

// MARK: - Rules

RLM_ARRAY_TYPE(PPRule)
RLM_ARRAY_TYPE(PPRuleComponent)
RLM_ARRAY_TYPE(PPRuleComponentTrigger)
RLM_ARRAY_TYPE(PPRuleComponentState)
RLM_ARRAY_TYPE(PPRuleComponentAction)
RLM_ARRAY_TYPE(PPRuleComponentParameter)
RLM_ARRAY_TYPE(PPRuleComponentParameterValue)
RLM_ARRAY_TYPE(PPRuleCalendar)

// MARK: - Paid Services

RLM_ARRAY_TYPE(PPServicePlan)
RLM_ARRAY_TYPE(PPServicePlanSoftwareSubscription)
RLM_ARRAY_TYPE(PPServicePlanPrice)
RLM_ARRAY_TYPE(PPServicePlanPriceAmount)
RLM_ARRAY_TYPE(PPServicePlanTransaction)
RLM_ARRAY_TYPE(PPStoreProduct)

// MARK: - Professional Monitoring

RLM_ARRAY_TYPE(PPCallCenter)
RLM_ARRAY_TYPE(PPCallCenterContact)
RLM_ARRAY_TYPE(PPCallCenterAlert)

// MARK: - Dynamic User Interfaces

RLM_ARRAY_TYPE(PPDynamicUIScreen)
RLM_ARRAY_TYPE(PPDynamicUIScreenSection)
RLM_ARRAY_TYPE(PPDynamicUIScreenSectionItem)

// MARK: - Energy Management

RLM_ARRAY_TYPE(PPEnergyManagementUsage)
RLM_ARRAY_TYPE(PPEnergyManagementUtilityBill)
RLM_ARRAY_TYPE(PPEnergyManagementDeviceUsageEnergy)
RLM_ARRAY_TYPE(PPEnergyManagementDeviceUsagePower)
RLM_ARRAY_TYPE(PPEnergyManagementDeviceUsageAggregated)
RLM_ARRAY_TYPE(PPEnergyManagementDeviceUsageAggregatedEnergy)
RLM_ARRAY_TYPE(PPEnergyManagementDeviceUsageAggregatedCost)
RLM_ARRAY_TYPE(PPEnergyManagementBillingInfo)
RLM_ARRAY_TYPE(PPEnergyManagementBillingInfoBudget)
RLM_ARRAY_TYPE(PPEnergyManagementBillingInfoUtility)
RLM_ARRAY_TYPE(PPEnergyManagementBillingInfoBillingRate)

// MARK: - Weather

RLM_ARRAY_TYPE(PPWeather)
RLM_ARRAY_TYPE(PPWeatherMetadata)
RLM_ARRAY_TYPE(PPWeatherForecast)
RLM_ARRAY_TYPE(PPWeatherObservation)
RLM_ARRAY_TYPE(PPWeatherObservationMetric)

// MARK: - Products

RLM_ARRAY_TYPE(PPDeviceType)
RLM_ARRAY_TYPE(PPDeviceTypeAttribute)
RLM_ARRAY_TYPE(PPDeviceTypeAttributeOption)
RLM_ARRAY_TYPE(PPDeviceTypeParameter)
RLM_ARRAY_TYPE(PPDeviceTypeParameterDisplayInfo)
RLM_ARRAY_TYPE(PPDeviceTypeRuleComponentTemplate)
RLM_ARRAY_TYPE(PPDeviceTypeRuleComponentTemplateProduct)
RLM_ARRAY_TYPE(PPDeviceTypeGoal)
RLM_ARRAY_TYPE(PPDeviceTypeGoalSpaceTypes)
RLM_ARRAY_TYPE(PPDeviceTypeInstallationInstructions)
RLM_ARRAY_TYPE(PPDeviceTypeMedia)
RLM_ARRAY_TYPE(PPDeviceTypeMediaDesc)
RLM_ARRAY_TYPE(PPDeviceTypeDeviceModel)
RLM_ARRAY_TYPE(PPDeviceTypeDeviceModelManufacture)
RLM_ARRAY_TYPE(PPDeviceTypeDeviceModelName)
RLM_ARRAY_TYPE(PPDeviceTypeDeviceModelDesc)
RLM_ARRAY_TYPE(PPDeviceTypeStory)
RLM_ARRAY_TYPE(PPDeviceTypeDeviceModelCategoryName)
RLM_ARRAY_TYPE(PPDeviceTypeDeviceModelBrandName)
RLM_ARRAY_TYPE(PPDeviceTypeDeviceModelBrandDesc)
RLM_ARRAY_TYPE(PPDeviceTypeDeviceModelBrand)
RLM_ARRAY_TYPE(PPDeviceTypeDeviceModelLookupParam)
RLM_ARRAY_TYPE(PPDeviceTypeStoryPage)
RLM_ARRAY_TYPE(PPDeviceTypeStoryPageAction)
RLM_ARRAY_TYPE(PPDeviceTypeStoryModel)

// MARK: - Clouds Integration

RLM_ARRAY_TYPE(PPCloudsIntegrationCloud)
RLM_ARRAY_TYPE(PPCloudsIntegrationClient)
RLM_ARRAY_TYPE(PPCloudsIntegrationHost)
RLM_ARRAY_TYPE(PPCloudsIntegrationHostAccessToken)

// MARK: - Community

RLM_ARRAY_TYPE(PPCommunityPost)
RLM_ARRAY_TYPE(PPCommunityPostReminder)
RLM_ARRAY_TYPE(PPCommunityReaction)
RLM_ARRAY_TYPE(PPCommunityComment)
RLM_ARRAY_TYPE(PPCommunityUser)
RLM_ARRAY_TYPE(PPCommunityLocation)
RLM_ARRAY_TYPE(PPCommunityFile)

// MARK: - Friends

RLM_ARRAY_TYPE(PPFriendship)
RLM_ARRAY_TYPE(PPFriendshipFriend)
RLM_ARRAY_TYPE(PPFriendshipDevice)

// MARK: - Circles

RLM_ARRAY_TYPE(PPCircle)
RLM_ARRAY_TYPE(PPCircleMember)
RLM_ARRAY_TYPE(PPCircleFile)
RLM_ARRAY_TYPE(PPCirclePost)
RLM_ARRAY_TYPE(PPCircleReaction)
RLM_ARRAY_TYPE(PPCircleDevice)
RLM_ARRAY_TYPE(PPCircleDeviceCamera)
RLM_ARRAY_TYPE(PPCircleDevicePictureFrame)

// MARK: - Reports

RLM_ARRAY_TYPE(PPDeviceAlert)

// MARK: - Botengine

RLM_ARRAY_TYPE(PPBotengineApp)
RLM_ARRAY_TYPE(PPBotengineAppAccess)
RLM_ARRAY_TYPE(PPBotengineAppCommunications)
RLM_ARRAY_TYPE(PPBotengineAppDeviceType)
RLM_ARRAY_TYPE(PPBotengineAppInstance)
RLM_ARRAY_TYPE(PPBotengineAppMarketing)
RLM_ARRAY_TYPE(PPBotengineAppRating)
RLM_ARRAY_TYPE(PPBotengineAppReview)
RLM_ARRAY_TYPE(PPBotengineAppVersion)

// MARK: - Organization

RLM_ARRAY_TYPE(PPOrganization)
RLM_ARRAY_TYPE(PPOrganizationGroup)
RLM_ARRAY_TYPE(PPOrganizationObject)

// MARK: - Networking

RLM_ARRAY_TYPE(PPVersion)

// MARK: -
// MARK: - Categories

RLM_ARRAY_TYPE(PPRLMDictionary)

#endif /* PPRealmTypes_h */
