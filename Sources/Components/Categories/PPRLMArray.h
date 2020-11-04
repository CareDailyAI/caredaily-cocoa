//
//  PPRLMArray.h
//  Peoplepower
//
//  Created by Destry Teeter on 6/6/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

@interface PPRLMArray : NSObject

+ (NSString *)stringArray:(RLMArray *)array componentsJoinedByString:(NSString *)joiningString;
+ (NSArray *)arrayFromArray:(RLMArray *)array;

@end
