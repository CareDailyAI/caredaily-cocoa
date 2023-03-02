//
//  PPNSString.m
//  Peoplepower
//
//  Created by Ryan Grimm on 12/11/12.
//  Copyright (c) 2023 People Power Company. All rights reserved.
//

#import "PPNSString.h"

@implementation PPNSString

+ (NSString *)stringByAddingURIPercentEscapesUsingEncoding:(NSStringEncoding)inEncoding toString:(NSString *)toString {
    NSString *escapedString;
    NSString *charactersToBeEscaped = @":/?=,!$&'()*+;[]@#| ";
    if(@available(iOS 9.0, *)) {
        escapedString = [toString stringByAddingPercentEncodingWithAllowedCharacters:[[NSCharacterSet characterSetWithCharactersInString:charactersToBeEscaped] invertedSet]];
    }
    else {
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
        escapedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
            kCFAllocatorDefault, (CFStringRef)toString, NULL,
            (CFStringRef)charactersToBeEscaped,
            CFStringConvertNSStringEncodingToEncoding(inEncoding)
        ));
#pragma GCC diagnostic pop
    }
    
    return escapedString;
}

@end
