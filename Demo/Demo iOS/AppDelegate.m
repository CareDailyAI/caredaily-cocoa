//
//  AppDelegate.m
//  PeoplepowerDemo
//
//  Created by Destry Teeter on 6/5/20.
//  Copyright © 2020 peoplepowerco. All rights reserved.
//

#import "AppDelegate.h"
@import Peoplepower;

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSLog(@"" \
          "\n-------------" \
          "\n %@" \
          /*"\n v%@" \*/
          "\n v%@" \
          "\n-------------",
          [PPBaseModel appName:NO],
          /*[[PPVersion myVersion] toNSString],*/
          [self version]
          );
    return YES;
}

- (NSString *)version {
    NSString *ver = [NSString stringWithUTF8String:(char *)PeoplepowerVersionStringPtr];
    NSRange range = [ver rangeOfString:@"-"];
    if (range.location == NSNotFound) {
        return @"N/A";
    }
    return [[[ver componentsSeparatedByString:@"-"] lastObject] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
