//
//  PPAFHTTPBridge.m
//  Peoplepower
//
//  Copyright (c) 2023 People Power Company. All rights reserved.
//

#import "PPAFHTTPBridge.h"
#import "PPCurlDebug.h"

//#import "PPAFHTTPRequestOperationManager.h"
#import "PPAFHTTPSessionManager.h"

@interface PPAFHTTPBridge ()
@end

@implementation PPAFHTTPBridge


/**
 * Constructor
 * @param baseURL Base URL
 */
- (id) initWithBaseURL:(NSURL *)baseURL {
	self = [super init];
	if(self ) {
        self.ios7Manager = [[PPAFHTTPSessionManager alloc] initWithBaseURL:baseURL];
        _ios7Manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _ios7Manager.securityPolicy.allowInvalidCertificates = YES;
        _ios7Manager.securityPolicy.validatesDomainName = NO;
	}
	return self;
}

/**
 * Update the cloud engine headers
 *
 * @param sessionKey NSString Set HTTP_HEADER_API_KEY with session key
 */
- (void)setSessionKey:(NSString *)sessionKey {
    [self setValue:sessionKey forHTTPHeaderField:HTTP_HEADER_API_KEY];
}

/**
 * Update completeion queue
 *
 * @param queue dispatch_queue_t Completion queue
 */
- (void)setCompleteionQueue:(dispatch_queue_t)queue {
    [_ios7Manager setCompletionQueue:queue];
}

/**
 * @return the response serializer
 */
- (AFHTTPResponseSerializer <AFURLResponseSerialization> *)getResponseSerializer {
	if(_ios7Manager) {
		return _ios7Manager.responseSerializer;
		
	}
	else {
//        return _ios6Manager.responseSerializer;
        return nil;
	}
}

/**
 * @return the request serializer
 */
- (AFHTTPRequestSerializer <AFURLRequestSerialization> *)getRequestSerializer {
	if(_ios7Manager) {
		return _ios7Manager.requestSerializer;
		
	}
	else {
//        return _ios6Manager.requestSerializer;
        return nil;
	}
}

/**
 * Set the response serializer
 * @param responseSerializer Response Serializer
 */
- (void)setResponseSerializer:(AFHTTPResponseSerializer <AFURLResponseSerialization> *)responseSerializer {
	if(_ios7Manager) {
		_ios7Manager.responseSerializer = responseSerializer;
		
	}
	else {
//        _ios6Manager.responseSerializer = responseSerializer;
	}
}

/**
 * Set the request serializer
 * @param requestSerializer Request Serializer
 */
- (void)setRequestSerializer:(AFHTTPRequestSerializer <AFURLRequestSerialization> *)requestSerializer {
	if(_ios7Manager) {
		_ios7Manager.requestSerializer = requestSerializer;
		
	}
	else {
//        _ios6Manager.requestSerializer = requestSerializer;
	}
}

/**
 * Set the default value for the default HTTP Header field
 * Case-sensitive.  nil to erase it.
 * @param value Value
 * @param field Field
 */
- (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field {
	if(_ios7Manager) {
		[_ios7Manager.requestSerializer setValue:value forHTTPHeaderField:field];
		
	}
	else {
//        [_ios6Manager.requestSerializer setValue:value forHTTPHeaderField:field];
	}
}

/**
 * @return the base URL
 */
- (NSURL *)getBaseURL {
	if(_ios7Manager) {
		return _ios7Manager.baseURL;
	}
	else {
//        return _ios6Manager.baseURL;
        return nil;
	}
}

/**
 * Perform an operation that uploads data to the server
 */
- (PPHTTPOperation *)operationWithRequest:(NSURLRequest *)request
								  success:(void (^)(NSData *responseData))success
								  failure:(void (^)(NSError *error))failure {
	if(_ios7Manager) {
		NSURLSessionTask *task = [_ios7Manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
			if(error && error.code != NSURLErrorCancelled) {
				failure(error);
			}
			else {
				success(responseObject);
			}
		}];
		
		[task resume];
		
		return [[PPHTTPOperation alloc] initWithNSURLSessionTask:task];
	}
	else {
//        AFHTTPRequestOperation *operation = [_ios6Manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            success(operation.responseData);
//
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            failure(error);
//        }];
//
//        [operation start];
//
//        return [[PPHTTPOperation alloc] initWithAFHTTPRequestOperation:operation];
        return nil;
	}
}

