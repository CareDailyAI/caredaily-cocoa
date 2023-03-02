//
//  PPCommunityPost.m
//  Peoplepower
//
//  Created by Destry Teeter on 11/13/19.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPCommunityPost.h"

@implementation PPCommunityPost

+ (NSString *)primaryKey {
    return @"postId";
}

- (id)initWithPostType:(PPCommunityPostType)postType
                postId:(PPCommunityPostId)postId
                status:(PPCommunityPostStatus)status
              location:(PPCommunityLocation *)location
           byModerator:(PPCommunityModerator)byModerator
                  user:(PPCommunityUser *)user
           communityId:(PPCommunityId)communityId
          creationDate:(NSDate *)creationDate
                 title:(NSString *)title
                 topic:(NSString *)topic
              driveUrl:(NSURL *)driveUrl
              postText:(NSString *)postText
                allDay:(PPCommunityEventAllDay)allDay
             eventDate:(NSDate *)eventDate
         nextEventDate:(NSDate *)nextEventDate
              duration:(NSNumber *)duration
                repeat:(NSString *)repeat
         repeatEndDate:(NSDate *)repeatEndDate
              latitude:(NSNumber *)latitude
             longitude:(NSNumber *)longitude
               address:(PPAddress *)address
                 files:(RLMArray *)files
             reactions:(RLMArray *)reactions
              comments:(RLMArray *)comments
             reminders:(RLMArray *)reminders {
    self = [super init];
    if (self) {
        self.postType = postType;
        self.postId = postId;
        self.status = status;
        self.location = location;
        self.byModerator = byModerator;
        self.user = user;
        self.communityId = communityId;
        self.creationDate = creationDate;
        self.title = title;
        self.topic = topic;
        self.driveUrl = driveUrl.absoluteString;
        self.postText = postText;
        self.allDay = allDay;
        self.eventDate = eventDate;
        self.nextEventDate = nextEventDate;
        self.duration = duration;
        self.repeat = repeat;
        self.repeatEndDate = repeatEndDate;
        self.latitude = latitude;
        self.longitude = longitude;
        self.address = address;
        self.files = (RLMArray<PPCommunityFile *><PPCommunityFile> *)files;
        self.reactions = (RLMArray<PPCommunityReaction *><PPCommunityReaction> *)reactions;
        self.comments = (RLMArray<PPCommunityComment *><PPCommunityComment> *)comments;
        self.reminders = (RLMArray<PPCommunityPostReminder *><PPCommunityPostReminder> *)reminders;
    }
    return self;
}

