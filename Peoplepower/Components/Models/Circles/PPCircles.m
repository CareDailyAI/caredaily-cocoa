//
//  PPCircles.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/13/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//
// A Circle is the formation of a group of people. A Circle is formed by a user, who then invites other people to the Circle. By default, the person who formed the Circle is the administrator; however, anyone may add premium services to the Circle and take over administration.
// Circles also have storage. Unlike a user account's storage which has a finite cap to the total data, the storage for a Circle is limited only by aggregated data in and not by total data. This means the total storage is effectively infinite, but limited on a monthly basis by the amount of data flowing in. Any user within a Circle may upgrade the Circle to a "premium" account to increase the monthly flow rate into the Circle.
// Members of a Circle can upload any content, including Messages and Files (pictures, videos, audio), which is shared with all other members of the Circle. Some Circle members may have been invited but not joined yet, and those members should receive a daily summary of what they missed out on in the Circle (with the opportunity to unsubscribe) until they sign up as a user.
// Everyone can delete their own content, but only the Administrator(s) of the Circle may delete someone else's content or manage the Circle.
// In the future, Circles may expand in a number of ways:
//      - Add items to a list, like a grocery list, where others can check off items as they're purchased
//      - Add items to a shared calendar.
//      - Share member's mobile phone locations and multiple geofence locations with GPS
//      - Enable Composer apps to post events and notifications directly into the Circle
//
//  Feature                         Free Circle                     Premium Circle
//  -------                         -----------                     --------------
//  Create a Circle                 Up to 2 free                    Each Circle beyond
//                                                                      2 is a Premium Circle
//  Maximum members                 Infinite                        Infinite
//  Total data stored               Infinite                        Infinite
//  Accumulated monthly             50 MB/month                     10 GB/month
//      data in
//  Add a new member to             Any member                      Any member
//      the Circle
//  Send a message                  Any member                      Any member
//  Publish a picture               Any member                      Any member
//  Publish a video                 Any member                      Any member
//  Publish audio                   Any member                      Any member
//  Share GPS locations             Any member                      Any member
//  React (like) content            Any member                      Any member
//  Publish alerts and events       Any member's Composer Apps      Any member's Composer Apps
//  Who is the administrator?       Person who created              People who paid for
//                                      the Circle                      Premium upgrades
//  Who can delete a Circle         Administrator of the Circle     Administrator of the Circle
//  Who can nickname the            Administrator of the Circle     Administrator of the Circle
//      Circle
//  Who can remove someone          Administrator of the Circle;    Administrator of the Circle;
//      from a Circle                   anyone who wants                anyone who wants
//                                      to opt-out                      to opt-out
//

#import "PPCircles.h"
#import "PPCloudEngine.h"

@implementation PPCircles

#pragma mark - Session Management

#pragma mark Circles

/**
 * Shared circles across the entire application
 */
+ (NSArray *)sharedCircles {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s", __PRETTY_FUNCTION__);
#endif
#endif
    NSArray *sharedCircles = @[];
    
    NSMutableArray *sharedCirclesArray = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray *circlesArrayDebug = [[NSMutableArray alloc] initWithCapacity:0];
    for(PPCircle *circle in sharedCircles) {
        [sharedCirclesArray addObject:circle];
        NSMutableDictionary *circleIdentifiers = [[NSMutableDictionary alloc] initWithCapacity:2];
        [circleIdentifiers setValue:@(circle.circleId) forKey:@"id"];
        if(circle.name) {
            [circleIdentifiers setValue:circle.name forKey:@"name"];
        }
        [circlesArrayDebug addObject:circleIdentifiers];
    }
    
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s sharedCircles=%@", __PRETTY_FUNCTION__, circlesArrayDebug);
#endif
#endif
    return sharedCirclesArray;
}

/**
 * Add circles.
 * Add circles from local reference.
 *
 * @param circles NSArray Array of circles to remove.
 **/
+ (void)addCircles:(NSArray *)circles {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s circles=%@", __PRETTY_FUNCTION__, circles);
    NSLog(@"< %s", __PRETTY_FUNCTION__);
#endif
#endif
}

/**
 * Remove circles.
 * Remove circles from local reference.
 *
 * @param circles NSArray Array of circles to remove.
 **/
+ (void)removeCircles:(NSArray *)circles {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s circles=%@", __PRETTY_FUNCTION__, circles);
    NSLog(@"< %s", __PRETTY_FUNCTION__);
#endif
#endif
}

#pragma mark Circle Files

/**
 * Shared files across the entire application
 */
+ (NSArray *)sharedFiles {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s", __PRETTY_FUNCTION__);
#endif
#endif
    NSArray *sharedFiles = @[];
    
    NSMutableArray *sharedFilesArray = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray *filesArrayDebug = [[NSMutableArray alloc] initWithCapacity:0];
    for(PPCircleFile *file in sharedFiles) {
        [sharedFilesArray addObject:file];
        NSMutableDictionary *fileIdentifiers = [[NSMutableDictionary alloc] initWithCapacity:2];
        [fileIdentifiers setValue:@(file.fileId) forKey:@"id"];
        [filesArrayDebug addObject:fileIdentifiers];
    }
    
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s sharedFiles=%@", __PRETTY_FUNCTION__, filesArrayDebug);
#endif
#endif
    return sharedFilesArray;
}

/**
 * Add files.
 * Add files to local reference.
 *
 * @param files NSArray Array of files to add.
 **/
+ (void)addFiles:(NSArray *)files {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s files=%@", __PRETTY_FUNCTION__, files);
    NSLog(@"< %s", __PRETTY_FUNCTION__);
#endif
#endif
}

/**
 * Remove files.
 * Remove files from local reference.
 *
 * @param files NSArray Array of files to remove.
 **/
+ (void)removeFiles:(NSArray *)files {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s files=%@", __PRETTY_FUNCTION__, files);
    NSLog(@"< %s", __PRETTY_FUNCTION__);
#endif
#endif
}

#pragma mark Posts

/**
 * Shared posts across the entire application
 */
+ (NSArray *)sharedPosts {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s", __PRETTY_FUNCTION__);
#endif
#endif
    NSArray *sharedPosts = @[];
    
    NSMutableArray *sharedPostsArray = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray *postsArrayDebug = [[NSMutableArray alloc] initWithCapacity:0];
    for(PPCirclePost *post in sharedPosts) {
        [sharedPostsArray addObject:post];
        NSMutableDictionary *postIdentifiers = [[NSMutableDictionary alloc] initWithCapacity:2];
        [postIdentifiers setValue:@(post.postId) forKey:@"id"];
        [postsArrayDebug addObject:postIdentifiers];
    }
    
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s sharedPosts=%@", __PRETTY_FUNCTION__, postsArrayDebug);
#endif
#endif
    return sharedPostsArray;
}

