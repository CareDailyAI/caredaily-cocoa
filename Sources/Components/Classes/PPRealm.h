//
//  PPRealm.h
//  Peoplepower
//
//  Created by Destry Teeter on 6/12/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import <Realm/Realm.h>

@interface PPRealm : NSObject

+ (void)configureDefaultRealm;
+ (void)configureDefaultRealm:(NSURL *)fileUrl;
+ (RLMRealm *)defaultRealm;
+ (void)cleanDatabase;

@end
