//
//  RLMRealm+PPExtras.h
//  PPiOSCore
//
//  Created by Destry Teeter on 6/22/20.
//  Copyright © 2020 People Power Company. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN

@interface RLMRealm (PPExtras)

- (BOOL)pp_beginWriteTransaction:(NSError *__autoreleasing *)error;

@end

NS_ASSUME_NONNULL_END
