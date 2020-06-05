//
//  PPQuestions.h
//  PPiOSCore
//
//  Created by Destry Teeter on 3/9/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//
// Questions enable bi-directional conversations to take place between the user and their organization or data analytics services. Questions enable the user to add context to the data.
//

#import "PPBaseModel.h"
#import "PPQuestion.h"
#import "PPQuestionCollection.h"
#import "PPQuestionAnswer.h"
#import "PPQuestionResponseOption.h"
#import "PPOrganization.h"
#import "PPBotengineAppInstance.h"

typedef void (^PPQuestionsBlock)(NSArray * _Nullable collections, NSArray * _Nullable questions, NSError * _Nullable error);
typedef void (^PPQuestionsAnswersBlock)(NSArray * _Nullable questions, NSError * _Nullable error);

typedef NS_OPTIONS(NSInteger, PPQuestionsLimit) {
    PPQuestionsLimitNone = -1,
    PPQuestionsLimitUnlimited = 0 // default
};

typedef NS_OPTIONS(NSInteger, PPQuestionsPublic) {
    PPQuestionsPublicNone = -1,
    PPQuestionsPublicFalse = 0,
    PPQuestionsPublicTrue = 1,
};

@interface PPQuestions : PPBaseModel

#pragma mark - Session Management


#pragma mark Collections

/**
 * Shared questions across the entire application
 */
+ (NSArray *)sharedCollectionsForUser:(PPUserId)userId;

/**
 * Add collections.
 * Add collections from local reference.
 *
 * @param collections NSArray Array of collections to remove.
 * @param userId Required PPUserId User Id to associate these collections with
 **/
+ (void)addCollections:(NSArray *)collections userId:(PPUserId)userId;

/**
 * Remove collections.
 * Remove collections from local reference.
 *
 * @param collections NSArray Array of collections to remove.
 * @param userId Required PPUserId User Id to associate these collections with
 **/
+ (void)removeCollections:(NSArray *)collections userId:(PPUserId)userId;

#pragma mark Questions
/**
 * Shared questions across the entire application
 */
+ (NSArray *)sharedQuestionsForUser:(PPUserId)userId;

/**
 * Add questions.
 * Add questions to local reference.
 *
 * @param questions NSArray Array of questions to add.
 * @param userId Required PPUserId User Id to associate these questions with
 **/
+ (void)addQuestions:(NSArray *)questions userId:(PPUserId)userId;

/**
 * Remove questions.
 * Remove questions from local reference.
 *
 * @param questions NSArray Array of questions to remove.
 * @param userId Required PPUserId User Id to associate these questions with
 **/
+ (void)removeQuestions:(NSArray *)questions userId:(PPUserId)userId;

#pragma mark - Get Questions

/**
 * Get Questions.
 * Retrieve requested questions.
 * For an individual user, there should be at most one unanswered question available per day, unless the question is urgent. For public users, there can be many questions as we are using this on public surveys during a sign up process.
 *
 * @param locationId Required PPLocationId Location ID
 * @param answerStatuses NSArray Return questions with the specific answer status. By default questions with statuses 2 and 3 are returned. Multiple values are supported.
 * @param editable PPQuestionEditable Filter answered questions: true - return only editable answered questions, false - return only not editable answered questions, otherwise return all answered questions.
 * @param organizationId PPOrganizationId Organization ID to filter questions by
 * @param collectionName NSString Questions collection name filter
 * @param generalPublic PPQuestionCollectionGeneralPublic true - return only public questions, false - return only private questions
 * @param questionId PPQuestionId Extract a specifc question Id
 * @param appInstanceId PPBotengineAppInstanceId Only retrieve quetsions for a specific botengine app
 * @param lang NSString Quetsions text language. If not set, user's or default language will be used.
 * @param limit PPQuestionsLimit Maximum number of questions to return. The default is 0 (unlimited)
 * @param startDate NSDate Start date to select question
 * @param endDate NSDate End date to select questions. Default is the current date.
 * @param userId PPUserId Get specific user questions by organization administrator
 * @param callback PPQuestionsBlock Questions callback block containing arrays of collections and questions.
 **/
