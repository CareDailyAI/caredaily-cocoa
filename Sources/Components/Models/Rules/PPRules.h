//
//  PPRules.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/8/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//
// People Power designed, from the ground up, a natural language rules engine for the IoT Software Suite to intuitively orchestrate devices across multiple manufacturers and vendors. Rules take on the form "If This Then That", and can expand to many AND's or OR's: "If This and this and this and this, then that and that and that and that".
// Complete sentences are formed to define a valid rule. Each sentence consists of phrases of the following types:
//      - Triggers - A trigger is a type of condition that will trigger the evaluation of the rest of the rule. Triggers represent a single moment in time. Each valid rule must have exactly one trigger. For example: "the light turned on" / "the light turned off"
//      - States - A state is a type of condition that must be met for the rule to execute. A rule may define zero or more states. We typically AND states together for user simplicity, but the IoT Software Suite also supports OR statements. For example, "the light is on" / "the light is off".
//      - Actions - An action is what takes place if the trigger executes while all the state conditions are met. A valid rule must have at least one action. For example, "make the light turn on" / "make the light turn off".
// Rules may notify the user of an event over email or text message. When the notification is sent to the user, the IoT Software Suite rules engine helps transform the natural language phrase into past-tense. For example, if a user has defined a rule: "If my 'Living Room Camera' detects motion and I am away, then notify me on my phone", then the user will receive the past-tense notification, "Your 'Living Room Camera' detected motion while you were away!". These notifications may be customized by the client app.
// The IoT Software Suite developers may define default rules for products and device types under their control. Rules may also be hidden, to give the device some automated default capabilities when the device is added to the user's account without allowing the user to delete this automated functionality. For example, a manufacturer may create a hidden rule to automatically alert the user when the device's battery is running low, "If my 'Door Sensor' is running low on battery, then notify me on my phone and notify me by email.".
//
// Phrases
// The API will return type and display attributes for each phrase. The app or client is only concerned about the contents of display, which describes how to render this phrase for the user. The type attribute is used by the IoT Software Suite itself, and rarely used by the client.
//
// Parameters
// Phrases are sometimes constructed with additional parameters to specify the phrase. When numeric user input is required, a parameter type field describes how to present the data.
//
// Cron Expressions
// This tutorial is copied from the Quartz Scheduler Documentation
//
// Introduction
// "cron" is a UNIX tool that has been around for a long time, so its scheduling capabilities are powerful and proven. The CronTrigger class is based on the scheduling capabilities of cron.
// CronTrigger uses "cron expressions", which are able to create firing schedules such as: "At 8:00am every Monday through Friday" or "At 1:30am every last Friday of the month".
// Cron expressions are powerful, but can be pretty confusing. This tutorial aims to take some of the mystery out of creating a cron expression, giving users a resource which they can visit before having to ask in a forum or mailing list.
//
// Format
// A cron expression is a string comprised of 6 or 7 fields separated by white space. Fields can contain any of the allowed values, along with various combinations of the allowed special characters for that field. The fields are as follows:
//      Field           Mandatory   Allowed             Allow Special
//      Name                        Values              Characters
//      Seconds         YES         0-59                , - * /
//      Minutes         YES         0-59                , - * /
//      Hours           YES         0-23                , - * /
//      Day of month    YES         1-31                , - * ? / L W
//      Month           YES         1-12 or JAN-DEC     , - * /
//      Day of week     YES         1-7 or SUN-SAT      , - * ? / L #
//      Year            NO          empty, 1970-2099    , - * /
//
// So cron expressions can be as simple as this: * * * * ? * or more complex, like this: 0/5 14,18,3-39,52 * ? JAN,MAR,SEP MON-FRI 2002-2010
//
// Special Characters
//
// "*" ("all values") - used to select all values within a field.
//      For example, "" in the minute field means *"every minute".
//
// "?" ("no specific value") - useful when you need to specify something in one of the two fields in which the character is allowed, but not the other.
//      For example, if I want my trigger to fire on a particular day of the month (say, the 10th), but don't care what day of the week that happens to be, I would put "10" in the day-of-month field, and "?" in the day-of-week field. See the examples below for clarification.
//
// "-" - used to specify ranges.
//      For example, "10-12" in the hour field means "the hours 10, 11 and 12".
//
// "," - used to specify additional values.
//      For example, "MON,WED,FRI" in the day-of-week field means "the days Monday, Wednesday, and Friday".
//
// "/" - used to specify increments.
//      For example, "0/15" in the seconds field means "the seconds 0, 15, 30, and 45". And "5/15" in the seconds field means "the seconds 5, 20, 35, and 50".
//      You can also specify '/' after the '' character - in this case '' is equivalent to having '0' before the '/'. '1/3' in the day-of-month field means "fire every 3 days starting on the first day of the month".
//
// "L" ("last") - has different meaning in each of the two fields in which it is allowed.
//      For example, the value "L" in the day-of-month field means "the last day of the month" - day 31 for January, day 28 for February on non-leap years. If used in the day-of-week field by itself, it simply means "7" or "SAT".
//      But if used in the day-of-week field after another value, it means "the last xxx day of the month" - for example "6L" means "the last Friday of the month".
//      You can also specify an offset from the last day of the month, such as "L-3" which would mean the third-to-last day of the calendar month.
//      When using the 'L' option, it is important not to specify lists, or ranges of values, as you'll get confusing/unexpected results.
//
// "W" ("weekday") - used to specify the weekday (Monday-Friday) nearest the given day.
//      As an example, if you were to specify "15W" as the value for the day-of-month field, the meaning is: "the nearest weekday to the 15th of the month".
//      So if the 15th is a Saturday, the trigger will fire on Friday the 14th.
//      If the 15th is a Sunday, the trigger will fire on Monday the 16th. If the 15th is a Tuesday, then it will fire on Tuesday the 15th.
//      However if you specify "1W" as the value for day-of-month, and the 1st is a Saturday, the trigger will fire on Monday the 3rd, as it will not 'jump' over the boundary of a month's days.
//      The 'W' character can only be specified when the day-of-month is a single day, not a range or list of days.
//      NOTE: The 'L' and 'W' characters can also be combined in the day-of-month field to yield 'LW', which translates to *"last weekday of the month"*.
//
// "#" - used to specify "the nth" XXX day of the month.
//      For example, the value of "6#3" in the day-of-week field means "the third Friday of the month" (day 6 = Friday and "#3" = the 3rd one in the month).
//      Other examples: "2#1" = the first Monday of the month and "4#5" = the fifth Wednesday of the month.
//      Note that if you specify "#5" and there is not 5 of the given day-of-week in the month, then no firing will occur that month.
//      NOTE: The legal characters and the names of months and days of the week are not case sensitive. MON is the same as mon.
//
// Examples
// Here are some full examples:
//      Expression              	Meaning
//      0 0 12 * * ?                Fire at 12pm (noon) every day
//      0 15 10 ? * *               Fire at 10:15am every day
//      0 15 10 * * ?               Fire at 10:15am every day
//      0 15 10 * * ? *             Fire at 10:15am every day
//      0 15 10 * * ? 2005          Fire at 10:15am every day during the year 2005
//      0 * 14 * * ?                Fire every minute starting at 2pm and ending at 2:59pm, every day
//      0 0/5 14 * * ?              Fire every 5 minutes starting at 2pm and ending at 2:55pm, every day
//      0 0/5 14,18 * * ?           Fire every 5 minutes starting at 2pm and ending at 2:55pm, AND fire every 5 minutes starting at 6pm and ending at 6:55pm, every day
//      0 0-5 14 * * ?              Fire every minute starting at 2pm and ending at 2:05pm, every day
//      0 10,44 14 ? 3 WED          Fire at 2:10pm and at 2:44pm every Wednesday in the month of March.
//      0 15 10 ? * MON-FRI         Fire at 10:15am every Monday, Tuesday, Wednesday, Thursday and Friday
//      0 15 10 15 * ?              Fire at 10:15am on the 15th day of every month
//      0 15 10 L * ?               Fire at 10:15am on the last day of every month
//      0 15 10 L-2 * ?             Fire at 10:15am on the 2nd-to-last last day of every month
//      0 15 10 ? * 6L              Fire at 10:15am on the last Friday of every month
//      0 15 10 ? * 6L              Fire at 10:15am on the last Friday of every month
//      0 15 10 ? * 6L 2002-2005    Fire at 10:15am on every last Friday of every month during the years 2002, 2003, 2004 and 2005
//      0 15 10 ? * 6#3             Fire at 10:15am on the third Friday of every month
//      0 0 12 1/5 * ?              Fire at 12pm (noon) every 5 days every month, starting on the first day of the month.
//      0 11 11 11 11 ?             Fire every November 11th at 11:11am.
//
// Pay attention to the effects of '?' and '*' in the day-of-week and day-of-month fields!
//
// Notes:
//      - Support for specifying both a day-of-week and a day-of-month value is not complete (you must currently use the '?' character in one of these fields).
//      - Be careful when setting fire times between the hours of the morning when "daylight savings" changes occur in your locale (for US locales, this would typically be the hour before and after 2:00 AM - because the time shift can cause a skip or a repeat depending on whether the time moves back or jumps forward.
//      - You may find this wikipedia entry helpful in determining the specifics to your locale: https://secure.wikimedia.org/wikipedia/en/wiki/Daylight_saving_time_around_the_world
//

