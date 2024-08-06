//
//  PPTCCommunications.m
//  iOS_Core_Tests
//
//  Created by Destry Teeter on 3/19/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPBaseTestCase.h"
#import <Peoplepower/PPLocation.h>
#import <Peoplepower/PPNotificationPushMessage.h>
#import <Peoplepower/PPNotificationEmailMessage.h>
#import <Peoplepower/PPNotificationSMSMessage.h>
#import <Peoplepower/PPCrowdFeedback.h>
#import <Peoplepower/PPCrowdFeedbackSupport.h>
#import <Peoplepower/PPInAppMessage.h>
#import <Peoplepower/PPSMSSubscriber.h>
#import <Peoplepower/PPQuestions.h>
#import <Peoplepower/PPNotifications.h>
#import <Peoplepower/PPCrowdFeedbacks.h>
#import <Peoplepower/PPInAppMessaging.h>
#import <Peoplepower/PPSMSGroupTexting.h>
#import <Peoplepower/PPSurveys.h>
#import <Peoplepower/PPSupportTickets.h>

static NSString *moduleName = @"UserCommunications";

@interface PPTCCommunications : PPBaseTestCase
@property (strong, nonatomic) NSString *appName;
@property (strong, nonatomic) NSString *brand;
@property (strong, nonatomic) NSString *token;
@property (strong, nonatomic) PPLocation *location;
@property (strong, nonatomic) PPNotificationPushMessage *pushMessage;
@property (strong, nonatomic) PPNotificationEmailMessage *emailMessage;
@property (strong, nonatomic) PPNotificationSMSMessage *smsMessage;
@property (strong, nonatomic) PPCrowdFeedback *feedback;
@property (strong, nonatomic) PPCrowdFeedbackSupport *feedbackSupport;
@property (strong, nonatomic) PPInAppMessage *message;
@property (strong, nonatomic) NSArray *answerStatuses;
@property (strong, nonatomic) NSArray *questions;
@property (strong, nonatomic) PPSMSSubscriber *smsSubscriber;
@property (strong, nonatomic) PPSurveyQuestion *surveyQuestion;
@property (strong, nonatomic) PPSupportTicket *supportTicket;
@end

@implementation PPTCCommunications

- (void)setUp {
    [super setUp];
    
    NSString *appName = (NSString *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_APP_NAME filename:PLIST_FILE_UNIT_TESTS];
    NSString *brand = (NSString *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_BRAND filename:PLIST_FILE_UNIT_TESTS];
    NSString *token = (NSString *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_NOTIFICATION_TOKEN filename:PLIST_FILE_UNIT_TESTS];
    NSDictionary *locationDict = (NSDictionary *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_USER_ACCOUNTS_TEST_LOCATION filename:PLIST_FILE_UNIT_TESTS];
    NSDictionary *pushMessageDict = (NSDictionary *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_NOTIFICATION_PUSH_MESSAGE filename:PLIST_FILE_UNIT_TESTS];
    NSDictionary *emailMessageDict = (NSDictionary *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_NOTIFICATION_EMAIL_MESSAGE filename:PLIST_FILE_UNIT_TESTS];
    NSDictionary *smsMessageDict = (NSDictionary *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_NOTIFICATION_SMS_MESSAGE filename:PLIST_FILE_UNIT_TESTS];
    NSDictionary *feedbackDict = (NSDictionary *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_CROWD_FEEDBACK_FEEDBACK filename:PLIST_FILE_UNIT_TESTS];
    NSDictionary *feedbackSupportDict = (NSDictionary *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_CROWD_FEEDBACK_FEEDBACK_SUPPORT filename:PLIST_FILE_UNIT_TESTS];
    NSDictionary *messageDict = (NSDictionary *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_IN_APP_MESSAGING_MESSAGE filename:PLIST_FILE_UNIT_TESTS];
    NSArray *questionsArray = (NSArray *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_QUESTIONS filename:PLIST_FILE_UNIT_TESTS];
    NSDictionary *subscriberDict = (NSDictionary *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_SMS_GROUP_TEXTING_SUBSCRIBER filename:PLIST_FILE_UNIT_TESTS];
    NSDictionary *surveyQuestionDict = (NSDictionary *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_SURVEY_QUESTION filename:PLIST_FILE_UNIT_TESTS];
    NSDictionary *supportTicketDict = (NSDictionary *)[PPAppResources getPlistEntry:PLIST_KEY_TEST_SUPPORT_TICKET filename:PLIST_FILE_UNIT_TESTS];

    
    self.appName = appName;
    self.brand = brand;
    self.token = token;
    self.location = [PPLocation initWithDictionary:locationDict];
    self.pushMessage = [PPNotificationPushMessage initWithDictionary:pushMessageDict];
    self.emailMessage = [PPNotificationEmailMessage initWithDictionary:emailMessageDict];
    self.smsMessage = [PPNotificationSMSMessage initWithDictionary:smsMessageDict];
    self.feedback = [PPCrowdFeedback initWithDictionary:feedbackDict];
    self.feedbackSupport = [PPCrowdFeedbackSupport initWithDictionary:feedbackSupportDict];
    self.message = [PPInAppMessage initWithDictionary:messageDict];
    self.answerStatuses = @[@(PPQuestionAnswerStatusReady),
                          @(PPQuestionAnswerStatusDelayed),
                          @(PPQuestionAnswerStatusSkipped),
                          @(PPQuestionAnswerStatusAnswered),
                          @(PPQuestionAnswerStatusNoAnswer),
                          @(PPQuestionAnswerStatusAvailable)];
    NSMutableArray *questions = @[].mutableCopy;
    [questionsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [questions addObject:[PPQuestion initWithDictionary:(NSDictionary *)obj]];
    }];
    self.questions = questions;
    self.smsSubscriber = [PPSMSSubscriber initWithDictionary:subscriberDict];
    self.surveyQuestion = [PPSurveyQuestion initWithDictionary:surveyQuestionDict];
    self.supportTicket = [PPSupportTicket initWithDictionary:supportTicketDict];
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark - Get notification subcriptions

