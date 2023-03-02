//
//  PPOrganizationObject.h
//  Peoplepower
//
//  Created by Destry Teeter on 10/19/20.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PPOrganizationObject : PPBaseModel

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *contentType;
@property (nonatomic, strong) NSString *value;
@property (nonatomic) PPOrganizationObjectPrivateContent privateContent;
@property (nonatomic) PPOrganizationObjectParent parent;

- (id)initWithName:(NSString *)name
      contentType:(NSString *)contentType
            value:(NSString *)value
   privateContent:(PPOrganizationObjectPrivateContent)privateContent
           parent:(PPOrganizationObjectParent)parent;

+ (PPOrganizationObject *)initWithDictionary:(NSDictionary *)objectDict;

@end

NS_ASSUME_NONNULL_END
