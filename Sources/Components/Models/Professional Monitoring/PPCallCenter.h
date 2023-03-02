//
//  PPCallCenter.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/12/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//
// User can specify call center contacts and check the call center service status.
//

#import "PPBaseModel.h"
#import "PPCallCenterContact.h"

@interface PPCallCenter : PPBaseModel

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