/**
 * Get notification subscriptions.
 * A user may subscribe or unsubscribe from certain types of push and email notifications, or set boundaries on how many notifications their account can receive within a specified amount of time.
 *
 * @ param callback PPNotificationSubscriptionsBlock Subscriptions callback block with an array of existing subscriptions
 **/
- (void)testGetNotificationSubscriptions {
    NSString *methodName = @"GetNotificationSubscriptions";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/cloud/json/notificationSubscriptions" statusCode:200 headers:nil];

    [PPNotifications getNotificationSubscriptions:^(NSArray *subscriptions, NSError *error) {

        XCTAssertNil(error);
        [expectation fulfill];

    }];

    [self waitForExpectations:@[expectation] timeout:10.0];
}

#pragma mark - Set my notification subscriptions

/**
 * Set my notification subscriptions
 *
 * @ param type Required PPNotificationSubscriptionType Type of notification, as defined by the IoT Software Suite during the request to Get Subscription Notifications
 * @ param email PPNotificationSubscriptionEmailEnabled Enable or disable email notifications
 * @ param push PPNotificationSubscriptionPushEnabled Enable or disable push notifications
 * @ param sms PPNotificationSubscriptionSMSEnabled Enable or disable sms notifications
 * @ param emailPeriod PPNotificationSubscriptionEmailPeriod Maximum number of seconds between email notifications
 * @ param pushPeriod PPNotificationSubscriptionPushPeriod Maximum number of seconds between push notifications
 * @ param smsPeriod PPNotificationSubscriptionSMSPeriod Maximum number of seconds between sms notifications
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testSetNotificationSubscription {
    NSString *methodName = @"SetNotificationSubscriptions";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/cloud/json/notificationSubscriptions/%@", @(PPNotificationSubscriptionTypeAll)] statusCode:200 headers:nil];

    [PPNotifications setNotificationSubscription:PPNotificationSubscriptionTypeAll email:PPNotificationSubscriptionEmailEnabledTrue push:PPNotificationSubscriptionPushEnabledTrue sms:PPNotificationSubscriptionSMSEnabledTrue emailPeriod:PPNotificationSubscriptionEmailPeriodAllTheTime pushPeriod:PPNotificationSubscriptionPushPeriodAllTheTime smsPeriod:PPNotificationSubscriptionSMSPeriodAllTheTime callback:^(NSError *error) {

        XCTAssertNil(error);
        [expectation fulfill];

    }];

    [self waitForExpectations:@[expectation] timeout:10.0];
}

#pragma mark - Register an app for push notifications

/**
 * Register an app for push notifications
 *
 * @ param appName NSString Uniqu App Name to register for push notifications
 * @ param notificationToken NSString The iOS notification token returned through didRegisterForRemoteNotificationsWithDeviceToken method
 * @ param badge PPNotificationSubscriptionSupportsBadgeIcons Supports badge icons. Default is False.
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testRegisterAnAppForPushNotifications {
    NSString *methodName = @"RegisterAnAppForPushNotifications";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/cloud/json/notificationToken/%@/%@", self.appName, self.token] statusCode:200 headers:nil];

    [PPNotifications registerAnAppForPushNotifications:self.appName notificationToken:self.token badge:PPNotificationSubscriptionSupportsBadgeIconsTrue callback:^(NSError *error) {

        XCTAssertNil(error);
        [expectation fulfill];

    }];

    [self waitForExpectations:@[expectation] timeout:10.0];
}

#pragma mark - Unregister an app for push notifications

/**
 * Unregister an app for push notifications
 *
 * @ param notificationToken NSString The iOS notification token returned through didRegisterForRemoteNotificationsWithDeviceToken method
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testUnregisterAnAppForPushNotifications {
    NSString *methodName = @"UnregisterAnAppForPushNotifications";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/cloud/json/notificationToken/%@", self.token] statusCode:200 headers:nil];

    [PPNotifications unregisterAnAppForPushNotifications:self.token callback:^(NSError *error) {

        XCTAssertNil(error);
        [expectation fulfill];

    }];

    [self waitForExpectations:@[expectation] timeout:10.0];
}

#pragma mark - Send a notification

/**
 * Send a notification.
 * Sends an arbitrary push notification or email to the user. If you're sending an email, you may include a subject and specify whether the email is in HTML format or plain text. Push notification messages are limited by the standard push notification payload size, usually ~120 characters max is OK.
 * This API allows to include inline graphics as an attachment. All attachment fields are mandatory. The content field contains the Base64 encoded binary image content.
 * The generated by the app email content or the template should include correct references to inline graphics content ID's with "cid:" prefixes. For example <img src="cid:inlineImageId">.
 *
 * @ param userId PPUserId Send a notification to this user by an administrator
 * @ param organizationId PPOrganizationId Use templates of specific organization
 * @ param brand NSString Brand name
 * @ param emailMessage PPNotificationEmailMessage Email message
 * @ param pushMessage PPNotificationPushMessage Push message
 * @ param smsMessage PPNotificationSMSMessage SMS message
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testSendNotification {
    NSString *methodName = @"SendNotification";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/cloud/json/notifications" statusCode:200 headers:nil];

    [PPNotifications sendNotification:PPUserIdNone organizationId:PPOrganizationIdNone brand:self.brand emailMessage:self.emailMessage pushMessage:self.pushMessage smsMessage:self.smsMessage callback:^(NSError *error) {

        XCTAssertNil(error);
        [expectation fulfill];

    }];

    [self waitForExpectations:@[expectation] timeout:10.0];
}

/**
 * Get notifications.
 * Get a history of notificaitons.
 *
 * @ param userId PPUserId Get notifications for this user by an administrator
 * @ param startDate Required NSDate Start date t oselect notifications
 * @ param endDate NSDate End date to select notifications. Default is the current date.
 * @ param callback PPNotificationHistoryBlock Notifications historty callback block
 **/
