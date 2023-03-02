//
//  PPLocationSpace.h
//  Peoplepower
//
//  Created by Destry Teeter on 8/28/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

@interface PPLocationSpace : PPBaseModel

@property (nonatomic) PPLocationSpaceId spaceId;
@property (nonatomic) PPLocationSpaceType type;
@property (nonatomic, strong) NSString *name;

- (id)initWithId:(PPLocationSpaceId)spaceId type:(PPLocationSpaceType)type name:(NSString *)name;

+ (PPLocationSpace *)initWithDictionary:(NSDictionary *)spaceDict;

+ (NSString *)stringify:(PPLocationSpace *)space;
+ (NSDictionary *)data:(PPLocationSpace *)space;

+ (NSString *)localizedNameForSpaceType:(PPLocationSpaceType)spaceType;

@end
