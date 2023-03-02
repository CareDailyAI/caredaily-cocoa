//
//  PPNSString.h
//  Peoplepower
//
//  Created by Ryan Grimm on 12/11/12.
//  Copyright (c) 2023 People Power Company. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PPNSString : NSObject

+ (NSString *)stringByAddingURIPercentEscapesUsingEncoding:(NSStringEncoding)inEncoding toString:(NSString *)toString;

@end