- (void)testGetNotifications {
    NSString *methodName = @"GetNotifications";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/cloud/json/notifications" statusCode:200 headers:nil];

    [PPNotifications getNotifications:PPUserIdNone startDate:[NSDate dateWithTimeIntervalSince1970:0] endDate:nil callback:^(NSArray *notifications, NSError *error) {

        XCTAssertNil(error);
        [expectation fulfill];

    }];

    [self waitForExpectations:@[expectation] timeout:10.0];
}

#pragma mark - Post Crowd Feedback

/**
 * Post Crowd Feedback.
 * The API returns the created feedback record ID and if a ticket has been created in a support cloud, then the ticket ID and the brand name.
 *
 * @ param feedback required PPCrowdFeedback Feedback to send
 * @ param callback PPCrowdFeedbacksTicketBlock Feedback callback block containing ticket response
 **/
- (void)testPostCrowdFeedback {
    NSString *methodName = @"PostCrowdFeedback";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/cloud/json/feedback" statusCode:200 headers:nil];

    [PPCrowdFeedbacks postCrowdFeedback:self.feedback brand:self.brand callback:^(PPCrowdFeedbackTicket *ticket, NSError *error) {

        XCTAssertNil(error);
        [expectation fulfill];

    }];

    [self waitForExpectations:@[expectation] timeout:10.0];
}

