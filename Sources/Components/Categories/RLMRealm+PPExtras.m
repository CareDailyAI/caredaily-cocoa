//
//  RLMRealm+PPExtras.m
//  Peoplepower
//
//  Created by Destry Teeter on 6/22/20.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "RLMRealm+PPExtras.h"

@implementation RLMRealm (PPExtras)

- (BOOL)pp_beginWriteTransaction:(NSError *__autoreleasing *)error {
    if ([self inWriteTransaction]) {
        *error = [NSError errorWithDomain:@"com.peoplepowerco.lib.Peoplepower.realm"
                                     code:1
                                 userInfo:@{
                                     NSLocalizedDescriptionKey: @"Failure to begin write transaction.",
                                     NSLocalizedRecoverySuggestionErrorKey: @"Realm is already in a write transaction."
                                 }];
    }
    else {
        [self beginWriteTransaction];
    }
    return true;
}

@end