/**
 * Add posts.
 * Add posts to local reference.
 *
 * @param posts NSArray Array of posts to add.
 **/
+ (void)addPosts:(NSArray *)posts {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s posts=%@", __PRETTY_FUNCTION__, posts);
    NSLog(@"< %s", __PRETTY_FUNCTION__);
#endif
#endif
}

/**
 * Remove posts.
 * Remove posts from local reference.
 *
 * @param posts NSArray Array of posts to remove.
 **/
+ (void)removePosts:(NSArray *)posts {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s posts=%@", __PRETTY_FUNCTION__, posts);
    NSLog(@"< %s", __PRETTY_FUNCTION__);
#endif
#endif
}

#pragma mark Devices

/**
 * Shared devices across the entire application
 */
+ (NSArray *)sharedDevices {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s", __PRETTY_FUNCTION__);
#endif
#endif
    NSArray *sharedDevices = @[];
    
    NSMutableArray *sharedDevicesArray = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray *devicesArrayDebug = [[NSMutableArray alloc] initWithCapacity:0];
    for(PPCirclePost *post in sharedDevices) {
        [sharedDevicesArray addObject:post];
        NSMutableDictionary *postIdentifiers = [[NSMutableDictionary alloc] initWithCapacity:2];
        [postIdentifiers setValue:@(post.postId) forKey:@"id"];
        [devicesArrayDebug addObject:postIdentifiers];
    }
    
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"< %s sharedDevices=%@", __PRETTY_FUNCTION__, devicesArrayDebug);
#endif
#endif
    return sharedDevicesArray;
}

/**
 * Add devices.
 * Add devices to local reference.
 *
 * @param devices NSArray Array of devices to add.
 **/
+ (void)addDevices:(NSArray *)devices {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s devices=%@", __PRETTY_FUNCTION__, devices);
    NSLog(@"< %s", __PRETTY_FUNCTION__);
#endif
#endif
}

/**
 * Remove devices.
 * Remove devices from local reference.
 *
 * @param devices NSArray Array of devices to remove.
 **/
+ (void)removeDevices:(NSArray *)devices {
#ifdef DEBUG
#ifdef DEBUG_MODELS
    NSLog(@"> %s devices=%@", __PRETTY_FUNCTION__, devices);
    NSLog(@"< %s", __PRETTY_FUNCTION__);
#endif
#endif
}

#pragma mark - Circles

/**
 * Create a Circle.
 * The person who creates a Circle is the Administrator, until someone upgrades the Circle into a Premium Circle (or higher). The people who pay for Premium services take over as the Administrator.
 * You are always an implied member of the Circle you create.
 * The request returns the ID of the Circle that was created, for future reference.
 * Remember that we can add email addresses without having a user account created on our system. Every user will get an email + push notification that they're part of the Circle.
 * Any accounts that are email address only will receive a daily update with the top 3 items from the conversation on what they missed out on, with an opportunity to sign up.
 *
 * @param name NSString Name of the circle
 * @param callback PPCircleCreationBlock Circle creation callback block
 **/
+ (void)createCircle:(NSString *)name callback:(PPCircleCreationBlock)callback {
    NSAssert1(name != nil, @"%s missing name", __FUNCTION__);
    NSString *requestString = @"circles?";
    NSMutableString *JSONString = [[NSMutableString alloc] init];
    [JSONString appendString:@"{"];
    [JSONString appendString:@"\"circle\": {"];
    [JSONString appendFormat:@"\"name\":\"%@\"", name];
    [JSONString appendString:@"}"];
    [JSONString appendString:@"}"];
    
    NSError *error;
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppEngine] getRequestSerializer] requestWithMethod:@"POST" URLString:[NSURL URLWithString:requestString relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    [request setHTTPBody:[JSONString dataUsingEncoding:NSUTF8StringEncoding]];
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.circles.createCircle()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppEngine] operationWithRequest:request success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPCircleId circleId = PPCircleIdNone;
            
            if(!error) {
                if([root objectForKey:@"id"]) {
                    circleId = (PPCircleId)((NSString *)[root objectForKey:@"id"]).integerValue;
                }
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(circleId, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(PPCircleIdNone, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@", error.userInfo]]);
            });
        });
    }];
}
                   

/**
 * Get Circles.
 * TODO: Each member must have an Avatar image associated with their user account. If that avatar image changes, then we need to know it at the app so we can update your picture - perhaps a hidden item in the feed? An Avatar image may be a picture, or it could be auto-generated by the app like a circle with your initials in it. If an image doesn't exist, we'll just assume we should auto-generate an avatar for the user.
 *
 * @param circleIds NSArray Array of Circle IDs as NSNumbers
 * @param callback PPCirclesBlock Circles callback block
 **/
+ (void)getCirclesWithCircleIds:(NSArray *)circleIds callback:(PPCirclesBlock)callback {
    NSMutableString *requestString = [[NSMutableString alloc] initWithString:@"circles?"];
    
    if([circleIds count] > 0) {
        for(NSNumber *circleId in circleIds) {
            [requestString appendFormat:@"circleId=%@&", circleId];
        }
    }
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.circles.getCircles()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppEngine] GET:requestString success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSMutableArray *circles;
            
            if(!error) {
                circles = [[NSMutableArray alloc] initWithCapacity:0];
                for(NSDictionary *circleDict in [root objectForKey:@"circles"]) {
                    PPCircle *circle = [PPCircle initWithDictionary:circleDict];
                    [circles addObject:circle];
                }
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(circles, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@", error.userInfo]]);
            });
        });
    }];
}
+ (void)getCircles:(PPCircleId)circleId callback:(PPCirclesBlock)callback {
    NSArray *circleIds;
    if(circleId != PPCircleIdNone) {
        circleIds = @[@(circleId)];
    }
    [PPCircles getCirclesWithCircleIds:circleIds callback:callback];
}

