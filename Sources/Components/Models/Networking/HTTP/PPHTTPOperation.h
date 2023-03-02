//
//  PPHTTPOperation.h
//  Peoplepower
//
//  Copyright (c) 2023 People Power Company. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PPHTTPOperation : NSObject

/**
 * iOS 7.x+ Constructor
 * @param task NSURLSessionDataTask
 */
- (id) initWithNSURLSessionTask:(NSURLSessionTask *)task;

///**
// * iOS 6.x Constructor
// * @param operation AFHTTPRequestOperation
// */
//- (id) initWithAFHTTPRequestOperation:(AFHTTPRequestOperation *)operation;


/**
 * Cancel this operation
 */
- (void)cancel;


@end
