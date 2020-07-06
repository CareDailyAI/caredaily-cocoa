//
//  PPRealm.h
//  PPiOSCore-Framework
//
//  Created by Destry Teeter on 6/12/18.
//  Copyright © 2018 People Power Company. All rights reserved.
//

#import <Realm/Realm.h>

@interface PPRealm : NSObject

+ (void)configureDefaultRealm;
+ (void)configureDefaultRealm:(NSURL *)fileUrl;
+ (RLMRealm *)defaultRealm;
+ (void)cleanDatabase;

@end