/**
 * Modify a Circle.
 * Only a Circle Administrator may modify a Circle.
 *
 * @param circleId Required PPCircleId Circle ID
 * @param name Required NSString Circle Name
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)modifyCircle:(PPCircleId)circleId name:(NSString *)name callback:(PPErrorBlock)callback {
    NSAssert1(circleId != PPCountryIdNone, @"%s missing circleId", __FUNCTION__);
    NSAssert1(name != nil, @"%s missing name", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"circles?circleId=%li&", (long)circleId];
    
    NSMutableString *JSONString = [[NSMutableString alloc] init];
    [JSONString appendString:@"{"];
    [JSONString appendString:@"\"circle\": {"];
    [JSONString appendFormat:@"\"name\":\"%@\"", name];
    [JSONString appendString:@"}"];
    [JSONString appendString:@"}"];
    
    NSError *error;
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppEngine] getRequestSerializer] requestWithMethod:@"PUT" URLString:[NSURL URLWithString:requestString relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    [request setHTTPBody:[JSONString dataUsingEncoding:NSUTF8StringEncoding]];
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.circles.modifyCircle()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppEngine] operationWithRequest:request success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        });
    } failure:^(NSError *error) {
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@", error.userInfo]]);
            });
        });
    }];
}

/**
 * Delete a Circle.
 * Only a Circle Administrator may delete a Circle.
 *
 * @param circleId Required PPCircleId Circle ID
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)deleteCircle:(PPCircleId)circleId callback:(PPErrorBlock)callback {
    NSAssert1(circleId != PPCountryIdNone, @"%s missing circleId", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"circles?circleId=%li&", (long)circleId];
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.circles.deleteCircle()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppEngine] DELETE:requestString success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        });
    } failure:^(NSError *error) {
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@", error.userInfo]]);
            });
        });
    }];
}

#pragma mark - Manage Circle Members

/**
 * Add Members.
 * Any member of a circle may add more members to a circle, not just the administrator. We want to help its utility grow organically.
 * Remember that we can add email addresses without having a user account created on our system. Every user will get an email + push notification that they're part of the Circle. Any accounts that are email address only will receive a daily update with the top 3 items from the conversation on what they missed out on, with an opportunity to sign up.
 *
 * @param circleId Required PPCircleId Circle ID
 * @param members Required NSArray Member emails
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)addMembers:(PPCircleId)circleId members:(NSArray *)members callback:(PPErrorBlock)callback {
    NSAssert1(circleId != PPCountryIdNone, @"%s missing circleId", __FUNCTION__);
    NSAssert1(members != nil && [members count] > 0, @"%s missing members", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"circles/%li/members?", (long)circleId];
    
    NSMutableString *JSONString = [[NSMutableString alloc] init];
    [JSONString appendString:@"{"];
    [JSONString appendString:@"\"members\": ["];
    
    BOOL appendComma = NO;
    for(PPCircleMember *member in members) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendString:@"{"];
        
        BOOL appendMemberComma = NO;
        if(member.email.email) {
            [JSONString appendFormat:@"\"email\":\"%@\"", member.email.email];
            appendMemberComma = YES;
        }
        
        if(member.phone) {
            if(appendMemberComma) {
                [JSONString appendString:@","];
            }
            [JSONString appendFormat:@"\"phone\":\"%@\"", member.phone];
            appendMemberComma = YES;
        }
        
        if(member.nickname) {
            if(appendMemberComma) {
                [JSONString appendString:@","];
            }
            [JSONString appendFormat:@"\"nickname\":\"%@\"", member.nickname];
            appendMemberComma = YES;
        }
        [JSONString appendString:@"}"];
        
        appendComma = YES;
    }
    [JSONString appendString:@"]"];
    [JSONString appendString:@"}"];
    
    NSError *error;
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppEngine] getRequestSerializer] requestWithMethod:@"POST" URLString:[NSURL URLWithString:requestString relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    [request setHTTPBody:[JSONString dataUsingEncoding:NSUTF8StringEncoding]];
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.circles.addMembers()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppEngine] operationWithRequest:request success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        });
    } failure:^(NSError *error) {
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@", error.userInfo]]);
            });
        });
    }];
}

/**
 * Update Member Status.
 * A circle member can opt-in or opt-out from circle notifications.
 * A circle member can change own status and nickname.
 * A circle admin can also update other users as admins.
 *
 * @param circleKey NSString Circle key for not registered circle members
 * @param circleUserId NSString Circle user ID to update other user by admin
 * @param circleId Required PPCircleId Circle ID
 * @param status PPCircleMemberStatus Member emails
 * @param nickname NSString Member nickname
 * @param admin PPCircleMemberAdmin Member admin
 * @param userId PPUserId User ID to access by administrator
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)updateMemberStatus:(NSString *)circleKey circleUserId:(NSString *)circleUserId circleId:(PPCircleId)circleId status:(PPCircleMemberStatus)status nickname:(NSString *)nickname admin:(PPCircleMemberAdmin)admin userId:(PPUserId)userId callback:(PPErrorBlock)callback {
    NSAssert1(circleId != PPCountryIdNone, @"%s missing circleId", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"circles/%li/members?", (long)circleId];
    
    if(userId != PPUserIdNone) {
        [requestString appendFormat:@"userId=%li", (long)userId];
    }
    
    NSMutableString *JSONString = [[NSMutableString alloc] init];
    [JSONString appendString:@"{"];
    [JSONString appendString:@"\"member\": {"];
    
    BOOL appendComma = NO;
    
    if(circleUserId) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"circleUserId\":\"%@\"", circleUserId];
        appendComma = YES;
    }
    
    if(status != PPCircleMemberStatusNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"status\":%li", (long)status];
        appendComma = YES;
    }

    if(nickname != nil) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"nickname\":\"%@\"", nickname];
        appendComma = YES;
    }
    
    if(admin != PPCircleMemberAdminNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"admin\":\"%@\"", (admin == PPCircleMemberAdminTrue) ? @"true" : @"false"];
        appendComma = YES;
    }
    [JSONString appendString:@"}"];
    [JSONString appendString:@"}"];
    
    NSError *error;
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppEngine] getRequestSerializer] requestWithMethod:@"PUT" URLString:[NSURL URLWithString:requestString relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    if(circleKey) {
        [request setValue:nil forHTTPHeaderField:HTTP_HEADER_API_KEY];
        [request setValue:circleKey forHTTPHeaderField:HTTP_HEADER_CIRCLE_KEY];
    }
    [request setHTTPBody:[JSONString dataUsingEncoding:NSUTF8StringEncoding]];
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.circles.updateMemberStatus()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppEngine] operationWithRequest:request success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        });
    } failure:^(NSError *error) {
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@", error.userInfo]]);
            });
        });
    }];
}
+ (void)updateMemberStatus:(NSString *)circleUserId circleId:(PPCircleId)circleId status:(PPCircleMemberStatus)status nickname:(NSString *)nickname userId:(PPUserId)userId callback:(PPErrorBlock)callback {
    [PPCircles updateMemberStatus:circleUserId circleUserId:nil circleId:circleId status:status nickname:nickname admin:PPCircleMemberAdminNone userId:userId callback:callback];
}
    
/**
 * Remove Members.
 * Only a Circle Administrator may delete other members. Registered users may delete themselves.
 *
 * @param circleId Required PPCircleId Circle ID
 * @param userId PPUserId User ID to access by administrator
 * @param circleUserId Required NSString Circle User ID to delete from the circle
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)removeMembers:(PPCircleId)circleId userId:(PPUserId)userId circleUserId:(NSString *)circleUserId callback:(PPErrorBlock)callback {
    NSAssert1(circleId != PPCountryIdNone, @"%s missing circleId", __FUNCTION__);
    NSAssert1(circleUserId != nil, @"%s missing circleUserId", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"circles/%li/members?", (long)circleId];
    
    if(userId != PPUserIdNone) {
        [requestString appendFormat:@"userId=%li&", (long)userId];
    }
    if(circleUserId != nil) {
        [requestString appendFormat:@"circleUserId=%@&", circleUserId];
    }
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.circles.removeMembers*(", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppEngine] DELETE:requestString success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        });
    } failure:^(NSError *error) {
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@", error.userInfo]]);
            });
        });
    }];
}

#pragma mark - Circle Files

/**
 * Upload File.
 * The client have to upload the file content first and then add a thumbnail. The API will return the thumbnail field equals true, if the cloud was able to generate the thumbnail from the file content.
 * The "Content-Type" header must be like video/..., image/..., audio/... or application/octet-stream (see https://en.wikipedia.org/wiki/Internet_media_type for possible exact values). For example: video/mp4, image/jpeg, audio/mp3. The content type of a thumbnail image is always image/jpeg.
 *
 * @param circleId Required PPCircleId Circle ID
 * @param type Type PPFileFileType File type. By default it is defined from the content type. However this parameter is useful, if a thumbnail with different content type is uploaded frist.
 * @param fileExtension Required NSString File extension (For example, "mp4" or "png")
 * @param duration PPFileDuration Duration of the video in seconds, for reporting to the UI
 * @param rotate PPFileRotate Rotation in degrees. The UI is expected to manually rotat the video back to being upright if this is set.
 * @param thumbnail PPFileThumbnail True - The content is a thumbnail image and the file content will be uploaded later
 * @param expectedSize PPFileSize Expected total size in bytes, if available
 * @param incomplete PPFileIncomplete True - This file content will be replaced or extended later. False - This file is complete
 * @param contentType Required NSString Content-Type header.
 * @param data Required NSData File data
 * @param progressBlock PPCircleFileProgressBlock File upload progress block
 * @param callback PPCircleFileUploadBlock File fragment block containing file reference, used and total file space, twitter share status, and twitter account (if any)
 **/
