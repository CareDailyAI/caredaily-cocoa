//
//  PPQuestionResponseOption.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

@interface PPQuestionResponseOption : PPBaseModel

@property (nonatomic) PPResponseOptionId responseOptionId;
@property (nonatomic, strong) NSString *text;
@property (nonatomic) PPResponseOptionTotal total;

- (id)initWithId:(PPResponseOptionId)responseOptionId text:(NSString *)text total:(PPResponseOptionTotal)total;

+ (PPQuestionResponseOption *)initWithDictionary:(NSDictionary *)responseOptionDict;

@end
