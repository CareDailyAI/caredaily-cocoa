//
//  PPFriendshipFriend.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/7/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPUserEmail.h"

@interface PPFriendshipFriend : PPBaseModel

@property (nonatomic) PPUserId friendId;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) PPUserEmail *email;

- (id)initWithId:(PPUserId)friendId firstName:(NSString *)firstName lastName:(NSString *)lastName email:(PPUserEmail *)email;

+ (PPFriendshipFriend *)initWithDictionary:(NSDictionary *)friendDict;

+ (NSString *)stringify:(PPFriendshipFriend *)friendshipFriend;

@end

