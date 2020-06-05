//
//  PPBaseTestCase.h
//  PPiOSCore-Tests
//
//  Created by Destry Teeter on 2/12/20.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import <XCTest/XCTest.h>

NS_ASSUME_NONNULL_BEGIN

@interface PPBaseTestCase : XCTestCase

- (void)stubRequestForModule:(NSString * _Nonnull )moduleName methodName:(NSString * _Nonnull )methodName ofType:(NSString * _Nonnull )type path:(NSString * _Nonnull )path statusCode:(int)statusCode headers:(NSDictionary * _Nullable )headers;

@end

NS_ASSUME_NONNULL_END
