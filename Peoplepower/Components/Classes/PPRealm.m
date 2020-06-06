//
//  PPRealm.m
//  PPiOSCore-Framework
//
//  Created by Destry Teeter on 6/12/18.
//  Copyright © 2018 People Power Company. All rights reserved.
//

#import "PPRealm.h"

@implementation PPRealm

+ (void)configureDefaultRealm {
    [PPRealm configureDefaultRealm:nil];
}

+ (void)configureDefaultRealm:(NSURL *)fileUrl {
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    if (fileUrl) {
        [config setFileURL:fileUrl];
    }
    config.deleteRealmIfMigrationNeeded = YES;
    [RLMRealmConfiguration setDefaultConfiguration:config];
#ifdef DEBUG
    NSLog(@"%s realm file: %@", __PRETTY_FUNCTION__, config.fileURL);
#endif
}

+ (RLMRealm *)defaultRealm {
    RLMRealm *realm = [RLMRealm defaultRealm];
    return realm;
}

+ (void)cleanDatabase {
    RLMRealm *realm = [PPRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm deleteAllObjects];
    [realm commitWriteTransaction];
}

@end