#import "PPBaseModel.h"
#import "PPRule.h"

@interface PPRules : PPBaseModel

#pragma mark - Session Management

#pragma mark Rules

/**
 * Shared rules across the entire application
 */
+ (NSArray *)sharedRulesForUser:(PPUserId)userId;

/**
 * Add rules.
 * add rules to local reference.
 *
 * @param rules NSArray Array of rules to add.
 * @param userId Required PPUserId User Id to associate these rules with
 **/
+ (void)addRules:(NSArray *)rules userId:(PPUserId)userId;

/**
 * Remove rules.
 * Remove rules from local reference.
 *
 * @param rules NSArray Array of rules to remove.
 * @param userId Required PPUserId User Id to associate these rules with
 **/
+ (void)removeRules:(NSArray *)rules userId:(PPUserId)userId;

#pragma mark Rule Components

/**
 * Shared rule components across the entire application
 */
+ (NSArray *)sharedRuleComponentsForUser:(PPUserId)userId;

/**
 * Add rule components.
 * add rule components to local reference.
 *
 * @param ruleComponents NSArray Array of rule components to add.
 * @param userId Required PPUserId User Id to associate these rules with
 **/
+ (void)addRuleComponents:(NSArray *)ruleComponents userId:(PPUserId)userId;

/**
 * Remove rule components.
 * Remove rule components from local reference.
 *
 * @param ruleComponents NSArray Array of rule components to remove.
 * @param userId Required PPUserId User Id to associate these rules with
 **/