+ (void)uploadFile:(PPCircleId)circleId type:(PPFileFileType)type fileExtension:(NSString *)fileExtension duration:(PPFileDuration)duration rotate:(PPFileRotate)rotate thumbanil:(PPFileThumbnail)thumbnail expectedSize:(PPFileSize)expectedSize incomplete:(PPFileIncomplete)incomplete contentType:(NSString *)contentType data:(NSData *)data progressBlock:(PPCircleFileProgressBlock)progressBlock callback:(PPCircleFileUploadBlock)callback {
    NSAssert1(circleId != PPCountryIdNone, @"%s missing circleId", __FUNCTION__);
    NSAssert1(type != PPFileFileTypeNone, @"%s missing type", __FUNCTION__);
    NSAssert1(fileExtension != nil, @"%s missing fileExtension", __FUNCTION__);
    NSAssert1(contentType != nil, @"%s missing contentType", __FUNCTION__);
    NSAssert1(data != nil, @"%s missing data", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"circles/%li/files?ext=%@&", (long)circleId, fileExtension];
    
    if(type != PPFileFileTypeNone) {
        [requestString appendFormat:@"type=%li&", (long)type];
    }
    if(duration != PPFileDurationNone) {
        [requestString appendFormat:@"duration=%li&", (long)duration];
    }
    if(rotate != PPFileRotateNone) {
        [requestString appendFormat:@"rotate=%li&", (long)rotate];
    }
    if(thumbnail != PPFileThumbnailNone) {
        [requestString appendFormat:@"thumbnail=%@&", (thumbnail) ? @"true" : @"false"];
    }
    if(expectedSize != PPFileSizeNone) {
        [requestString appendFormat:@"expectedSize=%lli&", expectedSize];
    }
    if(incomplete != PPFileIncompleteNone) {
        [requestString appendFormat:@"incomplete=%@&", (incomplete) ? @"true" : @"false"];
    }
    
    NSError *error;
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppEngine] getRequestSerializer] requestWithMethod:@"POST" URLString:[NSURL URLWithString:requestString relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    
    [request setValue:contentType forHTTPHeaderField:HTTP_HEADER_CONTENT_TYPE];
    [request setHTTPBody:data];
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.circles.uploadFile()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppEngine] operationWithRequest:request progressBlock:^(NSProgress *progress) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"> %s %@", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL), progress);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if(progressBlock) {
                    progressBlock(progress);
                }
            });
        });
    } success:^(NSData *responseData, NSObject *response) {
        dispatch_async(queue, ^{
            
            NSError *error;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPFileId fileId = PPFileIdNone;
            PPFileThumbnail thumbnail = PPFileThumbnailNone;
            PPCircleData monthlyDataIn = PPCircleDataNone;
            PPCircleData monthlyDataMax = PPCircleDataNone;
            
            if(!error) {
                if([root objectForKey:@"fileId"]) {
                    fileId = (PPFileId)((NSString *)[root objectForKey:@"fileId"]).integerValue;
                }
                if([root objectForKey:@"thumbnail"]) {
                    thumbnail = (PPFileThumbnail)((NSString *)[root objectForKey:@"thumbnail"]).integerValue;
                }
                if([root objectForKey:@"monthlyDataIn"]) {
                    monthlyDataIn = (PPCircleData)((NSString *)[root objectForKey:@"monthlyDataIn"]).integerValue;
                }
                if([root objectForKey:@"monthlyDataMax"]) {
                    monthlyDataMax = (PPCircleData)((NSString *)[root objectForKey:@"monthlyDataMax"]).integerValue;
                }
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(fileId, thumbnail, monthlyDataIn, monthlyDataMax, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(PPFileIdNone, PPFileThumbnailNone, PPCircleDataNone, PPCircleDataNone, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}
+ (void)uploadFile:(PPCircleId)circleId type:(PPFileFileType)type fileExtension:(NSString *)fileExtension duration:(PPFileDuration)duration rotate:(PPFileRotate)rotate thumbanil:(PPFileThumbnail)thumbnail expectedSize:(PPFileSize)expectedSize incomplete:(PPFileIncomplete)incomplete contentType:(NSString *)contentType data:(NSData *)data callback:(PPCircleFileUploadBlock)callback {
    [PPCircles uploadFile:circleId type:type fileExtension:fileExtension duration:duration rotate:rotate thumbanil:thumbnail expectedSize:expectedSize incomplete:incomplete contentType:contentType data:data progressBlock:nil callback:callback];
}

/**
 * Get Files.
 * Return a list of files in the circle.
 *
 * @param circleId Required PPCircleId CircleId
 * @param fileId PPFileId File ID filter
 * @param type PPFileFileType File type
 * @param ownerId PPUserId User ID of the file's owner
 * @param startDate NSDate Start date of the files list
 * @param endDate NSDate End date of the files list
 * @param callback PPCircleFilesBlock Files callback block
 **/
+ (void)getFiles:(PPCircleId)circleId fileId:(PPFileId)fileId type:(PPFileFileType)type ownerId:(PPUserId)ownerId startDate:(NSDate *)startDate endDate:(NSDate *)endDate callback:(PPCircleFilesBlock)callback {
    NSAssert1(circleId != PPCountryIdNone, @"%s missing circleId", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"circles/%li/files?", (long)circleId];
    
    if(fileId != PPFileIdNone) {
        [requestString appendFormat:@"fileId=%li&", (long)type];
    }
    if(type != PPFileFileTypeNone) {
        [requestString appendFormat:@"type=%li&", (long)type];
    }
    if(ownerId != PPUserIdNone) {
        [requestString appendFormat:@"ownerId=%li&", (long)ownerId];
    }
    if(startDate) {
        [requestString appendFormat:@"startDate=%@&", [PPNSString stringByAddingURIPercentEscapesUsingEncoding:NSUTF8StringEncoding toString:[PPNSDate apiFriendStringFromDate:startDate]]];
    }
    if(endDate) {
        [requestString appendFormat:@"endDate=%@&", [PPNSString stringByAddingURIPercentEscapesUsingEncoding:NSUTF8StringEncoding toString:[PPNSDate apiFriendStringFromDate:endDate]]];
    }
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.circles.getFiles()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppEngine] GET:requestString success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSMutableArray *files;
            NSString *tempKey;
            NSDate *tempKeyExpire;
            PPCircleData monthlyDataIn = PPCircleDataNone;
            PPCircleData monthlyDataMax = PPCircleDataNone;
            
            if(!error) {
                files = [[NSMutableArray alloc] initWithCapacity:0];
                for(NSDictionary *fileDict in [root objectForKey:@"files"]) {
                    PPCircleFile *file = [PPCircleFile initWithDictionary:fileDict];
                    [files addObject:file];
                }
                tempKey = [root objectForKey:@"tempKey"];
            
                NSString *tempKeyExpireString = [root objectForKey:@"tempKeyExpire"];
                tempKeyExpire = [NSDate date];
            
                if(tempKeyExpireString != nil) {
                    if(![tempKeyExpireString isEqualToString:@""]) {
                        tempKeyExpire = [PPNSDate parseDateTime:tempKeyExpireString];
                    }
                }
                
            
                if([root objectForKey:@"monthlyDataIn"]) {
                    monthlyDataIn = (PPCircleData)((NSString *)[root objectForKey:@"monthlyDataIn"]).integerValue;
                }
                if([root objectForKey:@"monthlyDataMax"]) {
                    monthlyDataMax = (PPCircleData)((NSString *)[root objectForKey:@"monthlyDataMax"]).integerValue;
                }
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(files, tempKey, tempKeyExpire, monthlyDataIn, monthlyDataMax, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, nil, nil, PPCircleDataNone, PPCircleDataNone, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

#pragma mark - Single File Access

/**
 * Upload File Fragment or Thumbnail.
 * Allow to add a fragment to the content of the existing file or upload a thumbnail.
 *
 * @param circleId Required PPCircleId Circle ID
 * @param fileId Required PPFileId Existing file ID
 * @param thumbnail PPFileThumbnail True - The content is a thumbnail image
 * @param incomplete PPFileIncomplete True - The file will be extended later, False - This file is complete
 * @param index PPFileFragmentIndex Fragmen index starting from 0 to identify unique file fragment. It is used for additional control over uploaded data.
 * @param contentType Required NSString Content-Type header.
 * @param data Required NSData File data
 * @param progressBlock PPCircleFileProgressBlock File upload progress block
 * @param callback PPCircleFileUploadFragmentBlock File fragment block containing file reference, used and total file space, twitter share status, and twitter account (if any)
 **/
+ (void)uploadFileFragment:(PPCircleId)circleId fileId:(PPFileId)fileId thumbnail:(PPFileThumbnail)thumbnail incomplete:(PPFileIncomplete)incomplete index:(PPFileFragmentIndex)index contentType:(NSString *)contentType data:(NSData *)data progressBlock:(PPCircleFileProgressBlock)progressBlock callback:(PPCircleFileUploadFragmentBlock)callback {
    NSAssert1(circleId != PPCountryIdNone, @"%s missing circleId", __FUNCTION__);
    NSAssert1(fileId != PPFileIdNone, @"%s missing fileId", __FUNCTION__);
    NSAssert1(contentType != nil, @"%s missing contentType", __FUNCTION__);
    NSAssert1(data != nil, @"%s missing data", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"circles/%li/files/%li?", (long)circleId, (long)fileId];
    if(thumbnail != PPFileThumbnailNone) {
        [requestString appendFormat:@"thumbnail=%@&", (thumbnail) ? @"true" : @"false"];
    }
    if(incomplete != PPFileIncompleteNone) {
        [requestString appendFormat:@"incomplete=%@&", (incomplete) ? @"true" : @"false"];
    }
    if(index != PPFileFragmentIndexNone) {
        [requestString appendFormat:@"index=%li&", (long)index];
    }
    
    NSError *error;
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppEngine] getRequestSerializer] requestWithMethod:@"POST" URLString:[NSURL URLWithString:requestString relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    
    [request setValue:contentType forHTTPHeaderField:HTTP_HEADER_CONTENT_TYPE];
    [request setHTTPBody:data];
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.cirlces.uploadFileFragment()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppEngine] operationWithRequest:request progressBlock:^(NSProgress *progress) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"> %s %@", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL), progress);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if(progressBlock) {
                    progressBlock(progress);
                }
            });
        });
    } success:^(NSData *responseData, NSObject *response) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPFileThumbnail thumbnail = PPFileThumbnailNone;
            
            if(!error) {
                thumbnail = (PPFileThumbnail)((NSString *)[root objectForKey:@"thumbnail"]).integerValue;
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(thumbnail, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(PPFileThumbnailNone, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}
+ (void)uploadFileFragment:(PPCircleId)circleId fileId:(PPFileId)fileId thumbnail:(PPFileThumbnail)thumbnail incomplete:(PPFileIncomplete)incomplete index:(PPFileFragmentIndex)index contentType:(NSString *)contentType data:(NSData *)data callback:(PPCircleFileUploadFragmentBlock)callback {
    [PPCircles uploadFileFragment:circleId fileId:fileId thumbnail:thumbnail incomplete:incomplete index:index contentType:contentType data:data progressBlock:nil callback:callback];
}
    
/**
 * Download File.
 * The Range HTTP Header is optional, and will only return a chunk of the total content. If used, it is recommended to select a range that is a multiple of 10240 bytes.
 * A temporary API key provided in the query parameter may be used to forward a link to other part of the app. A temporary API key can be obtained by calling the loginByKey API. It is expired soon after receiving.
 * The response will include:
 *      - The file content
 *      - A Content-Type HTTP Header containing the file's content type
 *      - Content range in the Content-Range header, if the Range of the content was requested. This will be in the format of bytes {start}-{end}/{total size}. For example: Content-Range: bytes 21010-47021/47022.
 *      - The Accept-Ranges header containing accepted content range values in bytes. For example "0-47022".
 *      - The Content-Disposition HTTP header that contains the filename when requested.
 * See http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html for a discussion on the header options.
 * HTTP Status Codes:
 *      - 200 (OK): The file content is returned in full.
 *      - 204 (No Content): The file exist, but the content is not available for this request.
 *      - 206 (Partial Content): The file content is partially returned.
 *      - 401 (Unauthorized): The API key is wrong.
 *      - 404 (Not Found): The file does not exists.
 *      - 500 (Internal error): Something went wrong on the server side.
 *
 * @param circleId Required PPCircleId Circle ID
 * @param fileId Required PPFileId File ID to download
 * @param apiKey NSString Temporary API key
 * @param thumbnail PPFileThumbnail True - Download the thumbnail for this file, False - Download the actual file, not the thumbnail, default
 * @param m3u8 PPFileM3U8 True - Download m3u8 file instead of the file content
 * @param attach PPFileAttach Download the file content as an attachments with the Content-Disposition header
 * @param range NSRange Range of bytes to download
 * @param callback PPCircleFileContentBlock File content block
 **/
+ (void)downloadFile:(PPCircleId)circleId fileId:(PPFileId)fileId apiKey:(NSString *)apiKey thumbnail:(PPFileThumbnail)thumbnail m3u8:(PPFileM3U8)m3u8 attach:(PPFileAttach)attach range:(NSRange)range callback:(PPCircleFileContentBlock)callback {
    NSAssert1(circleId != PPCountryIdNone, @"%s missing circleId", __FUNCTION__);
    NSAssert1(fileId != PPFileIdNone, @"%s missing fileId", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"circles/%li/files/%li?", (long)circleId, (long)fileId];
    
    if(apiKey) {
        [requestString appendFormat:@"API_KEY=%@&", apiKey];
    }
    if(thumbnail != PPFileThumbnailNone) {
        [requestString appendFormat:@"thumbnail=%@&", (thumbnail) ? @"true" : @"false"];
    }
    if(m3u8 != PPFileM3U8None) {
        [requestString appendFormat:@"msu8=%@&", (m3u8) ? @"true" : @"false"];
    }
    if(attach != PPFileAttachNone) {
        [requestString appendFormat:@"attach=%@&", (attach) ? @"true" : @"false"];
    }
    NSError *error;
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppEngine] getRequestSerializer] requestWithMethod:@"GET" URLString:[NSURL URLWithString:requestString relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    if(range.location != 0 && range.length != 0) {
        [request setValue:[NSString stringWithFormat:@"bytes=%li-%li", (long)range.location, (long)range.length] forHTTPHeaderField:HTTP_HEADER_RANGE];
    }
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.circles.downloadFile()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppEngine] operationWithRequestIncludingResponse:request success:^(NSData *responseData, NSObject *response) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSInteger statusCode = 0;
            NSDictionary *responseHeaders;
            NSString *contentType;
            NSString *contentRange;
            NSString *acceptRanges;
            NSString *contentDisposition;
            
            if(!error) {
                statusCode = ((NSHTTPURLResponse *)response).statusCode;
                responseHeaders = ((NSHTTPURLResponse *)response).allHeaderFields;
                contentType = [responseHeaders objectForKey:HTTP_HEADER_CONTENT_TYPE];
                contentRange = [responseHeaders objectForKey:HTTP_HEADER_CONTENT_RANGE];
                acceptRanges = [responseHeaders objectForKey:HTTP_HEADER_ACCEPT_RANGES];
                contentDisposition = [responseHeaders objectForKey:HTTP_HEADER_CONTENT_DISPOSITION];
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(responseData, contentType, contentRange, acceptRanges, contentDisposition, statusCode, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, nil, nil, nil, nil, -1, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

/**
 * Get download URL's
 * A client can request temporary download URL's to get file and thumbnail content directly from S3 instead of copying it through the server.
 *
 * @param circleId Required PPCircleId Circle ID
 * @param fileId Required PPFileId File ID to download
 * @param content PPFileContent True - Download the file content URL
 * @param thumbnail PPFileThumbnail True - Download the thumbnail content URL
 * @param m3u8 PPFileM3U8 True - Download m3u8 content URL
 * @param expiration PPFileURLExpiration URL's expiration in milliseconds since the current time
 * @param callback PPCircleFileDownloadURLBlock File content block
 **/
+ (void)getDownloadURL:(PPCircleId)circleId fileId:(PPFileId)fileId content:(PPFileContent)content thumbnail:(PPFileThumbnail)thumbnail m3u8:(PPFileM3U8)m3u8 expiration:(PPFileURLExpiration)expiration callback:(PPCircleFileDownloadURLBlock)callback {
    NSAssert1(circleId != PPCountryIdNone, @"%s missing circleId", __FUNCTION__);
    NSAssert1(fileId != PPFileIdNone, @"%s missing fileId", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"circles/%li/files/%li?", (long)circleId, (long)fileId];
    if(content != PPFileContentNone) {
        [requestString appendFormat:@"content=%@&", (content) ? @"true" : @"false"];
    }
    if(thumbnail != PPFileThumbnailNone) {
        [requestString appendFormat:@"thumbnail=%@&", (thumbnail) ? @"true" : @"false"];
    }
    if(m3u8 != PPFileM3U8None) {
        [requestString appendFormat:@"m3u8=%@&", (m3u8) ? @"true" : @"false"];
    }
    if(expiration != PPFileURLExpirationNone) {
        [requestString appendFormat:@"expiration=%@&", (expiration) ? @"true" : @"false"];
    }
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.circles.getDownloadURL()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppEngine] GET:requestString success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSURL *contentUrl;
            NSURL *thumbnailUrl;
            NSURL *m3u8Url;
            
            if(!error) {
                if([root objectForKey:@"contentUrl"]) {
                    contentUrl = [NSURL URLWithString:[root objectForKey:@"contentUrl"]];
                }
                
                if([root objectForKey:@"thumbnailUrl"]) {
                    thumbnailUrl = [NSURL URLWithString:[root objectForKey:@"thumbnailUrl"]];
                }
                
                if([root objectForKey:@"m3u8Url"]) {
                    m3u8Url = [NSURL URLWithString:[root objectForKey:@"m3u8Url"]];
                }
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(contentUrl, thumbnailUrl, m3u8Url, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, nil, nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

#warning TODO: Add UpdateFile API

/**
 * Delete a File.
 * Only the owner of the file or an administrator of the circle may delete a file.
 *
 * @param circleId Required PPCircleId Circle ID
 * @param fileId Required PPFileId File ID to delete
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)deleteFile:(PPCircleId)circleId fileId:(PPFileId)fileId callback:(PPErrorBlock)callback {
    NSAssert1(circleId != PPCountryIdNone, @"%s missing circleId", __FUNCTION__);
    NSAssert1(fileId != PPFileIdNone, @"%s missing fileId", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"circles/%li/files/%li?", (long)circleId, (long)fileId];
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.circles.deleteFile()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppEngine] DELETE:requestString success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        });
    } failure:^(NSError *error) {
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@", error.userInfo]]);
            });
        });
    }];
}

#pragma mark - Circle Posts

/**
 * Make a post.
 *
 * @param circleId Required PPCircleId Circle ID
 * @param originalPostId PPCirclePostId Original post ID to reply to
 * @param postId PPCirclePostId Post ID to edit content
 * @param text NSString Post text
 * @param fileId PPFileId File ID
 * @param displayAt PPCirclePostDisplayTime Display at time in seconds (since midnight?)
 * @param displayDuration PPCirclePostDisplayTime Display duration time in seconds
 * @param callback PPCirclePostMakeBlock Make post callback block
 **/
+ (void)makePost:(PPCircleId)circleId originalPostId:(PPCirclePostId)originalPostId postId:(PPCirclePostId)postId text:(NSString *)text fileId:(PPFileId)fileId displayAt:(PPCirclePostDisplayTime)displayAt displayDuration:(PPCirclePostDisplayTime)displayDuration callback:(PPCirclePostMakeBlock)callback {
    NSAssert1(circleId != PPCountryIdNone, @"%s missing circleId", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"circles/%li/posts?", (long)circleId];
    
    if(originalPostId != PPCirclePostIdNone) {
        [requestString appendFormat:@"originalPostId=%li&", (long)originalPostId];
    }
    if(postId != PPCirclePostIdNone) {
        [requestString appendFormat:@"postId=%li&", (long)postId];
    }
    
    NSMutableString *JSONString = [[NSMutableString alloc] init];
    [JSONString appendString:@"{"];
    
    PPCircleFile *file = [[PPCircleFile alloc] initWithId:fileId thumbnail:PPFileThumbnailNone name:nil type:PPFileFileTypeNone creationDate:nil size:PPFileSizeNone duration:PPFileDurationNone rotate:PPFileRotateNone user:nil ext:nil width:PPCircleFileWidthNone height:PPCircleFileHeightNone data:nil];
    
    PPCirclePost *post = [[PPCirclePost alloc] initWithId:PPCirclePostIdNone originalPostId:PPCirclePostIdNone circleId:circleId text:text authorId:PPUserIdNone creationDate:nil updateDate:nil deleted:PPCirclePostDeletedNone file:file displayAt:displayAt displayDuration:displayDuration reactions:nil];
    
    [JSONString appendFormat:@"\"post\": %@", [PPCirclePost stringify:post]];
    [JSONString appendString:@"}"];
    
    NSError *error;
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppEngine] getRequestSerializer] requestWithMethod:@"POST" URLString:[NSURL URLWithString:requestString relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    [request setHTTPBody:[JSONString dataUsingEncoding:NSUTF8StringEncoding]];
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.circles.makePost()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppEngine] operationWithRequest:request success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPCirclePostId postId = PPCirclePostIdNone;
            
            if(!error) {
                if([root objectForKey:@"postId"]) {
                    postId = (PPCirclePostId)((NSString *)[root objectForKey:@"postId"]).integerValue;
                }
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(postId, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(PPCirclePostIdNone, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@", error.userInfo]]);
            });
        });
    }];
}