#pragma mark - Get Crowd Feedback by Searching

/**
 * Get Crowd Feedback by Searching
 *
 * @ param appName Required NSString Unique name / identifier of the app or product, selected by the developer
 * @ param type Required PPCrowdFeedbackType Crowd feedback type
 * @ param startPosition PPCrowdFeedbacksStartPosition Index of the first record to be returned
 * @ param length Required PPCrowdFeedbacksLength Number of records to return
 * @ param productIds NSArray Filter the response by product ID. You may include multiple of these parameters to filter by multiple product IDs
 * @ param productCategories NSArray Filter the response by product category. You may include multiple of these parameters to filter by multiple product categories
 * @ param disabled PPCrowdFeedbacksDisabled Return not enabled feedbacks as well
 * @ param callback PPCrowdFeedbacksBlock Feedbacks callback block containing array of feedbacks
 **/
- (void)testGetCrowdFeedbackBySearching {
    NSString *methodName = @"GetCrowdFeedbackBySearching";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/cloud/json/feedback/%@/%@", self.appName, @(PPCrowdFeedbackTypeNewFeatureRequest)] statusCode:200 headers:nil];

    [PPCrowdFeedbacks getCrowdFeedbackBySearching:self.appName type:PPCrowdFeedbackTypeNewFeatureRequest startPosition:0 length:10 productIds:nil productCategories:nil disabled:PPCrowdFeedbacksDisabledNone callback:^(NSArray *feedbacks, NSError *error) {

        XCTAssertNil(error);

        [expectation fulfill];

    }];

    [self waitForExpectations:@[expectation] timeout:10.0];
}

#pragma mark - Get Specific Crowd Feedback

/**
 * Get Specific crowd feebdack
 *
 * @ param feedbackId Required PPCrowdFeedbackId Specific feedback ID to obtain
 * @ param callback PPCrowdFeedbacksBlock Feedbacks callback block containing array of feedbacks
 **/
- (void)testGetSpecificCrowdFeedback {
    NSString *methodName = @"GetSpecificCrowdFeedback";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/cloud/json/feedback/%@", @(self.feedback.feedbackId)] statusCode:200 headers:nil];

    [PPCrowdFeedbacks getSpecificCrowdFeedback:self.feedback.feedbackId callback:^(NSArray *feedbacks, NSError *error) {

        XCTAssertNil(error);
        [expectation fulfill];

    }];

    [self waitForExpectations:@[expectation] timeout:10.0];
}

#pragma mark - Update Feedback

/**
 * Update feedback.
 * An administrator can update feedback left by users related to his organizations.
 *
 * @ param feedbackId Requried PPCrowdFeedbackId Specific feedback ID to update
 * @ param feedback Required PPCrowdFeedback Feedback object to update the reference with
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testUpdateFeedback {
    NSString *methodName = @"UpdateFeedback";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/cloud/json/feedback/%@", @(self.feedback.feedbackId)] statusCode:200 headers:nil];

    [PPCrowdFeedbacks updateFeedback:self.feedback.feedbackId feedback:self.feedback callback:^(NSError *error) {

        XCTAssertNil(error);
        [expectation fulfill];

    }];

    [self waitForExpectations:@[expectation] timeout:10.0];
}

#pragma mark - Vote for Feedback

/**
 * Vote for feedback.
 *
 * @ param feedbackId Required PPCrowdFeedbackId Specific feedback ID to update
 * @ param rank Required PPCrowdFeedbackRank Cast a vote or remove existing vote
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testVoteForFeedback {
    NSString *methodName = @"VoteForFeedback";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/cloud/json/feedback/%@/%@", @(self.feedback.feedbackId), @(PPCrowdFeedbackRankCastVote)] statusCode:200 headers:nil];

    [PPCrowdFeedbacks voteForFeedback:self.feedback.feedbackId rank:PPCrowdFeedbackRankCastVote callback:^(NSError *error) {

        XCTAssertNil(error);
        [expectation fulfill];

    }];

    [self waitForExpectations:@[expectation] timeout:10.0];
}

#pragma mark - Request Support

/**
 * Request Support.
 * If a ticket has been created in a support cloud, then the API returns the ticket ID and the brand name.
 *
 * @ param appName NSString  App name to forward the support request
 * @ param feedbackSupport PPCrowdFeedbackSupport Feedback support object
 * @ param callback PPCrowdFeedbacksTicketBlock Feedbacks ticket block
 **/