+ (void)removeRuleComponents:(NSArray *)ruleComponents userId:(PPUserId)userId;

#pragma mark - Get Rule Phrases

/** Get Rule Phrases.
 *
 * @param locationId Required PPLocationId Location ID
 * @param version PPRulesVersion Rules implementation version
 * @param userId PPUserId User ID used by an administrator to access the specific user's account data
 * @param callback PPRulesComponentsBlock Components callback block containing lists of triggers, states, and actions
 **/
+ (void)getRuleComponents:(PPLocationId)locationId version:(PPRulesVersion)version userId:(PPUserId)userId callback:(PPRulesComponentsBlock _Nonnull )callback;
+ (void)getRuleComponents:(PPRulesVersion)version userId:(PPUserId)userId callback:(PPRulesComponentsBlock _Nonnull )callback __attribute__((deprecated));

#pragma mark - Manage Rules

/**
 * Create a Rule.
 * When creating a rule, specify a single trigger, one or more states, and one or more actions, by referencing the ID's of the triggers / states / actions that are available to the user through the GET API.
 * States are OR'd together by default, unless wrapped in an AND block. This is to provide flexibility to the developer to implement, but we recommend only defining states inside AND blocks to keep the UI simple to understand.
 * If a trigger / state / action requires a parameter, the parameter must be filled out completely.
 * It is possible to save a rule that is not complete. The IoT Software Suite will not execute partial rules.
 *
 * @param locationId Required PPLocationId Location ID
 * @param userId PPUserId User ID used by an administrator to access the specific user's account data
 * @param rule PPRule Rule to save
 * @param callback PPRulesCreationBlock Creation block containing rule reference (ID only)
 **/
