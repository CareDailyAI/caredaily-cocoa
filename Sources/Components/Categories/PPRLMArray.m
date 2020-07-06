//
//  PPRLMArray.m
//  PPiOSCore
//
//  Created by Destry Teeter on 6/6/18.
//  Copyright © 2018 People Power Company. All rights reserved.
//

#import "PPRLMArray.h"

@implementation PPRLMArray

+ (NSString *)stringArray:(RLMArray *)array componentsJoinedByString:(NSString *)joiningString {
    if([array count] == 0) {
        return @"";
    }
    
    NSMutableString *strings = [[NSMutableString alloc] init];
    BOOL appendStringComma = NO;
    
    if([[array firstObject] isKindOfClass:[NSString class]]) {
        for(NSString *o in array) {
            if(appendStringComma) {
                [strings appendString:joiningString];
            }
            [strings appendString:o];
            appendStringComma = YES;
        }
    }
    else if([[array firstObject] isKindOfClass:[NSNumber class]]) {
        for(NSNumber *o in array) {
            if(appendStringComma) {
                [strings appendString:joiningString];
            }
            [strings appendFormat:@"%@", o.stringValue];
            appendStringComma = YES;
        }
    }
    return strings;
}

+ (NSArray *)arrayFromArray:(RLMArray *)array {
    NSMutableArray *a = [[NSMutableArray alloc] initWithCapacity:[array count]];
    for(RLMObject *o in array) {
        [a addObject:o];
    }
    return a;
}

@end