- (void)testRequestSupport {
    NSString *methodName = @"RequestSupport";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/cloud/json/support" statusCode:200 headers:nil];

    [PPCrowdFeedbacks requestSupport:self.appName feedbackSupport:self.feedbackSupport callback:^(PPCrowdFeedbackTicket *ticket, NSError *error) {

        XCTAssertNil(error);
        [expectation fulfill];

    }];

    [self waitForExpectations:@[expectation] timeout:10.0];
}

#pragma mark - Send a Message

/**
 * Send a Message.
 *
 * @ param message Required PPInAppMessage Message to be sent
 * @ param callback PPInAppMessagingBlock In-App Message callback block containing message Id
 **/
- (void)testSendMessage {
    NSString *methodName = @"SendMessage";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/cloud/json/messages" statusCode:200 headers:nil];

    [PPInAppMessaging sendMessage:self.message callback:^(PPInAppMessageId messageId, NSError *error) {

        XCTAssertNil(error);
        [expectation fulfill];

    }];

    [self waitForExpectations:@[expectation] timeout:10.0];

}

/**
 * Receive Messages
 *
 * @ param status PPInAppMessagingStatus Messages status
 * @ param messageId PPInAppMessageId Filter messages and replies by the original message ID
 * @ param userId PPUserId User ID to get messages for, for use by administrators only
 * @ param type PPInAppMessageType This field is available for the application developer to use as needed. It is unused and undefined by the IoT Software Suite.
 * @ param challengeId PPInAppMessageChallengeId Get messages linked to this challenge.
 * @ param searchBy NSString Search by subject, text, from or recipient fields
 * @ param callback PPInAppMessagesBlock In-App Messages callback block containing array of messages
 **/
- (void)testReceiveMessages {
    NSString *methodName = @"ReceiveMessages";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/cloud/json/messages" statusCode:200 headers:nil];

    [PPInAppMessaging recieveMessages:PPInAppMessageChallengeParticipanStatusNone messageId:PPInAppMessageIdNone userId:PPUserIdNone type:PPInAppMessageTypeNone challengeId:PPInAppMessageChallengeIdNone searchBy:nil callback:^(NSArray *messages, NSError *error) {

        XCTAssertNil(error);
        [expectation fulfill];

    }];

    [self waitForExpectations:@[expectation] timeout:10.0];

}

#pragma mark - Manage a message

