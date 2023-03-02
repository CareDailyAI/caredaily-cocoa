//
//  PPNetworkUtilities.m
//  Peoplepower
//
//  Copyright (c) 2023 People Power Company. All rights reserved.
//

#import "PPNetworkUtilities.h"
#import "PPBaseModel.h"

@implementation PPNetworkUtilities

+ (NSString *)makeAPIFriendly:(NSString *)value {
	NSMutableString *text = [NSMutableString stringWithString:value];
	[text replaceOccurrencesOfString:@"&"  withString:@"&amp;"  options:NSLiteralSearch range:NSMakeRange(0, [text length])];
	[text replaceOccurrencesOfString:@"\"" withString:@"&quot;" options:NSLiteralSearch range:NSMakeRange(0, [text length])];
	[text replaceOccurrencesOfString:@"'"  withString:@"&#x27;" options:NSLiteralSearch range:NSMakeRange(0, [text length])];
	[text replaceOccurrencesOfString:@">"  withString:@"&gt;"   options:NSLiteralSearch range:NSMakeRange(0, [text length])];
	[text replaceOccurrencesOfString:@"<"  withString:@"&lt;"   options:NSLiteralSearch range:NSMakeRange(0, [text length])];
	return text;
}

@end
