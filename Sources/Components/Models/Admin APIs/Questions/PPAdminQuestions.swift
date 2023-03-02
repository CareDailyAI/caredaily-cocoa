//
//  PPAdminQuestions.swift
//  Peoplepower iOS
//
//  Created by Destry Teeter on 6/15/21.
//  Copyright © 2023 People Power Company. All rights reserved.
//

import Foundation

@objc open class PPAdminQuestions : NSObject {
    
    // MARK: - Questions
    /**
     Questions let us discover information about our user base, automatically tag users, drive engagement programs. Questions are the mechanism for a bi-directional conversation with the end user.Note these tables are replicated in the Composer Analytics API documentation and the Cloud API documentation.CollectionQuestions in organizations are organized by collections. Each question belongs to one or multiple question collections.
     | Name | Description | Description |
     | ---- | ---- | ---- |
     | id | integer | Collection ID |
     | name | string | A unique name for referencing this collection. |
     | descriptions | string | The titles of the group in various languages. |
     | status | integer | 0 - inactive; 1 - active |
     | generalPublic | boolean | If true, this question will be made available publicly only outside of the organization, even to users who have never signed up on our system before. This is to facilitate sign up surveys. The user's answers will get captured immediately after  | their | account | is created on the server.; If false, this question is available only for approved users inside the organization. |
     | order | integer | A number set by the admin to indicate where this question should appear relative to other questions inside a collection. The lower the order, the higher the question rises up to the top. |
     */

    // MARK: - Question
    /**
     | Name | Type | Description |
     | ---- | ---- | ---- |
     | id | integer | Question ID assigned by the system |
     | key | string | Optional unique key to identify this context of this question later |
     | creationDate | xsd | dateTime    Creation timestamp |
     | status | integer | 0 = inactive; 1 = active; 2 = replaced; 3 = deleted |
     | collections | array | A list of collections, where this question belongs to |
     | question | string | The actual text of the question to ask. |
     | placeholder | string | A placeholder for this question. |
     | aggregatePublicly | boolean | If true, the results of this question will be made publicly available at an aggregate level, so individual users can see how others voted on the question. |
     | urgent | boolean | false" - not urgent, queue it up to notify the user later based on the notification settings (in-app question, push, SMS, email, etc.); "true" - very urgent, ask the user this question right away, after the user answers any other pending urgent questions. |
     | askDate | xsd | dateTime    When the question has to be addressed to the user. If not set, the creation date will be used. |
     | front | boolean | false" - do not ask the question on the front page of the app; "true" - ask the question on the front page of the app. |
     | push | boolean | Whether to send the question as a push notification. |
     | email | boolean | Whether to send the message over email. |
     | sms | boolean | Whether to send the message over sms. |
     | editable | boolean | If the message is editable, then that means it will show up in a place in the app where the user can reconfigure the question later. This is typically used by Composer Apps to enable a UI for settings to configure the app through questions. |
     | totalResponses | integer | The total number of responses to this question |
     | responseType | integer | The type of question (see below) |
     | displayType | integer | Application-layer display type for each type of question (for example, yes/no vs. on/off switch, or a slider that shows integers vs. a slider that shows minutes:seconds) |
     | defaultAnswer | string | Pre-populated default values for question responses, or force-change the user's response. |
     | validAnswer | string | Regular expression to identify if the answer is the 'correct' answer. This can be used in conjunction with the tags attribute. |
     | answerFormat | string | Regular expression to validate answer format in UI. |
     | sliderMin | integer | Slider question minimum value |
     | sliderMax | integer | Slider question maximum value |
     | sliderInc | integer | Slider question incremental slider value |
     | sectionTitle | string | The title of a group of questions |
     | sectionId | integer | The ID of a group of questions, and the order in which to display this group |
     | questionWeight | integer | The position of a single question within a group. The higher the weight, the lower down on the list the question appears relative to other questions |
     | tags | comma | separated list    Automatically tag the user with these tags, if the answer is 'correct' based on the validAnswer attribute. |
     | recipients | array | Specific recipients (see below). If not set the question is for the entire organization. |
     */

