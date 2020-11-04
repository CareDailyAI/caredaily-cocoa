//
//  PPCrowdFeedback.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

@interface PPCrowdFeedback : PPBaseModel

@property (nonatomic) PPCrowdFeedbackId feedbackId;
@property (nonatomic, strong) NSString *appName;
@property (nonatomic, strong) NSString *appVersion;
@property (nonatomic) PPCrowdFeedbackType type;
@property (nonatomic, strong) NSString *subject;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *deviceId;
@property (nonatomic, strong) NSString *deviceModel;
@property (nonatomic, strong) NSString *deviceOs;
@property (nonatomic) PPCrowdFeedbackProductId productId;
@property (nonatomic) PPCrowdFeedbackProductCategory productCategory;
@property (nonatomic, strong) NSString *viewer;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic) PPCrowdFeedbackVotingCount votingCount;
@property (nonatomic) PPCrowdFeedbackRank rank;
@property (nonatomic) PPCrowdFeedbackEnabled enabled;

- (id)initWithFeedbackId:(PPCrowdFeedbackId)feedbackId appName:(NSString *)appName appVersion:(NSString *)appVersion type:(PPCrowdFeedbackType)type subject:(NSString *)subject email:(NSString *)email deviceId:(NSString *)deviceId deviceModel:(NSString *)deviceModel deviceOs:(NSString *)deviceOs productId:(PPCrowdFeedbackProductId)productId productCategory:(PPCrowdFeedbackProductCategory)productCategory viewer:(NSString *)viewer desc:(NSString *)desc votingCount:(PPCrowdFeedbackVotingCount)votingCount rank:(PPCrowdFeedbackRank)rank enabled:(PPCrowdFeedbackEnabled)enabled;

+ (PPCrowdFeedback *)initWithDictionary:(NSDictionary *)feedbackDict;

+ (NSString *)stringify:(PPCrowdFeedback *)feedback;
+ (NSDictionary *)data:(PPCrowdFeedback *)feedback;

#pragma mark - Helper methods

- (BOOL)isEqualToFeedback:(PPCrowdFeedback *)feedback;

- (void)sync:(PPCrowdFeedback *)feedback;

@end