+ (void)createRule:(PPLocationId)locationId userId:(PPUserId)userId rule:(PPRule * _Nonnull )rule callback:(PPRulesCreationBlock _Nonnull )callback;
+ (void)createRule:(PPUserId)userId rule:(PPRule * _Nonnull )rule callback:(PPRulesCreationBlock _Nonnull )callback __attribute__((deprecated));

/**
 * Get Rules.
 * This API will allow you to filter the list of rules by device ID as well.
 *
 * @param locationId Required PPLocationId Location ID
 * @param deviceId NSString Only return rules for the given deviceId
 * @param details PPRulesDetails Return rule details
 * @param userId PPUserId User ID used by an administrator to access the specific user's account data
 * @param callback PPRulesListBlock Rules callback block containing list of rules
 **/
+ (void)getRules:(PPLocationId)locationId deviceId:(NSString * _Nullable )deviceId details:(PPRulesDetails)details userId:(PPUserId)userId callback:(PPRulesListBlock _Nonnull )callback;
+ (void)getRules:(NSString * _Nullable )deviceId details:(PPRulesDetails)details userId:(PPUserId)userId callback:(PPRulesListBlock _Nonnull )callback __attribute__((deprecated));

/**
 * Delete Rules by Criteria.
 * Delete all rules matching to selection criteria.
 *
 * @param locationId Required PPLocationId Location ID
 * @param ruleIds NSArray Rule IDs to delete.
 * @param status PPRuleStatus Rules status
 * @param deviceTypes NSArray Delete rules containing devices of these types.
 * @param deviceIds NSArray Delete rules containing these devices.
 * @param defaultRule PPRuleDefault If set, delete only default or non-default rules.
 * @param hidden PPRuleHidden If set, delete only hidden or non-hidden rules.
 * @param userId PPUserId User ID used by an administrator to access the specific user's account data
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)deleteRulesByCriteria:(PPLocationId)locationId ruleIds:(NSArray * _Nullable )ruleIds status:(PPRuleStatus)status deviceTypes:(NSArray * _Nullable )deviceTypes deviceIds:(NSArray * _Nullable )deviceIds defaultRule:(PPRuleDefault)defaultRule hidden:(PPRuleHidden)hidden userId:(PPUserId)userId callback:(PPErrorBlock _Nonnull )callback;
+ (void)deleteRulesByCriteria:(NSArray * _Nullable )ruleIds status:(PPRuleStatus)status deviceTypes:(NSArray * _Nullable )deviceTypes deviceIds:(NSArray * _Nullable )deviceIds default:(PPRuleDefault)defaultRule hidden:(PPRuleHidden)hidden userId:(PPUserId)userId callback:(PPErrorBlock _Nonnull )callback __attribute__((deprecated));

#pragma mark - Manage a specific Rule

/**
 * Get a Rule
 *
 * @param ruleId Required PPRuleId Rule ID to obtain
 * @param locationId Required PPLocationId Location ID
 * @param details PPRulesDetails Return rule details
 * @param userId PPUserId User ID used by an administrator to access the speicific user's account data
 * @param callback PPRulesListBlock Rule callback block containing list of rules
 **/
+ (void)getRule:(PPRuleId)ruleId locationId:(PPLocationId)locationId details:(PPRulesDetails)details userId:(PPUserId)userId callback:(PPRulesListBlock _Nonnull )callback;
+ (void)getRule:(PPRuleId)ruleId details:(PPRulesDetails)details userId:(PPUserId)userId callback:(PPRulesListBlock _Nonnull )callback __attribute__((deprecated));

