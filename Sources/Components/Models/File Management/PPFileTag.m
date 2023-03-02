//
//  PPFileTag.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPFileTag.h"

@implementation PPFileTag

- (instancetype)initWithTag:(NSString *)tag appId:(PPFileTagAppId)appId appName:(NSString *)appName {
    self = [super init];
    if(self) {
        self.tag = tag;
        self.appId = appId;
        self.appName = appName;
    }
    return self;
}

+ (PPFileTag *)initWithDictionary:(NSDictionary *)tagDict {
    NSString *tag = [tagDict objectForKey:@"tag"];
    PPFileTagAppId appId = PPFileTagAppIdNone;
    if([tagDict objectForKey:@"appId"]) {
        appId = (PPFileTagAppId)((NSString *)[tagDict objectForKey:@"appId"]).integerValue;
    }
    NSString *appName = [tagDict objectForKey:@"appName"];
    
    PPFileTag *fileTag = [[PPFileTag alloc] initWithTag:tag appId:appId appName:appName];
    return fileTag;
}

@end
