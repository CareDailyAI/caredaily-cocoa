//
//  PPHTTPOperation.m
//  Peoplepower
//
//  Copyright (c) 2023 People Power Company. All rights reserved.
//

#import "PPHTTPOperation.h"

@interface PPHTTPOperation ()
@property (nonatomic, strong) NSURLSessionTask *task;
//@property (nonatomic, strong) AFHTTPRequestOperation *operation;
@end

@implementation PPHTTPOperation

- (id) initWithNSURLSessionTask:(NSURLSessionTask *)task {
	self = [super init];
	if(self) {
		self.task = task;
//        self.operation = nil;
	}
	return self;
}

//- (id) initWithAFHTTPRequestOperation:(AFHTTPRequestOperation *)operation {
//    self = [super init];
//    if(self) {
//        self.operation = operation;
//        self.task = nil;
//    }
//    return self;
//}

- (void)cancel {
	if(_task) {
		[_task cancel];
	}
	else {
//        [_operation cancel];
	}
}


@end
