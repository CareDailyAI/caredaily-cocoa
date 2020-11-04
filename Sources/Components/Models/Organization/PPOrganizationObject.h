//
//  PPOrganizationObject.h
//  Peoplepower
//
//  Created by Destry Teeter on 10/19/20.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSInteger, PPOrganizationObjectPrivateContent) {
    PPOrganizationObjectPrivateContentNone = -1,
    PPOrganizationObjectPrivateContentFalse = 0,
    PPOrganizationObjectPrivateContentTrue = 1,
};

typedef NS_OPTIONS(NSInteger, PPOrganizationObjectParent) {
    PPOrganizationObjectParentNone = -1,
    PPOrganizationObjectParentFalse = 0,
    PPOrganizationObjectParentTrue = 1,
};

@interface PPOrganizationObject : NSObject

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
