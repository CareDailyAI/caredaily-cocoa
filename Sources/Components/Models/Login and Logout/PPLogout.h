//
//  PPLogout.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"

@interface PPLogout : PPBaseModel

#pragma mark - Logout

/**
 * Logout the user and securely remove the API key from the server database. All application instances for this user are simultaneously logged out.
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)logoutcallback:(PPErrorBlock)callback;

@end