/**
 * Update a Rule
 *
 * @param rule Required PPRule Rule to update
 * @param locationId Required PPLocationId Location ID
 * @param userId PPUserId User ID used by an administrator to access the speicific user's account data
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)updateRule:(PPRule * _Nonnull )rule locationId:(PPLocationId)locationId userId:(PPUserId)userId callback:(PPErrorBlock _Nonnull )callback;
+ (void)updateRule:(PPRule * _Nonnull )rule userId:(PPUserId)userId callback:(PPErrorBlock _Nonnull )callback __attribute__((deprecated));

/**
 * Delete a Rule
 *
 * @param ruleId Required PPRuleId Rule ID to delete
 * @param locationId Required PPLocationId Location ID
 * @param userId PPUserId User ID used by an administrator to access the speicific user's account data
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)deleteRule:(PPRuleId)ruleId locationId:(PPLocationId)locationId userId:(PPUserId)userId callback:(PPErrorBlock _Nonnull )callback;
+ (void)deleteRule:(PPRuleId)ruleId userId:(PPUserId)userId callback:(PPErrorBlock _Nonnull )callback __attribute__((deprecated));

#pragma mark - Update a Rule Attribute

/**
 * Update a Rule Attribute.
 * Update the second name or status of the rule.
 *
 * @param ruleId Required PPRuleId Rule ID to update
 * @param locationId Required PPLocationId Location ID
 * @param status PPRuleStatus Rule's status
 * @param name NSString Rule's name
 * @param userId PPUserId User ID used by an administrator to access the speicific user's account data
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)updateRuleAttribute:(PPRuleId)ruleId locationId:(PPLocationId)locationId status:(PPRuleStatus)status name:(NSString * _Nullable )name userId:(PPUserId)userId callback:(PPErrorBlock _Nonnull )callback;
+ (void)updateRuleAttribute:(PPRuleId)ruleId status:(PPRuleStatus)status name:(NSString * _Nullable )name userId:(PPUserId)userId callback:(PPErrorBlock _Nonnull )callback __attribute__((deprecated));

#pragma mark - Update Rules Status

/**
 * Update a Rule Status.
 * Update status of all rules matching to selection criteria. The API returns ID's of updated rules.
 *
 * @param status Required PPRuleStatus New rules status
 * @param locationId Required PPLocationId Location ID
 * @param ruleIds NSArray Rule IDs to update.
 * @param deviceTypes NSArray Update rules containing devices of these types.
 * @param deviceIds NSArray Update rules containing these devices.
 * @param defaultRule PPRuleDefault If set, update only default or non-default rules.
 * @param hidden PPRuleHidden If set, update only hidden or non-hidden rules.
 * @param userId PPUserId User ID used by an administrator to access the specific user's account data
 * @param callback PPRulesStatusBlock Status block containing list of effected rule Ids
 **/
+ (void)updateRuleStatus:(PPRuleStatus)status locationId:(PPLocationId)locationId ruleIds:(NSArray * _Nullable )ruleIds deviceTypes:(NSArray * _Nullable )deviceTypes deviceIds:(NSArray * _Nullable )deviceIds defaultRule:(PPRuleDefault)defaultRule hidden:(PPRuleHidden)hidden userId:(PPUserId)userId callback:(PPRulesStatusBlock _Nonnull )callback;
+ (void)updateRuleStatus:(PPRuleStatus)status ruleIds:(NSArray * _Nullable )ruleIds deviceTypes:(NSArray * _Nullable )deviceTypes deviceIds:(NSArray * _Nullable )deviceIds defaultRule:(PPRuleDefault)defaultRule hidden:(PPRuleHidden)hidden userId:(PPUserId)userId callback:(PPRulesStatusBlock _Nonnull )callback __attribute__((deprecated));

#pragma mark - Create default rules for a device

/**
 * Create default rules for a device.
 * Creates all the default rules, if they do not already exist, for an individual device or for all of the user's devices.
 *
 * @param locationId Required PPLocationId Location ID
 * @param deviceId NSArray Specific device ID to create default rules for
 * @param userId PPUserId User ID used by an administrator to access the specific user's account data
 * @param callback PPErrorBlock Error callback block
 **/
+ (void)createDefaultRulesForDevice:(PPLocationId)locationId deviceId:(NSString * _Nullable )deviceId userId:(PPUserId)userId callback:(PPErrorBlock _Nonnull )callback;
+ (void)createDefaultRulesForDevice:(NSString * _Nullable )deviceId userId:(PPUserId)userId callback:(PPErrorBlock _Nonnull )callback __attribute__((deprecated));

@end