/**
 * Get Posts.
 *
 * @param circleIds NSArray Circle ID, multiple values supported
 * @param postId PPCirclePostId Specific original or reply post ID to filter by
 * @param authorId PPUserID Post author user ID
 * @param startDate NSDate Start date of the posts list
 * @param endDate NSDate End date of the posts list
 * @param searchText NSString Search text
 * @param callback PPCirclePostsBlock Posts callback block
 **/
+ (void)getPostsForCircles:(NSArray *)circleIds postId:(PPCirclePostId)postId authorId:(PPUserId)authorId startDate:(NSDate *)startDate endDate:(NSDate *)endDate searchText:(NSString *)searchText callback:(PPCirclePostsBlock)callback {
    NSMutableString *requestString = [[NSMutableString alloc] initWithString:@"circlePosts?"];
    
    if([circleIds count] > 0) {
        for(NSNumber *circleId in circleIds) {
            if(circleId.integerValue != PPCircleIdNone) {
                [requestString appendFormat:@"circleId=%li&", (long)circleId.integerValue];
            }
        }
    }
    
    if(postId != PPCirclePostIdNone) {
        [requestString appendFormat:@"postId=%li&", (long)postId];
    }
    if(authorId != PPUserIdNone) {
        [requestString appendFormat:@"authorId=%li&", (long)authorId];
    }
    if(startDate) {
        [requestString appendFormat:@"startDate=%@&", [PPNSString stringByAddingURIPercentEscapesUsingEncoding:NSUTF8StringEncoding toString:[PPNSDate apiFriendStringFromDate:startDate]]];
    }
    if(endDate) {
        [requestString appendFormat:@"endDate=%@&", [PPNSString stringByAddingURIPercentEscapesUsingEncoding:NSUTF8StringEncoding toString:[PPNSDate apiFriendStringFromDate:endDate]]];
    }
    if(searchText) {
        [requestString appendFormat:@"searchText=%@&", [PPNSString stringByAddingURIPercentEscapesUsingEncoding:NSUTF8StringEncoding toString:searchText]];
    }
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.circles.getPosts()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppEngine] GET:requestString success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSMutableArray *posts;
            
            if(!error) {
                posts = [[NSMutableArray alloc] initWithCapacity:0];
                for(NSDictionary *postDict in [root objectForKey:@"posts"]) {
                    PPCirclePost *post = [PPCirclePost initWithDictionary:postDict];
                    [posts addObject:post];
                }
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(posts, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@", error.userInfo]]);
            });
        });
    }];
}
+ (void)getPosts:(PPCircleId)circleId postId:(PPCirclePostId)postId authorId:(PPUserId)authorId startDate:(NSDate *)startDate endDate:(NSDate *)endDate searchText:(NSString *)searchText callback:(PPCirclePostsBlock)callback {
    NSMutableArray *circleIds = [[NSMutableArray alloc] initWithCapacity:0];
    if(circleId != PPCircleIdNone) {
        [circleIds addObject:@(circleId)];
    }
    [PPCircles getPostsForCircles:circleIds postId:postId authorId:authorId startDate:startDate endDate:endDate searchText:searchText callback:callback];
}