    // MARK: - Response Types
    /**
     | ID | Name | Display Types |
     | ---- | ---- | ---- |
     | 1 | Boolean; 0 = False, 1 = True | 0 = On/Off Switch - default.; 1 = Yes/No.; 2 = Single 'Yes' button only, the question's default value is applied to the button's text. Used to trigger bot actions from the UI. |
     | 2 | Multiple choice - Single select | 0 = Radio buttons - default. A list of radio buttons. Requires the "responses" array to list the possible responses. Users can only select one response. Available for anonymous aggregated public reporting.; 1 = Drop-down list / Picker. A drop down list. Same as radio buttons, but can contain more items. |
     | 4 | Multiple choice - Multiple select | A list of checkbox options. Requires the "responses" array to list the possible responses. Users can select multiple responses. Available for anonymous aggregated public reporting. |
     | 6 | Day of the week | Day of the week input. This is similar to a Checkbox input, except the UI can optimize itself for days of the week [Sun][XXX][Tue][Wed][Thu][XXX][Sat]. |
     | 7 | Slider | 0 = Integer select - default. Slider, with a defined minimum and maximum. By default, minimum = 0 and maximum = 100.; 1 = Floating point select.; 2 = Minutes:Seconds (answer is in total seconds). |
     | 8 | Time in seconds since midnight | 0 = hours:minutes:seconds (am|pm) - default.; 1 = hours:minutes (am|pm). This accesses the native UI method of declaring a time. |
     | 9 | Date and Time in xsd:dateTime | 0 = Date and time. 1 = Date only. |
     | 10 | Text box | Open-ended question. For example, if you were to ask, "Who just walked by the camera?" |
     */

    // MARK: - Response Options
    /**
     | Name | Type | Description |
     | ---- | ---- | ---- |
     | id | integer | ID number for types of questions that feature a list of options
     | text | string | String for an option on a type of question that features a list of options
     | tags | array of strings | Automatically tag the user with these tags if they answer the question this way, only available for questions that feature options on a list.
     | total | integer | The total number of this option used to respond.
     */

    // MARK: - Recipients
    /**
     | Name | Type | Description |
     | ---- | ---- | ---- |
     | groupId | integer | Entire group ID to deliver this message to
     | userId | integer | Specific user ID to deliver this message to
     | userTag | string | Send the message to a tagged group of users
     | deviceTag | string | Send the message to users who own devices that are tagged with this tag
     */

    // MARK: - Answers
    /**
     | Name | Type | Description |
     | ---- | ---- | ---- |
     | answerStatus | integer | Answer status:; 0 - delayed, the question will be asked in the future; 1 - ready to be asked, but it is queued; 2 - available; 3 - skipped, the user is going to answer it later; 4 - answered; 5 - no answer, the user is not going to answer on it
     | answer | string | User's answer: 0 = No, 1 = Yes; ID of the radio button; Response options chosen by the user as a bitmask; Slider value; Text entered by the user.
     | notificationDate | xsd:dateTime | When the user has been notified about this question.
     | answerDate | xsd:dateTime | When the user has answered this question.
     | answerValid | boolean | Indicate if the answer is valid.
     | answerModified | boolean | Indicate if the original answer has been modified by other user.
     */

    // MARK: - Question Collections