/**
 * Perform an operation that uploads data to the server
 */
- (PPHTTPOperation *)operationWithRequestIncludingResponse:(NSURLRequest *)request
                                  success:(void (^)(NSData *responseData, NSObject *response))success
                                  failure:(void (^)(NSError *error))failure {
    if(_ios7Manager) {
        NSURLSessionDataTask *task = [_ios7Manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
            if(error && error.code != NSURLErrorCancelled) {
                failure(error);
            }
            else {
                success(responseObject, response);
            }
        }];
        
        [task resume];
        
        return [[PPHTTPOperation alloc] initWithNSURLSessionTask:task];
    }
    else {
//        AFHTTPRequestOperation *operation = [_ios6Manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            success(operation.responseData, operation.response);
//
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            failure(error);
//        }];
//
//        [operation start];
//
//        return [[PPHTTPOperation alloc] initWithAFHTTPRequestOperation:operation];
        return nil;
    }
}

/**
 * Perform an operation that uploads or downloads data to the server.
 * Include progress block for upload/downlod.
 # Includes response object.
 */
- (PPHTTPOperation *)operationWithRequest:(NSURLRequest *)request
                            progressBlock:(void (^)(NSProgress *progress))progressBlock
                                  success:(void (^)(NSData *responseData, NSObject *response))success
                                  failure:(void (^)(NSError *error))failure {
    if(_ios7Manager) {
        NSURLSessionTask *task;
        
        if([request.HTTPMethod isEqualToString:@"PUT"] || [request.HTTPMethod isEqualToString:@"POST"]) {
            task = (NSURLSessionTask *)[_ios7Manager uploadTaskWithStreamedRequest:request progress:^(NSProgress * _Nonnull uploadProgress) {
                progressBlock(uploadProgress);
            } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                if(error && error.code != NSURLErrorCancelled) {
                    failure(error);
                }
                else {
                    success(responseObject, response);
                }
            }];
        }
        else if([request.HTTPMethod isEqualToString:@"GET"]) {
            task = (NSURLSessionTask *)[_ios7Manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
                progressBlock(downloadProgress);
            } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
                NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
                return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
            } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
                if(error && error.code != NSURLErrorCancelled) {
                    failure(error);
                }
                else {
                    success([NSData dataWithContentsOfURL:filePath], response);
                }
            }];
        }
        else {
            task = (NSURLSessionTask *)[_ios7Manager dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
                progressBlock(uploadProgress);
            } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
                progressBlock(downloadProgress);
            } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                if(error && error.code != NSURLErrorCancelled) {
                    failure(error);
                }
                else {
                    success(responseObject, response);
                }
            }];
        }
        
        [task resume];
        
        return [[PPHTTPOperation alloc] initWithNSURLSessionTask:task];
    }
    else {
//        AFHTTPRequestOperation *operation = [_ios6Manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            success(operation.responseData);
//
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            failure(error);
//        }];
//
//        if([request.HTTPMethod isEqualToString:@"PUT"] || [request.HTTPMethod isEqualToString:@"POST"]) {
//            [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
//                progressBlock(bytesWritten, totalBytesWritten, totalBytesExpectedToWrite);
//            }];
//        }
//        else if([request.HTTPMethod isEqualToString:@"GET"]) {
//            [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
//                progressBlock(bytesRead, totalBytesRead, totalBytesExpectedToRead);
//            }];
//        }
//
//        [operation start];
//
//        return [[PPHTTPOperation alloc] initWithAFHTTPRequestOperation:operation];
        return nil;
    }
}

/**
 * GET
 * @param URLString The full URL
 * @param success Success block
 * @param failure Failuer block
 */