/**
 * Delete Post.
 * Post can be deleted by the author or circle admin.
 * Deleting a post will delete all attached files. Deleting an original post will delete all replyes and reactions.
 *
 * @param circleId Required PPCircleId Circle ID
 * @param postId PPCirclePostId Specific original or reply post ID to delete
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)deletePost:(PPCircleId)circleId postId:(PPCirclePostId)postId callback:(PPErrorBlock)callback {
    NSAssert1(circleId != PPCountryIdNone, @"%s missing circleId", __FUNCTION__);
    NSAssert1(postId != PPCirclePostIdNone, @"%s missing postId", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"circles/%li/posts?postId=%li", (long)circleId, (long)postId];
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.circles.deletePost()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppEngine] DELETE:requestString success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        });
    } failure:^(NSError *error) {
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@", error.userInfo]]);
            });
        });
    }];
}

#pragma mark - React on Post

/**
 * React.
 *
 * @param circleId Required PPCircleId Circle ID
 * @param postId Required PPCirclePostId Specific original or reply post ID to react on
 * @param type Required PPCircleReactionType Reaction type
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)react:(PPCircleId)circleId postId:(PPCirclePostId)postId type:(PPCircleReactionType)type callback:(PPErrorBlock)callback {
    NSAssert1(circleId != PPCountryIdNone, @"%s missing circleId", __FUNCTION__);
    NSAssert1(postId != PPCirclePostIdNone, @"%s missing postId", __FUNCTION__);
    NSAssert1(type != PPCircleReactionTypeNone, @"%s missing type", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"circles/%li/posts/%li/reactions/%li", (long)circleId, (long)postId, (long)type];
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.circles.react()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppEngine] PUT:requestString success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(error);
            });
        });
    } failure:^(NSError *error) {
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@", error.userInfo]]);
            });
        });
    }];
}

#pragma mark - Circle Devices

/**
 * Get Devices.
 * Retrieve connected device instances linked to users inside the circle.
 *
 * @param circleId Required PPCircleId Circle ID
 * @param callback PPCircleDevicesBlock Devices callback block
 **/
