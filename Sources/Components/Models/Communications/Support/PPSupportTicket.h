//
//  PPSupportTicket.h
//  Peoplepower iOS
//
//  Created by Destry Teeter on 4/26/21.
//  Copyright © 2021 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PPSupportTicket : PPBaseModel

@property (nonatomic) PPSupportTicketType type;
@property (nonatomic) PPSupportTicketPriority priority;
@property (nonatomic, strong) NSString * _Nonnull subject;
@property (nonatomic, strong) NSString * _Nonnull comment;

- (id)initWithType: (PPSupportTicketType )type
          priority: (PPSupportTicketPriority )priority
           subject: (NSString * _Nonnull )subject
           comment: (NSString * _Nonnull )comment;

+ (PPSupportTicket *)initWithDictionary:(NSDictionary *)supportDict;

@end

NS_ASSUME_NONNULL_END
