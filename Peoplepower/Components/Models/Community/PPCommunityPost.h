//
//  PPCommunityPost.h
//  PPiOSCore
//
//  Created by Destry Teeter on 11/13/19.
//  Copyright © 2019 People Power Company. All rights reserved.
//

#import "PPCommunityLocation.h"
#import "PPCommunityUser.h"
#import "PPCommunityPostReminder.h"
#import "PPCommunityReaction.h"
#import "PPCommunityComment.h"
#import "PPCommunityFile.h"
#import "PPLocationCommunity.h"
#import "PPAddress.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSInteger, PPCommunityPostId) {
    PPCommunityPostIdNone = -1
};

typedef NS_OPTIONS(NSInteger, PPCommunityPostType) {
    PPCommunityPostTypeIndividual = 1,
    PPCommunityPostTypeLocation = 2,
    PPCommunityPostTypeCommunity = 3
};

typedef NS_OPTIONS(NSInteger, PPCommunityPostStatus) {
    PPCommunityPostStatusNone = -1,
    PPCommunityPostStatusInactive = 0,
    PPCommunityPostStatusActive = 1,
    PPCommunityPostStatusRejected = 2
};

typedef NS_OPTIONS(NSInteger, PPCommunityModerator) {
    PPCommunityModeratorNone = -1,
    PPCommunityModeratorFalse = 0,
    PPCommunityModeratorTrue = 1
};

typedef NS_OPTIONS(NSInteger, PPCommunityEventAllDay) {
    PPCommunityEventAllDayNone = -1,
    PPCommunityEventAllDayFalse = 0,
    PPCommunityEventAllDayTrue = 1
};

@interface PPCommunityPost : RLMObject

@property (nonatomic) PPCommunityPostType postType;
@property (nonatomic) PPCommunityPostId postId;
@property (nonatomic) PPCommunityPostStatus status;
@property (nonatomic, strong) PPCommunityLocation *location;
@property (nonatomic) PPCommunityModerator byModerator;
@property (nonatomic, strong) PPCommunityUser *user;
@property (nonatomic) PPCommunityId communityId;
@property (nonatomic, strong) NSDate *creationDate;
@property (nonatomic, strong) NSString * _Nullable title;
@property (nonatomic, strong) NSString * _Nullable topic;
@property (nonatomic, strong) NSString * _Nullable driveUrl;
@property (nonatomic, strong) NSString * _Nullable postText;

// Event parameters
@property (nonatomic) PPCommunityEventAllDay allDay;
@property (nonatomic, strong) NSDate * _Nullable eventDate;
@property (nonatomic, strong) NSDate * _Nullable nextEventDate;
@property (nonatomic) NSNumber<RLMInt> * _Nullable duration;
@property (nonatomic) NSString * _Nullable repeat;
@property (nonatomic, strong) NSDate * _Nullable repeatEndDate;


@property (nonatomic) NSNumber<RLMFloat> * _Nullable latitude;
@property (nonatomic) NSNumber<RLMFloat> * _Nullable longitude;
@property (nonatomic) PPAddress * _Nullable address;
@property (nonatomic, strong) RLMArray<PPCommunityFile *><PPCommunityFile> *files;
@property (nonatomic, strong) RLMArray<PPCommunityReaction *><PPCommunityReaction> *reactions;
@property (nonatomic, strong) RLMArray<PPCommunityComment *><PPCommunityComment> *comments;
@property (nonatomic, strong) RLMArray<PPCommunityPostReminder *><PPCommunityPostReminder> *reminders;


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
               replies:(RLMArray *)comments
             reminders:(RLMArray *)reminders;

+ (PPCommunityPost *)initWithDictionary:(NSDictionary *)postDict;

+ (NSDictionary *)dataFromPost:(PPCommunityPost *)post;
@end

RLM_ARRAY_TYPE(PPCommunityPost);

NS_ASSUME_NONNULL_END