+ (void)getDevices:(PPCircleId)circleId callback:(PPCircleDevicesBlock)callback {
    NSAssert1(circleId != PPCountryIdNone, @"%s missing circleId", __FUNCTION__);
    NSMutableString *requestString = [[NSMutableString alloc] initWithFormat:@"circles/%li/devices?", (long)circleId];
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.circles.getDevices()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAppEngine] GET:requestString success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSMutableArray *devices;
            if(!error) {
                devices = [[NSMutableArray alloc] initWithCapacity:0];
                for(NSDictionary *deviceDict in [root objectForKey:@"devices"]) {
                    PPCircleDevice *device;
                    PPDeviceTypeId typeId = PPDeviceTypeIdNone;
                    if([deviceDict objectForKey:@"type"]) {
                        typeId = (PPDeviceTypeId)((NSString *)[deviceDict objectForKey:@"type"]).integerValue;
                    }
                    switch (typeId) {
                        case PPDeviceTypeIdiOSMobileCamera:
                            device = [PPCircleDeviceCamera initWithDictionary:deviceDict];
                            break;
                        case PPDeviceTypeIdiOSPictureFrame:
                            device = [PPCircleDevicePictureFrame initWithDictionary:deviceDict];
                            break;
                            
                        default:
                            device = [PPCircleDevice initWithDictionary:deviceDict];
                            break;
                    }
                    device.circleId = circleId;
                    [devices addObject:device];
                }
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(devices, error);
            });
        });
    } failure:^(NSError *error) {
            
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@", error.userInfo]]);
            });
        });
    }];
}

@end

