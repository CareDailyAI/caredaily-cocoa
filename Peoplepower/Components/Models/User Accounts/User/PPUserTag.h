//
//  PPUserTag.h
//  PPiOSCore
//
//  Created by Destry Teeter on 3/6/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

@interface PPUserTag : RLMObject <NSCopying>
/* An app can apply and remove tags to mark the user. */

/* User tags */
@property (strong, nonatomic) NSString *tag;

- (id)initWithTag:(NSString *)tag;

+ (PPUserTag *)initWithDictionary:(NSDictionary *)tagDict;

#pragma mark - Helper methods

- (void)sync:(PPUserTag *)userTag;

@end

RLM_ARRAY_TYPE(PPUserTag)