/**
 * Update message attributes.
 *
 * @ param messageId Required PPInAppMessageId Message Id to update
 * @ param read PPInAppMessageMessagesRead Read status to update to
 * @ param subject NSString Subject of the message
 * @ param text NSString Text of the message
 * @ param parameters NSDictrionary Parameters of the message
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testUpdateMessageAttributions {
    NSString *methodName = @"UpdateMessageAttributions";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/cloud/json/messages/%@", @(self.message.messageId)] statusCode:200 headers:nil];
    
    [PPInAppMessaging updateMessageAttributions:self.message.messageId read:PPInAppMessageMessagesReadTrue subject:nil text:nil parameters:nil callback:^(NSError *error) {

        XCTAssertNil(error);
        [expectation fulfill];

    }];

    [self waitForExpectations:@[expectation] timeout:10.0];
}

/**
 * Delete a message
 *
 * @ param messageId Required PPInAppMessageId Message Id to delete
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testDeleteMessage {
    NSString *methodName = @"DeleteMessage";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/cloud/json/messages/%@", @(self.message.messageId)] statusCode:200 headers:nil];
    
    [PPInAppMessaging deleteMessage:self.message.messageId callback:^(NSError *error) {

        XCTAssertNil(error);
        [expectation fulfill];

    }];

    [self waitForExpectations:@[expectation] timeout:10.0];
}

/**
 * Reply to a message
 * When replying to a message, the body may specify whether to also delivery the reply over email and push notification, to notify the recipient.
 *
 * @ param messageId Required PPInAppMessageId Message Id to reply to
 * @ param text Required NSString Text of the reply message
 * @ param email PPInAppMessageEmail Send a notification over email
 * @ param push PPInAppMessagePush Send a notification over push
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)testReplyToMessage {
    NSString *methodName = @"ReplyToMessage";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:[NSString stringWithFormat:@"/cloud/json/messages/%@", @(self.message.messageId)] statusCode:200 headers:nil];

    [PPInAppMessaging replyToMessage:self.message.messageId text:self.message.text email:self.message.email push:self.message.push callback:^(NSError *error) {

        XCTAssertNil(error);
        [expectation fulfill];

    }];

    [self waitForExpectations:@[expectation] timeout:10.0];
}

#pragma mark - Questions

/**
 * Get Questions.
 * Retrieve requested questions.
 * For an individual user, there should be at most one unanswered question available per day, unless the question is urgent. For public users, there can be many questions as we are using this on public surveys during a sign up process.
 *
 * @ param answerStatuses NSArray Return questions with the specific answer status. By default questions with statuses 2 and 3 are returned. Multiple values are supported.
 * @ param editable PPQuestionEditable Filter answered questions: true - return only editable answered questions, false - return only not editable answered questions, otherwise return all answered questions.
 * @ param organizationId PPOrganizationId Organization ID to filter questions by
 * @ param collectionName NSString Questions collection name filter
 * @ param generalPublic PPQuestionCollectionGeneralPublic true - return only public questions, false - return only private questions
 * @ param questionId PPQuestionId Extract a specifc question Id
 * @ param appInstanceId PPBotengineAppInstanceId Only retrieve quetsions for a specific botengine app
 * @ param lang NSString Quetsions text language. If not set, user's or default language will be used.
 * @ param limit PPQuestionsLimit Maximum number of questions to return. The default is 0 (unlimited)
 * @ param public PPQuestionsPublic If True then an organizationId must be specified to pull public questions.
 * @ param callback PPQuestionsBlock Questions callback block containing arrays of collections and questions.
 **/
- (void)testGetQuestions {
    NSString *methodName = @"GetQuestions";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/cloud/json/questions" statusCode:200 headers:nil];

    [PPQuestions getQuestions:self.location.locationId answerStatuses:self.answerStatuses editable:PPQuestionEditableNone organizationId:PPOrganizationIdNone collectionName:nil generalPublic:PPQuestionCollectionGeneralPublicNone questionId:PPQuestionIdNone appInstanceId:PPBotengineAppInstanceIdNone lang:nil limit:PPQuestionsLimitNone startDate:[NSDate dateWithTimeIntervalSince1970:0] endDate:[NSDate date] userId:PPUserIdNone callback:^(NSArray *collections, NSArray *questions, NSError *error) {

        XCTAssertNil(error);
        [expectation fulfill];

    }];

    [self waitForExpectations:@[expectation] timeout:10.0];
}

/**
 * Answer a question.
 * After answering a question, the user should see how many points they earned (if any), and if the question is aggregated publicly then the user should also see how other people voted.
 * A user can skip the question or prefer to not answer it by setting the corresponding answer status. Providing just the question ID the UI app can mark the question as notified.
 * Only editable questions can be updated later. Typically editable questions are used to configure Composer Apps and add further context to the user's data later.
 * If any points were previously rewarded for previously answering this question, then answering the question again should not result in more points. However, if no points were previously rewarded and now the user is updating the answer to one that does reward points, then the user should receive those points.
 * The user's tagged attributes should migrate with the question, such that when a new answer is selected, any previous tags are removed and new tags are applied.
 * The body and response is designed to handle answers to multiple questions simultaneously.
 *
 * @ param questions NSArray Array of answered questions
 * @ param public PPQuestionsPublic If True then the answers will not be stored but only tested, if they are valid.
 * @ param callback PPQuestionsAnswersBlock Answers callback block
 **/
- (void)testAnswerQuestions {
    NSString *methodName = @"AnswerQuestions";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/cloud/json/questions" statusCode:200 headers:nil];

    [PPQuestions answerQuestions:self.location.locationId questions:self.questions userId:PPUserIdNone callback:^(NSArray *questions, NSError *error) {

        XCTAssertNil(error);
        [expectation fulfill];

    }];

    [self waitForExpectations:@[expectation] timeout:10.0];

}

#pragma mark - SMS Group Texting
/// Discussion: Deprecated APIs

