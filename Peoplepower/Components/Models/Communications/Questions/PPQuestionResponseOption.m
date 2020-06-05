//
//  PPQuestionResponseOption.m
//  PPiOSCore
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPQuestionResponseOption.h"

@implementation PPQuestionResponseOption

- (id)initWithId:(PPResponseOptionId)responseOptionId text:(NSString *)text total:(PPResponseOptionTotal)total {
    self = [super init];
    if(self) {
        self.responseOptionId = responseOptionId;
        self.text = text;
        self.total = total;
    }
    return self;
}

+ (PPQuestionResponseOption *)initWithDictionary:(NSDictionary *)responseOptionDict {
    
    PPResponseOptionId responseOptionId = PPResponseOptionIdNone;
    if([responseOptionDict objectForKey:@"id"]) {
        responseOptionId = (PPResponseOptionId)((NSString *)[responseOptionDict objectForKey:@"id"]).integerValue;
    }
    NSString *text = [responseOptionDict objectForKey:@"text"];
    PPResponseOptionTotal total = PPResponseOptionTotalNone;
    if([responseOptionDict objectForKey:@"total"]) {
        total = (PPResponseOptionTotal)((NSString *)[responseOptionDict objectForKey:@"total"]).integerValue;
    }
    
    PPQuestionResponseOption *responseOption = [[PPQuestionResponseOption alloc] initWithId:responseOptionId text:text total:total];
    return responseOption;
}

@end
