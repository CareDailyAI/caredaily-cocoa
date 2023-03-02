//
//  PPFileTag.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

@interface PPFileTag : PPBaseModel

@property (nonatomic, strong) NSString *tag;
@property (nonatomic) PPFileTagAppId appId;
@property (nonatomic, strong) NSString *appName;

- (id)initWithTag:(NSString *)tag appId:(PPFileTagAppId)appId appName:(NSString *)appName;

+ (PPFileTag *)initWithDictionary:(NSDictionary *)tagDict;

@end