+ (PPCommunityPost *)initWithDictionary:(NSDictionary *)postDict {
    PPCommunityPostType postType = PPCommunityPostTypeCommunity;
    if ([postDict objectForKey:@"postType"]) {
        postType = ((NSNumber *)[postDict objectForKey:@"postType"]).integerValue;
    }
    PPCommunityPostId postId = PPCommunityPostIdNone;
    if ([postDict objectForKey:@"postId"]) {
        postId = ((NSNumber *)[postDict objectForKey:@"postId"]).integerValue;
    }
    PPCommunityPostStatus status = PPCommunityPostStatusActive;
    if ([postDict objectForKey:@"status"]) {
        status = ((NSNumber *)[postDict objectForKey:@"status"]).integerValue;
    }
    PPCommunityLocation *location;
    if ([postDict objectForKey:@"location"]) {
        location = [PPCommunityLocation initWithDictionary:[postDict objectForKey:@"location"]];
    }
    PPCommunityModerator byModerator = PPCommunityModeratorNone;
    if([postDict objectForKey:@"byModerator"]) {
        byModerator = (PPCommunityModerator)((NSString *)[postDict objectForKey:@"byModerator"]).integerValue;
    }
    PPCommunityUser *user;
    if ([postDict objectForKey:@"user"]) {
        user = [PPCommunityUser initWithDictionary:[postDict objectForKey:@"user"]];
    }
    PPCommunityId communityId = PPCommunityIdNone;
    if ([postDict objectForKey:@"communityId"]) {
        communityId = ((NSNumber *)[postDict objectForKey:@"communityId"]).integerValue;
    }
    
    NSString *creationDateString = [postDict objectForKey:@"creationDate"];
    NSDate *creationDate;
    
    if(creationDateString != nil) {
        if(![creationDateString isEqualToString:@""]) {
            creationDate = [PPNSDate parseDateTime:creationDateString];
        }
    }
    NSString * title = [postDict objectForKey:@"title"];
    NSString * topic = [postDict objectForKey:@"topic"];
    NSString *driveUrlString = [postDict objectForKey:@"driveUrl"];
    NSURL * driveUrl;
    
    if (driveUrlString != nil) {
        driveUrl = [NSURL URLWithString:driveUrlString];
    }
    
    NSString * postText = [postDict objectForKey:@"postText"];
    
    PPCommunityEventAllDay allDay = PPCommunityEventAllDayNone;
    if ([postDict objectForKey:@"allDay"]) {
        allDay = ((NSNumber *)[postDict objectForKey:@"allDay"]).integerValue;
    }

    NSString *eventDateString = [postDict objectForKey:@"eventDate"];
    NSDate *eventDate;
    
    if(eventDateString != nil) {
        if(![eventDateString isEqualToString:@""]) {
            eventDate = [PPNSDate parseDateTime:eventDateString];
        }
    }
    
    NSString *nextEventDateString = [postDict objectForKey:@"nextEventDate"];
    NSDate *nextEventDate;
    
    if(nextEventDateString != nil) {
        if(![nextEventDateString isEqualToString:@""]) {
            nextEventDate = [PPNSDate parseDateTime:nextEventDateString];
        }
    }
    

    NSNumber *duration = [postDict objectForKey:@"duration"];
    NSString *repeat = [postDict objectForKey:@"repeat"];
    
    NSString *repeatEndDateString = [postDict objectForKey:@"repeatEndDate"];
    NSDate *repeatEndDate;
    
    if(repeatEndDateString != nil) {
        if(![repeatEndDateString isEqualToString:@""]) {
            repeatEndDate = [PPNSDate parseDateTime:repeatEndDateString];
        }
    }
    
    NSNumber * latitude = [postDict objectForKey:@"latitude"];
    NSNumber * longitude = [postDict objectForKey:@"longitude"];
    PPAddress *address = [PPAddress initWithDictionary:[postDict objectForKey:@"address"]];
    
    NSMutableArray * files;
    if ([postDict objectForKey:@"files"]) {
        files = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *fileDict in [postDict objectForKey:@"files"]) {
            PPCommunityFile *file = [PPCommunityFile initWithDictionary:fileDict];
            [files addObject:file];
        }
    }
    
    NSMutableArray * reactions;
    if ([postDict objectForKey:@"reactions"]) {
        reactions = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *reactionDict in [postDict objectForKey:@"reactions"]) {
            PPCommunityReaction *reaction = [PPCommunityReaction initWithDictionary:reactionDict];
            [reactions addObject:reaction];
        }
    }
    
    NSMutableArray * comments;
    if ([postDict objectForKey:@"comments"]) {
        comments = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *commentDict in [postDict objectForKey:@"comments"]) {
            PPCommunityComment *comment = [PPCommunityComment initWithDictionary:commentDict];
            [comments addObject:comment];
        }
    }
    
    NSMutableArray * reminders;
    if ([postDict objectForKey:@"reminders"]) {
        reminders = [[NSMutableArray alloc] initWithCapacity:0];
        for (NSDictionary *reminderDict in [postDict objectForKey:@"reminders"]) {
            PPCommunityPostReminder *reminder = [PPCommunityPostReminder initWithDictionary:reminderDict];
            [reminders addObject:reminder];
        }
    }
    
    PPCommunityPost *post = [[PPCommunityPost alloc] initWithPostType:postType
                                                               postId:postId
                                                               status:status
                                                             location:location
                                                          byModerator:byModerator
                                                                 user:user
                                                          communityId:communityId
                                                         creationDate:creationDate
                                                                title:title
                                                                topic:topic
                                                             driveUrl:driveUrl
                                                             postText:postText
                                                               allDay:allDay
                                                            eventDate:eventDate
                                                        nextEventDate:nextEventDate
                                                             duration:duration
                                                               repeat:repeat
                                                        repeatEndDate:repeatEndDate
                                                             latitude:latitude
                                                            longitude:longitude
                                                              address:address
                                                                files:(RLMArray *)files
                                                            reactions:(RLMArray *)reactions
                                                             comments:(RLMArray *)comments
                                                            reminders:(RLMArray *)reminders];
    return post;
}

+ (NSDictionary *)dataFromPost:(PPCommunityPost *)post {
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithCapacity:0];
    [data setValue:@(post.postType) forKey:@"postType"];
    if (post.status != PPCommunityPostStatusNone) {
        [data setValue:@(post.status) forKey:@"status"];
    }
    if (post.location) {
        [data setValue:@(post.location.locationId) forKey:@"locationId"];
    }
    if (post.communityId != PPCommunityIdNone) {
        [data setValue:@(post.communityId) forKey:@"communityId"];
    }
    if (post.title) {
        [data setValue:post.title forKey:@"title"];
    }
    if (post.topic) {
        [data setValue:post.topic forKey:@"topic"];
    }
    if (post.driveUrl) {
        [data setValue:post.driveUrl forKey:@"driveUrl"];
    }
    if (post.postText) {
        [data setValue:post.postText forKey:@"postText"];
    }
    if (post.allDay != PPCommunityEventAllDayNone) {
        [data setValue:@(post.allDay) forKey:@"allDay"];
    }
    if (post.eventDate) {
        [data setValue:[PPNSDate apiFriendStringFromDate:post.eventDate] forKey:@"eventDate"];
    }
    if (post.duration) {
        [data setValue:post.duration forKey:@"duration"];
    }
    if (post.repeat) {
        [data setValue:post.repeat forKey:@"repeat"];
    }
    if (post.repeatEndDate) {
        [data setValue:[PPNSDate apiFriendStringFromDate:post.repeatEndDate] forKey:@"repeatEndDate"];
    }
    if (post.latitude) {
        [data setValue:post.latitude forKey:@"latitude"];
    }
    if (post.longitude) {
        [data setValue:post.longitude forKey:@"longitude"];
    }
    if (post.address) {
        NSDictionary *addressData = [PPAddress dataFromAddress:post.address];
        if (addressData) {
            [data setValue:addressData forKey:@"address"];
        }
    }
    if (post.reminders) {
        NSMutableArray *reminders = [[NSMutableArray alloc] initWithCapacity:0];
        for (PPCommunityPostReminder *reminder in post.reminders) {
            [reminders addObject:[PPCommunityPostReminder dataFromPostReminder:reminder]];
        }
        [data setValue:reminders forKey:@"reminders"];
    }
    
    return data;
}

@end
