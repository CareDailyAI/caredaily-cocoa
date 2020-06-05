//
//  PPBotengineAppVersion.m
//  PPiOSCore
//
//  Created by Destry Teeter on 3/7/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBotengineAppVersion.h"

@implementation PPBotengineAppVersion

- (id)initWithVersion:(NSString *)version creationDate:(NSDate *)creationDate statusChangeDage:(NSDate *)statusChangeDate whatsNew:(NSString *)whatsNew rating:(PPBotengineAppRating *)rating {
    self = [super init];
    if(self) {
        self.version = version;
        self.creationDate = creationDate;
        self.statusChangeDate = statusChangeDate;
        self.whatsNew = whatsNew;
        self.rating = rating;
    }
    return self;
}
@end