    /**
     Set Collection
     Create a new or update an existing organization questions collection.
     */
    @available(*, deprecated, message: "Not available")
    @objc public class func setCollection(_ organizationId: PPOrganizationId,
                                          collectionId: NSNumber?,
                                          callback: @escaping ((NSNumber?, Error?) -> (Void))) {
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.questions.setCollection()")
        PPLogAPIs(#file, message: "! \(queue.label) [NOT IMPLEMENTED]")
        callback(nil, PPBaseModel.resultCode(toNSError: 29))
    }

    /**
     Get Collections
     Return all organization question collections.
     */
    @available(*, deprecated, message: "Not available")
    @objc public class func getCollections(_ organizationId: PPOrganizationId,
                                           callback: @escaping (([Dictionary<String, Any>]?, Error?) -> (Void))) {
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.questions.getCollections()")
        PPLogAPIs(#file, message: "! \(queue.label) [NOT IMPLEMENTED]")
        callback(nil, PPBaseModel.resultCode(toNSError: 29))
    }

    // MARK: - Questions

    /**
     Ask a Question
     Non-public questions should act like messaging. By default, questions are always delivered into the app. Admins can choose to also deliver the messages via push notification or email as well. When delivered over email, it would be ideal, if the recipient could answer the question directly in his or her email without leaving the email experience. Emails should have a nice template with the logo and name of the app that generated the email. It would also be ideal for those email messages to have the option to manage subscriptions on further organization questions emails.Urgency lets us decide when to ask the question. The system should marshall questions to the user in a way that does not blast them with many questions at once. The user should receive at most one non-urgent question each day from all of their apps combined. Urgent questions should be delivered immediately to the user, and usually the developer will also select push-notifications for truly urgent messages. If multiple urgent questions are asked, they should all get delivered together to the user, and take precedence over non-urgent questions.Questions can be put into the queue and manually delayed by a specific number of days. This enables engagement programs where people sign up at their own pace, and the questions are all relative to the time at which those people signed up. This enables a time-shifted engagement program.Each message instance has an ID that can later be used to manage the question.This will create a single instance of this question that is referenced by an ID, and the question itself will appear in multiple user's accounts a time when it is appropriate to present that question to each individual user.
     */
    @available(*, deprecated, message: "Not available")
    @objc public class func askAQuestion(_ organizationId: PPOrganizationId,
                                         collectionId: NSNumber?,
                                         question: PPQuestion,
                                         callback: @escaping ((Error?) -> (Void))) {
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.questions.askAQuestion()")
        PPLogAPIs(#file, message: "! \(queue.label) [NOT IMPLEMENTED]")
        callback(PPBaseModel.resultCode(toNSError: 29))
    }

    /**
     Get Questions
     Get a list of questions that we've previously asked.The total number of responses and options should only exist, if the question is of a type that permits aggregate responses.If a user ID is specified in the request, this API return only questions asked to this user.Questions that have an answer timestamp have been explicitly answered by the user. Not having a timestamp does not necessarily mean the question hasn't been answered: sometimes a user might look at a question's default answer and agree with it, and simply not update it.The "notificationDate" argument says whether or not the user was notified about this message by any means (in-app, push, email, sms). It's possible for the question to have 0 days remaining but not have notified the user yet, because there are other questions that were queued up to ask the user already.
     */
    @available(*, deprecated, message: "Not available")
    @objc public class func getQuestions(_ organizationId: PPOrganizationId,
                                         collectionId: NSNumber?,
                                         questionId: PPQuestionId,
                                         userId: PPUserId,
                                         callback: @escaping (([PPQuestion]?, Error?) -> (Void))) {
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.questions.getQuestions()")
        PPLogAPIs(#file, message: "! \(queue.label) [NOT IMPLEMENTED]")
        callback(nil, PPBaseModel.resultCode(toNSError: 29))
    }

    /**
     Update a Question
     The list of fields to be updated to be confirmed.The attributes can be updated for the question as a whole: 'editable', 'aggregatePublicly'.
     */
    @available(*, deprecated, message: "Not available")
    @objc public class func updateAQuestion(_ organizationId: PPOrganizationId,
                                            question: PPQuestion,
                                            callback: @escaping ((Error?) -> (Void))) {
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.questions.updateAQuestion()")
        PPLogAPIs(#file, message: "! \(queue.label) [NOT IMPLEMENTED]")
        callback(PPBaseModel.resultCode(toNSError: 29))
    }

    /**
     Delete a Question
     Delete a specific question instance, for all users.
     */
    @available(*, deprecated, message: "Not available")
    @objc public class func deleteAQuestion(_ organizationId: PPOrganizationId,
                                            questionId: PPQuestionId,
                                            callback: @escaping ((Error?) -> (Void))) {
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.questions.deleteAQuestion()")
        PPLogAPIs(#file, message: "! \(queue.label) [NOT IMPLEMENTED]")
        callback(PPBaseModel.resultCode(toNSError: 29))
    }

    // MARK: - Questions Answer
    
    /**
     Update Answer
     */
    @available(*, deprecated, message: "Not available")
    @objc public class func updateAnswer(_ organizationId: PPOrganizationId,
                                         questionId: PPQuestionId,
                                         userId: PPUserId,
                                         callback: @escaping ((NSNumber?, Error?) -> (Void))) {
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.questions.updateAnswer()")
        PPLogAPIs(#file, message: "! \(queue.label) [NOT IMPLEMENTED]")
        callback(nil, PPBaseModel.resultCode(toNSError: 29))
    }

    // MARK: - Manage Collection Questions

    /**
     Add Question to Collection
     Add a question to an existing collection or update the existing question order.Each organization question must belongs to at least one collection to be available for end users. If a question is included to one non-public collection, it is counted as non-public as well and will be available for approved organization users.
     */
    @available(*, deprecated, message: "Not available")
    @objc public class func addQuestionToCollection(_ organizationId: PPOrganizationId,
                                                    collectionId: Int,
                                                    questionId: PPQuestionId,
                                                    order: NSNumber?,
                                                    callback: @escaping ((Error?) -> (Void))) {
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.questions.addQuestionToCollection()")
        PPLogAPIs(#file, message: "! \(queue.label) [NOT IMPLEMENTED]")
        callback(PPBaseModel.resultCode(toNSError: 29))
    }

    /**
     Delete Question from Collection
     Delete a question from a collection.Removing a question from all collections will make it unavailable for all users.
     */
    @available(*, deprecated, message: "Not available")
    @objc public class func deleteQuestionFromCollection(_ organizationId: PPOrganizationId,
                                                         collectionId: Int,
                                                         questionId: PPQuestionId,
                                                         callback: @escaping ((Error?) -> (Void))) {
        let queue = DispatchQueue(label: "com.peoplepowerco.lib.Peoplepower.admin.questions.deleteQuestionFromCollection()")
        PPLogAPIs(#file, message: "! \(queue.label) [NOT IMPLEMENTED]")
        callback(PPBaseModel.resultCode(toNSError: 29))
    }
    
}
