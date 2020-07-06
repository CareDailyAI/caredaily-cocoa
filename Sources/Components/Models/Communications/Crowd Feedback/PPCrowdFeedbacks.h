//
//  PPCrowdFeedbacks.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//
// Crowd feedback is first delivered to a support email for moderation. If the feedback is unique, then the support staff will make it public for other users to vote on.
//

#import "PPBaseModel.h"
#import "PPCrowdFeedback.h"
#import "PPCrowdFeedbackSupport.h"
#import "PPCrowdFeedbackTicket.h"

typedef void (^PPCrowdFeedbacksTicketBlock)(PPCrowdFeedbackTicket * _Nullable ticket, NSError * _Nullable error);
typedef void (^PPCrowdFeedbacksBlock)(NSArray * _Nullable feedbacks, NSError * _Nullable error);

typedef NS_OPTIONS(NSInteger, PPCrowdFeedbacksStartPosition) {
    PPCrowdFeedbacksStartPositionNone = -1
};

typedef NS_OPTIONS(NSInteger, PPCrowdFeedbacksLength) {
    PPCrowdFeedbacksLengthNone = -1
};

typedef NS_OPTIONS(NSInteger, PPCrowdFeedbacksDisabled) {
    PPCrowdFeedbacksDisabledNone = -1,
    PPCrowdFeedbacksDisabledFalse = 0,
    PPCrowdFeedbacksDisabledTrue = 1
};

@interface PPCrowdFeedbacks : PPBaseModel

#pragma mark - Session Management

/**
 * Shared feedbacks across the entire application
 */
+ (NSArray *)sharedFeedbacksForUser:(PPUserId)userId;

/**
 * Add feedbacks.
 * Add feedbacks to local reference.
 *
 * @param feedbacks NSArray Array of feedbacks to add.
 * @param userId Required PPUserId User Id to associate these feedbacks with
 **/
+ (void)addFeedbacks:(NSArray *)feedbacks userId:(PPUserId)userId;

/**
 * Remove feedbacks.
 * Remove feedbacks from local reference.
 *
 * @param feedbacks NSArray Array of feedbacks to remove.
 * @param userId Required PPUserId User Id to associate these feedbacks with
 **/
+ (void)removeFeedbacks:(NSArray *)feedbacks userId:(PPUserId)userId;

#pragma mark - Post Crowd Feedback

/**
 * Post Crowd Feedback.
 * The API returns the created feedback record ID and if a ticket has been created in a support cloud, then the ticket ID and the brand name.
 *
 * @param feedback required PPCrowdFeedback Feedback to send
 * @param callback PPCrowdFeedbacksTicketBlock Feedback callback block containing ticket response
 **/
+ (void)postCrowdFeedback:(PPCrowdFeedback * _Nonnull )feedback callback:(PPCrowdFeedbacksTicketBlock _Nonnull )callback;

#pragma mark - Get Crowd Feedback by Searching

/**
 * Get Crowd Feedback by Searching
 *
 * @param appName Required NSString Unique name / identifier of the app or product, selected by the developer
 * @param type Required PPCrowdFeedbackType Crowd feedback type
 * @param startPosition PPCrowdFeedbacksStartPosition Index of the first record to be returned
 * @param length Required PPCrowdFeedbacksLength Number of records to return
 * @param productIds NSArray Filter the response by product ID. You may include multiple of these parameters to filter by multiple product IDs
 * @param productCategories NSArray Filter the response by product category. You may include multiple of these parameters to filter by multiple product categories
 * @param disabled PPCrowdFeedbacksDisabled Return not enabled feedbacks as well
 * @param callback PPCrowdFeedbacksBlock Feedbacks callback block containing array of feedbacks
 **/
+ (void)getCrowdFeedbackBySearching:(NSString * _Nonnull )appName type:(PPCrowdFeedbackType)type startPosition:(PPCrowdFeedbacksStartPosition)startPosition length:(PPCrowdFeedbacksLength)length productIds:(NSArray * _Nullable )productIds productCategories:(NSArray * _Nullable )productCategories disabled:(PPCrowdFeedbacksDisabled)disabled callback:(PPCrowdFeedbacksBlock _Nonnull )callback;

#pragma mark - Get Specific Crowd Feedback

/**
 * Get Specific crowd feebdack
 *
 * @param feedbackId Required PPCrowdFeedbackId Specific feedback ID to obtain
 * @param callback PPCrowdFeedbacksBlock Feedbacks callback block containing array of feedbacks
 **/
+ (void)getSpecificCrowdFeedback:(PPCrowdFeedbackId)feedbackId callback:(PPCrowdFeedbacksBlock _Nonnull )callback;

#pragma mark - Update Feedback

/**
 * Update feedback.
 * An administrator can update feedback left by users related to his organizations.
 *
 * @param feedbackId Requried PPCrowdFeedbackId Specific feedback ID to update
 * @param feedback Required PPCrowdFeedback Feedback object to update the reference with
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)updateFeedback:(PPCrowdFeedbackId)feedbackId feedback:(PPCrowdFeedback * _Nonnull )feedback callback:(PPErrorBlock _Nonnull )callback;

#pragma mark - Vote for Feedback

/**
 * Vote for feedback.
 *
 * @param feedbackId Required PPCrowdFeedbackId Specific feedback ID to update
 * @param rank Required PPCrowdFeedbackRank Cast a vote or remove existing vote
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)voteForFeedback:(PPCrowdFeedbackId)feedbackId rank:(PPCrowdFeedbackRank)rank callback:(PPErrorBlock _Nonnull )callback;

#pragma mark - Request Support

/**
 * Request Support.
 * If a ticket has been created in a support cloud, then the API returns the ticket ID and the brand name.
 *
 * @param appName NSString  App name to forward the support request
 * @param feedbackSupport PPCrowdFeedbackSupport Feedback support object
 * @param callback PPCrowdFeedbacksTicketBlock Feedbacks ticket block
 **/
+ (void)requestSupport:(NSString * _Nullable )appName feedbackSupport:(PPCrowdFeedbackSupport * _Nullable )feedbackSupport callback:(PPCrowdFeedbacksTicketBlock _Nonnull )callback;

@end
