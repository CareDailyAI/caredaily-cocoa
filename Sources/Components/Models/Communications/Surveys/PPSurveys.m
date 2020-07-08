//
//  PPSurveys.m
//  PPiOSCore
//
//  Created by Destry Teeter on 7/6/20.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPSurveys.h"
#import "PPCloudEngine.h"

@implementation PPSurveys

// MARK: - Survey Questions

/**
 * Get Survey Questions
 *
 * @param brand NSString App brand
 * @param callback PPSurveyQuestionsBlock Surveys callback block
 */
+ (void)getSurveyQuestions:(NSString * _Nullable )brand callback:(PPSurveyQuestionsBlock _Nonnull )callback {
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:@"surveys"] resolvingAgainstBaseURL:NO];
    
    NSMutableArray *queryItems = @[].mutableCopy;
    if (brand) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"brand" value:brand]];
    }
    components.queryItems = queryItems;
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.communications.surveys.getSurveyQuestions()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] GET:components.string success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            NSMutableArray *questions;
            if(!error) {
                questions = [[NSMutableArray alloc] initWithCapacity:0];
                for(NSDictionary *questionDict in [root objectForKey:@"questions"]) {
                    PPSurveyQuestion *question = [PPSurveyQuestion initWithDictionary:questionDict];
                    [questions addObject:question];
                }
            }
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(questions, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

/**
 * Answer Question
 *
 * @param questionId required PPSurveyQuestionId Survey question id
 * @param slider required NSInteger Slider value
 * @param answerText NSString Answer text
 * @param callback PPErrorBlock Error callback block
 */
+ (void)answerQuestion:(PPSurveyQuestionId)questionId slider:(NSInteger)slider answerText:(NSString * _Nullable )answerText callback:(PPErrorBlock _Nonnull )callback {
    NSAssert1(questionId != PPSurveyQuestionIdNone, @"%s missing questionId", __FUNCTION__);
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:@"surveys"] resolvingAgainstBaseURL:NO];
    
    NSMutableDictionary *data = @{
        @"id": @(questionId),
        @"slider": @(slider)
    }.mutableCopy;
    
    if (answerText != nil) {
        data[@"answerText"] = answerText;
    }
    
    NSError *dataError;
    NSData *body = [NSJSONSerialization dataWithJSONObject:@{@"question": data} options:0 error:&dataError];
    if (dataError) {
        callback([PPBaseModel resultCodeToNSError:14 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",dataError.userInfo]]);
        return;
    }
    
    NSError *error;
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAppEngine] getRequestSerializer] requestWithMethod:@"PUT" URLString:[NSURL URLWithString:components.string relativeToURL:[[PPCloudEngine sharedAppEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    [request setHTTPBody:body];
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.communications.surveys.answerQuestion()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
        
    [[PPCloudEngine sharedAppEngine] operationWithRequest:request success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
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
                callback([PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"Error domain:%@, code:%ld, userInfo:%@", error.domain, (long)error.code, error.userInfo]]);
            });
        });
    }];
}

@end