- (PPHTTPOperation *)GET:(NSString *)URLString
				 success:(void (^)(NSData *responseData))success
				 failure:(void (^)(NSError *error))failure {
	if(_ios7Manager) {
        NSURLSessionDataTask *task = [_ios7Manager GET:URLString parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            success(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if(error.code == NSURLErrorCancelled) {
                success(nil);
            }
            else {
                failure(error);
            }
		}];
		
		return [[PPHTTPOperation alloc] initWithNSURLSessionTask:task];
		
	}
	else {
//        AFHTTPRequestOperation *operation = [_ios6Manager GET:URLString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            success(operation.responseData);
//
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            if(error.code == NSURLErrorCancelled) {
//                success(nil);
//            }
//            else {
//                failure(error);
//            }
//
//        }];
//
//        return [[PPHTTPOperation alloc] initWithAFHTTPRequestOperation:operation];
		return nil;
	}
}


/**
 * POST
 * @param URLString The full URL
 * @param success Success block
 * @param failure Failure blokc
 */
- (PPHTTPOperation *)POST:(NSString *)URLString
				  success:(void (^)(NSData *responseData))success
				  failure:(void (^)(NSError *error))failure {
	if(_ios7Manager) {
        NSURLSessionDataTask *task = [_ios7Manager POST:URLString parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            success(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if(error.code == NSURLErrorCancelled) {
                success(nil);
            }
            else {
                failure(error);
            }
			
		}];
		
		return [[PPHTTPOperation alloc] initWithNSURLSessionTask:task];
		
	}
	else {
//        AFHTTPRequestOperation *operation = [_ios6Manager POST:URLString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            success(operation.responseData);
//
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            if(error.code == NSURLErrorCancelled) {
//                success(nil);
//            }
//            else {
//                failure(error);
//            }
//
//        }];
//
//        return [[PPHTTPOperation alloc] initWithAFHTTPRequestOperation:operation];
		return nil;
	}
}


/**
 * PUT
 * @param URLString The full URL
 * @param success Success block
 * @param failure Failure block
 */
- (PPHTTPOperation *)PUT:(NSString *)URLString
				 success:(void (^)(NSData *responseData))success
				 failure:(void (^)(NSError *error))failure {
	if(_ios7Manager) {
        NSURLSessionDataTask *task = [_ios7Manager PUT:URLString parameters:nil headers:nil success:^(NSURLSessionDataTask *task, id responseObject) {
			success(responseObject);
			
		} failure:^(NSURLSessionDataTask *task, NSError *error) {
            if(error.code == NSURLErrorCancelled) {
                success(nil);
            }
            else {
                failure(error);
            }
			
		}];
		
		return [[PPHTTPOperation alloc] initWithNSURLSessionTask:task];
		
	}
	else {
//        AFHTTPRequestOperation *operation = [_ios6Manager PUT:URLString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            success(operation.responseData);
//
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            failure(error);
//
//        }];
//
//        return [[PPHTTPOperation alloc] initWithAFHTTPRequestOperation:operation];
        return nil;
	}
}


/**
 * DELETE
 * @param URLString The full URL
 * @param success Success block
 * @param failure Failure block
 */
- (PPHTTPOperation *)DELETE:(NSString *)URLString
					success:(void (^)(NSData *responseData))success
					failure:(void (^)(NSError *error))failure {
	if(_ios7Manager) {
        NSURLSessionDataTask *task = [_ios7Manager DELETE:URLString parameters:nil headers:nil success:^(NSURLSessionDataTask *task, id responseObject) {
			success(responseObject);
			
		} failure:^(NSURLSessionDataTask *task, NSError *error) {
            if(error.code == NSURLErrorCancelled) {
                success(nil);
            }
            else {
                failure(error);
            }
			
		}];
		
		return [[PPHTTPOperation alloc] initWithNSURLSessionTask:task];
		
	}
	else {
//        AFHTTPRequestOperation *operation = [_ios6Manager DELETE:URLString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            success(operation.responseData);
//
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            failure(error);
//
//        }];
//
//        return [[PPHTTPOperation alloc] initWithAFHTTPRequestOperation:operation];
		return nil;
	}
}


- (void)cancelAllOperations {
    if(_ios7Manager) {
        for(NSURLSessionDataTask *task in [_ios7Manager tasks]) {
            [task cancel];
        }
    }
//    if(_ios6Manager) {
//        // What to do...
//    }
}

#pragma mark - Encoding

- (id)copyWithZone:(NSZone *)zone {
    PPAFHTTPBridge *bridge = [[[self class] allocWithZone:zone] init];
    bridge.ios7Manager = _ios7Manager;
    return bridge;
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if(self) {
        self.ios7Manager = [decoder decodeObjectForKey:@"ios7Manager"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_ios7Manager forKey:@"ios7Manager"];
}

@end
