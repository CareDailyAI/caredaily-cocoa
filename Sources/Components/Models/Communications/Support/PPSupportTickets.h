//
//  PPSupportTickets.h
//  Peoplepower iOS
//
//  Created by Destry Teeter on 4/26/21.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPSupportTicket.h"

NS_ASSUME_NONNULL_BEGIN

@interface PPSupportTickets : PPBaseModel

#pragma mark - Support Ticket

/**
 * Support Ticket
 * Create a support ticket.
 *
 * @param supportTicket PPSupportTicket Required Support ticket
 * @param userId PPUserId Request support for this user by an administrator
 * @param callback PPErrorBlock Error callback block
 */
+ (void)postSupportTicket:(PPSupportTicket * _Nonnull )supportTicket userId:(PPUserId)userId callback:(PPErrorBlock _Nonnull )callback;

@end

NS_ASSUME_NONNULL_END
