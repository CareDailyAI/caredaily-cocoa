//
//  PPCallCenter.h
//  PPiOSCore
//
//  Created by Destry Teeter on 3/12/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//
// User can specify call center contacts and check the call center service status.
//

#import "PPBaseModel.h"
#import "PPCallCenterContact.h"

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

@interface PPCallCenter : RLMObject

@property (nonatomic) PPCallCenterStatus status;
@property (nonatomic) PPUserId userId;
@property (nonatomic, strong) RLMArray<RLMString> *missingFields;
@property (nonatomic, strong) RLMArray<PPCallCenterContact *><PPCallCenterContact> *contacts;
@property (nonatomic, strong) NSString *codeword;
@property (nonatomic, strong) NSString *permit;
@property (nonatomic) PPCallCenterAlertStatus alertStatus;
@property (nonatomic, strong) NSDate *alertDate;
@property (nonatomic, strong) NSDate *alertStatusDate;

@property (nonatomic, strong) NSString *identifier;

- (id)initWithStatus:(PPCallCenterStatus)status userId:(PPUserId)userId missingFields:(RLMArray *)missingFields contacts:(RLMArray *)contacts codeword:(NSString *)codeword permit:(NSString *)permit alertStatus:(PPCallCenterAlertStatus)alertStatus alertDate:(NSDate *)alertDate alertStatusDate:(NSDate *)alertStatusDate;

+ (PPCallCenter *)initWithDictionary:(NSDictionary *)callCenterDict;

+ (NSString *)stringify:(PPCallCenter *)callCenter;

@end

RLM_ARRAY_TYPE(PPCallCenter);
