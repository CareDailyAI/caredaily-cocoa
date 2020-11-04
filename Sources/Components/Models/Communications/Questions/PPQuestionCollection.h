//
//  PPQuestionCollection.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

@interface PPQuestionCollection : PPBaseModel

/* A number set by the admin to indicate where this question should appear relative to other questions inside a collection. The higher the order, the lower the question drops to the bottom. */
@property (nonatomic) PPQuestionCollectionWeight weight;

/* A unique name for referencing this collection. */
@property (nonatomic, strong) NSString *name;

/* The titles of the group in various languages. */
@property (nonatomic, strong) NSString *icon;

/* The titles of the group in various languages. */
@property (nonatomic, strong) NSString *desc;

/* The titles of the group in various languages. */
@property (nonatomic, strong) NSString *media;

/* The titles of the group in various languages. */
@property (nonatomic, strong) NSString *mediaContentType;

/* If true, this question will be made available publicly, even to users who have never signed up on our system before. This is to facilitate sign up surveys. The user's answers will get captured immediately after their account is created on the server. */
@property (nonatomic) PPQuestionCollectionGeneralPublic generalPublic;

- (id)initWithName:(NSString *)name
              icon:(NSString *)icon
              desc:(NSString *)desc
             media:(NSString *)media
  mediaContentType:(NSString *)mediaContentType
            weight:(PPQuestionCollectionWeight)weight;

+ (PPQuestionCollection *)initWithDictionary:(NSDictionary *)collectionDict;

#pragma mark - Helper methods

- (BOOL)isEqualToCollection:(PPQuestionCollection *)collection;

- (void)sync:(PPQuestionCollection *)collection;

@end
