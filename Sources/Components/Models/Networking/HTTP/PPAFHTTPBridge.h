//
//  PPAFHTTPBridge.h
//  Peoplepower
//
//  Copyright (c) 2020 People Power. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PPHTTPOperation.h"

@class PPAFHTTPSessionManager;
//@class PPAFHTTPRequestOperationManager;

extern NSString *HTTP_HEADER_API_KEY;
extern NSString *HTTP_HEADER_CIRCLE_KEY;
extern NSString *HTTP_HEADER_PASSWORD;
extern NSString *HTTP_HEADER_PASSCODE;
extern NSString *HTTP_HEADER_AUTHORIZATION;
extern NSString *HTTP_HEADER_PPC_AUTHORIZATION;
extern NSString *HTTP_HEADER_CONTENT_TYPE;
extern NSString *HTTP_HEADER_RANGE;
extern NSString *HTTP_HEADER_CONTENT_RANGE;
extern NSString *HTTP_HEADER_ACCEPT_RANGES;
extern NSString *HTTP_HEADER_CONTENT_DISPOSITION;
extern NSString *HTTP_HEADER_CONTENT_LENGTH;

@interface PPAFHTTPBridge : NSObject <NSCopying>

@property (nonatomic, strong) PPAFHTTPSessionManager *ios7Manager;
//@property (nonatomic, strong) PPAFHTTPRequestOperationManager *ios6Manager;

/**
 * Constructor
 * @param baseURL NSURL Base url
 */
- (id) initWithBaseURL:(NSURL *)baseURL;

/**
 * Update the cloud engine headers
 *
 * @param sessionKey NSString Set HTTP_HEADER_API_KEY with session key
 */
- (void)setSessionKey:(NSString *)sessionKey;

/**
 * Update completeion queue
 *
 * @param queue dispatch_queue_t Completion queue
 */
- (void)setCompleteionQueue:(dispatch_queue_t)queue;

/**
 * @return the response serializer
 */
- (AFHTTPResponseSerializer <AFURLResponseSerialization> *)getResponseSerializer;

/**
 * @return the request serializer
 */
- (AFHTTPRequestSerializer <AFURLRequestSerialization> *)getRequestSerializer;

/**
 * Set the response serializer
 * @param responseSerializer AFHTTPResponseSerializer <AFURLResponseSerialization>
 */
- (void)setResponseSerializer:(AFHTTPResponseSerializer <AFURLResponseSerialization> *)responseSerializer;

/**
 * Set the request serializer
 * @param requestSerializer AFHTTPResponseSerializer <AFURLResponseSerialization>
 */
- (void)setRequestSerializer:(AFHTTPRequestSerializer <AFURLRequestSerialization> *)requestSerializer;

/**
 * @return the base URL
 */
- (NSURL *)getBaseURL;

/**
 * Set the default value for the default HTTP Header field
 * Case-sensitive.  nil to erase it.
 * @param value NSString
 * @param field NSString
 */
- (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field;


/**
 * Perform an operation that uploads data to the server
 */
- (PPHTTPOperation *)operationWithRequest:(NSURLRequest *)request
													success:(void (^)(NSData *responseData))success
													failure:(void (^)(NSError *error))failure;

/**
 * Perform an operation that uploads data to the server.  Includes response object.
 */
- (PPHTTPOperation *)operationWithRequestIncludingResponse:(NSURLRequest *)request
                                  success:(void (^)(NSData *responseData, NSObject *response))success
                                  failure:(void (^)(NSError *error))failure;

/**
 * Perform an operation that uploads or downloads data to the server.
 * Include progress block for upload/downlod.
 * Includes response object.
 */
- (PPHTTPOperation *)operationWithRequest:(NSURLRequest *)request
                            progressBlock:(void (^)(NSProgress *progress))progressBlock
                                  success:(void (^)(NSData *responseData, NSObject *response))success
                                  failure:(void (^)(NSError *error))failure;

/**
 * GET
 * @param URLString NSString the full URL
 * @param success (void (^)(NSData *responseData))
 * @param failure (void (^)(NSError *error))
 */
- (PPHTTPOperation *)GET:(NSString *)URLString
						success:(void (^)(NSData *responseData))success
						failure:(void (^)(NSError *error))failure;


/**
 * POST
 * @param URLString NSString the full URL
 * @param success (void (^)(NSData *responseData))
 * @param failure (void (^)(NSError *error))
 */
- (PPHTTPOperation *)POST:(NSString *)URLString
						 success:(void (^)(NSData *responseData))success
						 failure:(void (^)(NSError *error))failure;


/**
 * PUT
 * @param URLString NSString the full URL
 * @param success (void (^)(NSData *responseData))
 * @param failure (void (^)(NSError *error))
 */
- (PPHTTPOperation *)PUT:(NSString *)URLString
						success:(void (^)(NSData *responseData))success
						failure:(void (^)(NSError *error))failure;


/**
 * DELETE
 * @param URLString NSString the full URL
 * @param success (void (^)(NSData *responseData))
 * @param failure (void (^)(NSError *error))
 */
- (PPHTTPOperation *)DELETE:(NSString *)URLString
						   success:(void (^)(NSData *responseData))success
						   failure:(void (^)(NSError *error))failure;

- (void)cancelAllOperations;
@end
