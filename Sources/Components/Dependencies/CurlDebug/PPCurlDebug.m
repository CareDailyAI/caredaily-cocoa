//
//  NSMutableHTTPURLRequest+CurlDescription.m
//  Easy to read and use Curl description for NSMutableURLRequest
//
//  Created by Mugunth Kumar on 7/11/11.
//  Copyright (c) 2011 Steinlogic. All rights reserved.
//
//  As a side note on using this code, you might consider giving some credit to me by
//	1) linking my website from your app's website 
//	2) or crediting me inside the app's credits page 
//	3) or a tweet mentioning @mugunthkumar
//	4) A paypal donation to mugunth.kumar@gmail.com
//
//  A note on redistribution
//	if you are re-publishing after editing, please retain the above copyright notices

#import "PPCurlDebug.h"

@implementation PPCurlDebug

+ (NSString *)requestToDescription:(NSURLRequest *)request {
    __block NSMutableString *displayString = [NSMutableString stringWithFormat:@"%@\nRequest\n-------\ncurl -X %@ \\",
                                              [[NSDate date] descriptionWithLocale:[NSLocale currentLocale]],
                                              [request HTTPMethod]];
    
    [[request allHTTPHeaderFields] enumerateKeysAndObjectsUsingBlock:^(id key, id val, BOOL *stop)
     {
         [displayString appendFormat:@"\n -H \"%@: %@\" \\", key, val];
     }];
    
    [displayString appendFormat:@"\n \"%@\" \\",  [request.URL absoluteString]];
    
    if ([request HTTPBody]) {
        NSString *bodyString = [[NSString alloc] initWithData:[request HTTPBody] encoding:NSUTF8StringEncoding];
        [displayString appendFormat:@"\n -d \"%@\" \\", bodyString];
    }
	
    return displayString;
}

+ (NSString *)responseToDescription:(NSDictionary *)response {
    __block NSString *displayString = [NSString stringWithFormat:@"%@\nResponse\n-------\n%@",
                                              [[NSDate date] descriptionWithLocale:[NSLocale currentLocale]],
                                              response];
    
    return displayString;
}

@end