/**
 * Get SMS Subscribers
 *
 * @ param categories NSArray Communication category filter. Multiple values supported.
 * @ param userId PPUserId User ID. This parameter is used by administrator accounts to get data for the specific user's account
 * @ param callback PPSMSGroupTextingSubscribersCallback SMS Group Texting subscribers callback containing array of subscribers
 **/
- (void)_testGetSMSSubscribers {
    NSString *methodName = @"GetSMSSubscribers";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/cloud/json/smsSubscribers" statusCode:200 headers:nil];

    [PPSMSGroupTexting getSMSSubscribers:nil userId:PPUserIdNone callback:^(NSArray *subscribers, NSError *error) {

        XCTAssertNil(error);
        [expectation fulfill];

    }];

    [self waitForExpectations:@[expectation] timeout:10.0];
}

/**
 * Add / Update Subscriber
 *
 * @ param userId PPUserId User ID. This parameter is used by administrator accounts to get data for the specific user's account
 * @ param subscriber PPSMSSubscriber Subscriber object to add / update
 * @ param callback PPErrorBlock Error callback block
 **/

- (void)_testUpdateSubscriber {
    NSString *methodName = @"GetSMSSubscribers";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/cloud/json/smsSubscribers" statusCode:200 headers:nil];

    [PPSMSGroupTexting updateSubscriber:PPUserIdNone subscriber:self.smsSubscriber callback:^(NSError *error) {

        XCTAssertNil(error);

        [expectation fulfill];

    }];

    [self waitForExpectations:@[expectation] timeout:10.0];
}

/**
 * Delete Subscriber
 *
 * @ param phone NSInteger Phone number to delete
 * @ param userId PPUserId User ID. This parameter is used by administrator accounts to get data for the specific user's account
 * @ param callback PPErrorBlock Error callback block
 **/
- (void)_testDeleteSubscriber {
    NSString *methodName = @"DeleteSMSSubscribers";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/cloud/json/smsSubscribers" statusCode:200 headers:nil];

    [PPSMSGroupTexting deleteSubscriber:self.smsSubscriber.phone userId:PPUserIdNone callback:^(NSError *error) {

        XCTAssertNil(error);
        [expectation fulfill];

    }];

    [self waitForExpectations:@[expectation] timeout:10.0];
}

#pragma mark - Surveys

/**
 * Get Survey Questions
 *
 * @ param brand NSString App brand
 * @ param callback required PPSurveyQuestionsBlock Surveys callback block
 */
- (void)testGetSurveyQuestions {
    NSString *methodName = @"GetSurveyQuestions";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/cloud/json/surveys" statusCode:200 headers:nil];

    [PPSurveys getSurveyQuestions:nil callback:^(NSArray * _Nullable questions, NSError * _Nullable error) {
        
        XCTAssertNil(error);
        [expectation fulfill];

    }];

    [self waitForExpectations:@[expectation] timeout:10.0];
}

/**
 * Answer Question
 *
 * @ param questionId required PPSurveyQuestionId Survey question id
 * @ param slider required NSInteger Slider value
 * @ param answerText NSString Answer text
 * @ param callback required PPErrorBlock Error callback block
 */
- (void)testAnswerQuestion {
    NSString *methodName = @"AnswerQuestion";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/cloud/json/surveys" statusCode:200 headers:nil];

    [PPSurveys answerQuestion:self.surveyQuestion.questionId slider:1 answerText:@"Some Answer" callback:^(NSError * _Nullable error) {
        
        XCTAssertNil(error);
        [expectation fulfill];

    }];

    [self waitForExpectations:@[expectation] timeout:10.0];

}

// MARK: - Support Tickets

/**
 * Support Ticket
 * Create a support ticket.
 *
 * @ param supportTicket PPSupportTicket Required Support ticket
 * @ param userId PPUserId Request support for this user by an administrator
 * @ param callback PPErrorBlock Error callback block
 */
- (void)testSupportTicket {
    NSString *methodName = @"PostSupportTicket";
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:methodName];
    
    [self stubRequestForModule:moduleName methodName:methodName ofType:@"json" path:@"/cloud/json/ticket" statusCode:200 headers:nil];

    [PPSupportTickets postSupportTicket:self.supportTicket userId:PPUserIdNone callback:^(NSError * _Nullable error) {
        
        XCTAssertNil(error);
        [expectation fulfill];

    }];

    [self waitForExpectations:@[expectation] timeout:10.0];
}

@end
