//
//  PPCrowdFeedbackSupport.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

@interface PPCrowdFeedbackSupport : PPBaseModel

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *subject;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *subscribe;

- (id)initWithFirstName:(NSString *)firstName lastName:(NSString *)lastName email:(NSString *)email subject:(NSString *)subject text:(NSString *)text subscribe:(NSString *)subscribe;

+ (PPCrowdFeedbackSupport *)initWithDictionary:(NSDictionary *)supportDict;

+ (NSString *)stringify:(PPCrowdFeedbackSupport *)support;
+ (NSDictionary *)data:(PPCrowdFeedbackSupport *)support;

@end