+ (void)getQuestions:(PPLocationId)locationId answerStatuses:(NSArray * _Nullable )answerStatuses editable:(PPQuestionEditable)editable organizationId:(PPOrganizationId)organizationId collectionName:(NSString * _Nullable )collectionName generalPublic:(PPQuestionCollectionGeneralPublic)generalPublic questionId:(PPQuestionId)questionId appInstanceId:(PPBotengineAppInstanceId)appInstanceId lang:(NSString * _Nullable )lang limit:(PPQuestionsLimit)limit startDate:(NSDate * _Nullable )startDate endDate:(NSDate * _Nullable )endDate userId:(PPUserId)userId callback:(PPQuestionsBlock _Nonnull )callback;
+ (void)getQuestions:(NSArray * _Nullable )answerStatuses editable:(PPQuestionEditable)editable organizationId:(PPOrganizationId)organizationId collectionName:(NSString * _Nullable )collectionName generalPublic:(PPQuestionCollectionGeneralPublic)generalPublic questionId:(PPQuestionId)questionId appInstanceId:(PPBotengineAppInstanceId)appInstanceId lang:(NSString * _Nullable )lang limit:(PPQuestionsLimit)limit startDate:(NSDate * _Nullable )startDate endDate:(NSDate * _Nullable )endDate userId:(PPUserId)userId callback:(PPQuestionsBlock _Nonnull )callback __attribute__((deprecated));
+ (void)getQuestions:(NSArray * _Nullable )answerStatuses editable:(PPQuestionEditable)editable organizationId:(PPOrganizationId)organizationId collectionName:(NSString * _Nullable )collectionName generalPublic:(PPQuestionCollectionGeneralPublic)generalPublic questionId:(PPQuestionId)questionId appInstanceId:(PPBotengineAppInstanceId)appInstanceId lang:(NSString * _Nullable )lang limit:(PPQuestionsLimit)limit publicQuestion:(PPQuestionsPublic)publicQuestion startDate:(NSDate * _Nullable )startDate endDate:(NSDate * _Nullable )endDate callback:(PPQuestionsBlock _Nonnull )callback __attribute__((deprecated));

/**
 * Answer a question.
 * After answering a question, the user should see how many points they earned (if any), and if the question is aggregated publicly then the user should also see how other people voted.
 * A user can skip the question or prefer to not answer it by setting the corresponding answer status. Providing just the question ID the UI app can mark the question as notified.
 * Only editable questions can be updated later. Typically editable questions are used to configure Composer Apps and add further context to the user's data later.
 * If any points were previously rewarded for previously answering this question, then answering the question again should not result in more points. However, if no points were previously rewarded and now the user is updating the answer to one that does reward points, then the user should receive those points.
 * The user's tagged attributes should migrate with the question, such that when a new answer is selected, any previous tags are removed and new tags are applied.
 * The body and response is designed to handle answers to multiple questions simultaneously.
 *
 * @param locationId Required PPLocationId Location ID to answer questions
 * @param questions NSArray Array of answered questions
 * @param userId PPUserId Answer specific user questions by organization administrator
 * @param callback PPQuestionsAnswersBlock Answers callback block
 **/
+ (void)answerQuestions:(PPLocationId)locationId questions:(NSArray * _Nullable )questions userId:(PPUserId)userId callback:(PPQuestionsAnswersBlock _Nonnull )callback;
+ (void)answerQuestions:(NSArray * _Nullable )questions userId:(PPUserId)userId callback:(PPQuestionsAnswersBlock _Nonnull )callback __attribute__((deprecated));
+ (void)answerQuestions:(NSArray * _Nullable )questions publicQuestion:(PPQuestionsPublic)publicQuestion callback:(PPQuestionsAnswersBlock _Nonnull )callback __attribute__((deprecated));

@end
