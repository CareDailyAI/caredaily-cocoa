//
//  PPBaseTestCase.m
//  Peoplepower-Tests
//
//  Created by Destry Teeter on 2/12/20.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseTestCase.h"

#import <Peoplepower/PPNSData.h>
#import <OHHTTPStubs/OHHTTPStubs.h>

@implementation PPBaseTestCase

- (void)setUp {
    [super setUp];
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    config.inMemoryIdentifier = self.name;
    [RLMRealmConfiguration setDefaultConfiguration:config];
    
    // Supress Analytics
    [self stubRequestForModule:@"SystemAndUserProperties" methodName:@"GetSystemProperty-Analytics_Level" ofType:@"txt" path:@"/espapi/cloud/json/systemProperty/analytics-level" statusCode:200 headers:nil];
}

- (void)stubRequestForModule:(NSString *)moduleName methodName:(NSString *)methodName ofType:(NSString *)type path:(NSString *)path statusCode:(int)statusCode headers:(NSDictionary *)headers {
    [HTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest * _Nonnull request) {
        return [request.URL.path isEqualToString:path] || [request.URL.path isEqualToString:[NSString stringWithFormat:@"/espapi%@", path]];
    } withStubResponse:^HTTPStubsResponse * _Nonnull(NSURLRequest * _Nonnull request) {

        NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:[NSString stringWithFormat:@"%@-%@-ResponseData", moduleName, methodName] ofType:type];
        NSError *error;

        if ([type isEqualToString:@"json"]) {
            @try {
                NSData *jsonData = [NSData dataWithContentsOfFile:path];
                NSDictionary *data = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
                return [HTTPStubsResponse responseWithJSONObject:data statusCode:statusCode headers:headers];
            } @catch (NSException *exception) {
                NSLog(@"ERROR EXTRACTING STUB DATA (json): %@", exception);
                return [HTTPStubsResponse responseWithJSONObject:@{@"resultCode": @(1)} statusCode:statusCode headers:headers];
            }
        }
        else if ([type isEqualToString:@"txt"]) {
            @try {
                NSString *response = [[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                return [HTTPStubsResponse responseWithData:[response dataUsingEncoding:NSUTF8StringEncoding] statusCode:statusCode headers:headers];
            } @catch (NSException *exception) {
                NSLog(@"ERROR EXTRACTING STUB DATA (txt): %@", exception);
                return [HTTPStubsResponse responseWithData:[@"ERROR" dataUsingEncoding:NSUTF8StringEncoding] statusCode:statusCode headers:headers];
            }
        }
        else if ([type isEqualToString:@"data"]) {
            @try {
                NSString *dataString = [[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                NSData *imgData = [PPNSData dataFromBase64String:dataString];
                return [HTTPStubsResponse responseWithData:imgData statusCode:statusCode headers:headers];
            } @catch (NSException *exception) {
                NSLog(@"ERROR EXTRACTING STUB DATA (data): %@", exception);
                return [HTTPStubsResponse responseWithJSONObject:@{@"resultCode": @(1)} statusCode:statusCode headers:headers];
            }
        }
        else {
            return nil;
        }
    }];
}
@end
