//
//  PPCallCenterAlert.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/12/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPCallCenter.h"
#import "PPDevice.h"

typedef NS_OPTIONS(NSInteger, PPCallCenterAlertSourceType) {
    PPCallCenterAlertSourceTypeNone = 1,
    PPCallCenterAlertSourceTypeUnknown = 0, // Unknown
    PPCallCenterAlertSourceTypeRule = 1, // Raised by a rule
    PPCallCenterAlertSourceTypeBotengine = 2, // Raised by a botengine app
    PPCallCenterAlertSourceTypeApp = 3, // Raised by an app API
};

@interface PPCallCenterAlert : PPBaseModel

@property (nonatomic, strong) NSDate *alertDate;
@property (nonatomic) NSInteger alertDateMS;
@property (nonatomic) PPCallCenterAlertStatus alertStatus;
@property (nonatomic, strong) NSString *signalType;
@property (nonatomic, strong) NSString *signalMessage;
@property (nonatomic) PPCallCenterAlertSourceType alertSourceType;
@property (nonatomic, strong) PPDevice *device;

- (id)initWithAlertDate:(NSDate *)alertDate alertDateMS:(NSInteger)alertDateMS alertStatus:(PPCallCenterAlertStatus)alertStatus signalType:(NSString *)signalType signalMessage:(NSString *)signalMessage alertSourceType:(PPCallCenterAlertSourceType)alertSourceType device:(PPDevice *)device;

+ (PPCallCenterAlert *)initWithDictionary:(NSDictionary *)alertDict;

@end
