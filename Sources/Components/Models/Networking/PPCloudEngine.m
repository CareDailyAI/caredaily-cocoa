//
//  PPCloudEngine.m
//  Peoplepower
//
//  Copyright (c) 2023 People Power Company. All rights reserved.
//

#import "PPCloudEngine.h"
#import "PPCurlDebug.h"
#import "PPAFHTTPBridge.h"

@implementation PPCloudEngine

__strong static PPCloudEngine *_sharedDefaultObject = nil;
__strong static PPCloudEngine *_sharedAppObject = nil;
__strong static PPCloudEngine *_sharedAppWebsocketObject = nil;
__strong static PPCloudEngine *_sharedAppStrippedObject = nil;
__strong static PPCloudEngine *_sharedAdminObject = nil;
__strong static PPCloudEngine *_sharedProxyObject = nil;
__strong static PPCloudEngine *_sharedStreamingObject = nil;
__strong static PPCloudEngine *_sharedReportObject = nil;

+ (PPCloudEngine *)sharedDefaultEngine {
	if(_sharedDefaultObject == nil || [_sharedDefaultObject getBaseURL].absoluteString == nil || [[_sharedDefaultObject getBaseURL].absoluteString rangeOfString:[PPUrl appAPIServerURLString]].location == NSNotFound) {
        _sharedDefaultObject = [[self alloc] initSingleton:PPCloudEngineTypeDefault];
		return _sharedDefaultObject;
	}
	return _sharedDefaultObject;
}

+ (PPCloudEngine *)sharedAppEngine {
    if(_sharedAppObject == nil || [_sharedAppObject getBaseURL].absoluteString == nil || [[_sharedAppObject getBaseURL].absoluteString rangeOfString:[PPUrl appAPIServerURLString]].location == NSNotFound) {
        _sharedAppObject = [[self alloc] initSingleton:PPCloudEngineTypeApp];
        return _sharedAppObject;
    }
    return _sharedAppObject;
}

+ (PPCloudEngine *)sharedAppWebsocketEngine {
    if(_sharedAppWebsocketObject == nil || [_sharedAppWebsocketObject getBaseURL].absoluteString == nil || [[_sharedAppWebsocketObject getBaseURL].absoluteString rangeOfString:[PPUrl appWebsocketAPIServerURLString]].location == NSNotFound) {
        _sharedAppWebsocketObject = [[self alloc] initSingleton:PPCloudEngineTypeAppWebsocket];
        return _sharedAppWebsocketObject;
    }
    return _sharedAppWebsocketObject;
}

+ (PPCloudEngine *)sharedAppStrippedEngine {
    if(_sharedAppStrippedObject == nil || [_sharedAppStrippedObject getBaseURL].absoluteString == nil || [[_sharedAppStrippedObject getBaseURL].absoluteString rangeOfString:[PPUrl appAPIServerURLString]].location == NSNotFound) {
        _sharedAppStrippedObject = [[self alloc] initSingleton:PPCloudEngineTypeAppStripped];
        return _sharedAppStrippedObject;
    }
    return _sharedAppStrippedObject;
}

+ (PPCloudEngine *)sharedAdminEngine {
    if(_sharedAdminObject == nil || [_sharedAdminObject getBaseURL].absoluteString == nil || [[_sharedAdminObject getBaseURL].absoluteString rangeOfString:[PPUrl appAPIServerURLString]].location == NSNotFound) {
        _sharedAdminObject = [[self alloc] initSingleton:PPCloudEngineTypeAdmin];
        return _sharedAdminObject;
    }
    return _sharedAdminObject;
}

+ (PPCloudEngine *)sharedProxyEngine {
    if(_sharedProxyObject == nil || [_sharedProxyObject getBaseURL].absoluteString == nil || [[_sharedProxyObject getBaseURL].absoluteString rangeOfString:[PPUrl deviceIOServerURLString:nil]].location == NSNotFound) {
        _sharedProxyObject = [[self alloc] initSingleton:PPCloudEngineTypeProxy];
        return _sharedProxyObject;
    }
    return _sharedProxyObject;
}

+ (PPCloudEngine *)sharedStreamingEngine {
    if(_sharedStreamingObject == nil || [_sharedStreamingObject getBaseURL].absoluteString == nil || [[_sharedStreamingObject getBaseURL].absoluteString rangeOfString:[PPUrl streamingServerURLString:nil]].location == NSNotFound) {
        _sharedStreamingObject = [[self alloc] initSingleton:PPCloudEngineTypeStreaming];
        return _sharedStreamingObject;
    }
    return _sharedStreamingObject;
}

+ (PPCloudEngine *)sharedReportEngine {
    if(_sharedProxyObject == nil || [_sharedProxyObject getBaseURL].absoluteString == nil || [[_sharedProxyObject getBaseURL].absoluteString rangeOfString:[PPUrl appAPIServerURLString]].location == NSNotFound) {
        _sharedProxyObject = [[self alloc] initSingleton:PPCloudEngineTypeReport];
        return _sharedProxyObject;
    }
    return _sharedProxyObject;
}

+ (void)setSessionKey:(NSString *)sessionKey {
    [[PPCloudEngine sharedAppEngine] setValue:sessionKey forHTTPHeaderField:HTTP_HEADER_API_KEY];
    [[PPCloudEngine sharedAppStrippedEngine] setValue:sessionKey forHTTPHeaderField:HTTP_HEADER_API_KEY];
    [[PPCloudEngine sharedAdminEngine] setValue:sessionKey forHTTPHeaderField:HTTP_HEADER_API_KEY];
}

- (id)initSingleton:(PPCloudEngineType)type {
    NSString *urlString;
    switch (type) {
        case PPCloudEngineTypeApp:
            urlString = [NSString stringWithFormat:@"%@/cloud/json", [PPUrl appAPIServerURLString]];
            break;
        case PPCloudEngineTypeAppWebsocket:
            urlString = [PPUrl appWebsocketAPIServerURLString];
            break;
        case PPCloudEngineTypeAppStripped:
            urlString = [NSString stringWithFormat:@"%@/cloud", [PPUrl appAPIServerURLString]];
            break;
        case PPCloudEngineTypeAdmin:
            urlString = [NSString stringWithFormat:@"%@/admin/json", [PPUrl appAPIServerURLString]];
            break;
        case PPCloudEngineTypeProxy:
            urlString = [PPUrl deviceIOServerURLString:nil];
            break;
        case PPCloudEngineTypeStreaming:
            urlString = [PPUrl streamingServerURLString:nil];
            break;
        case PPCloudEngineTypeReport:
            urlString = [NSString stringWithFormat:@"%@/reports/json", [PPUrl appAPIServerURLString]];
            break;
        default:
            urlString = [PPUrl appAPIServerURLString];
            break;
    }
    
    self = [super initWithBaseURL:[NSURL URLWithString:urlString]];
	if(self) {
		[self setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        NSString *userAgent = [((AFHTTPSessionManager *)self.ios7Manager).requestSerializer valueForHTTPHeaderField:@"User-Agent"];
        NSRange splitRange = [userAgent rangeOfString:@"/"];
        NSString *appName = splitRange.location == NSNotFound ? userAgent : [userAgent substringToIndex:splitRange.location];
        appName = [NSString stringWithFormat:@"iOS%@", [[appName componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] componentsJoinedByString:@""]];
        NSString *version = splitRange.location == NSNotFound ? nil :[userAgent substringFromIndex:splitRange.location + 1];
        userAgent = [NSString stringWithFormat:@"%@/%@", appName, version];
        [self setValue:userAgent forHTTPHeaderField:@"User-Agent"];
	}
	
	return self;
}

#pragma mark - Encoding

- (id)copyWithZone:(NSZone *)zone {
    PPCloudEngine *cloudEngine = [[PPCloudEngine allocWithZone:zone] init];
    cloudEngine.ios7Manager = self.ios7Manager;
    return cloudEngine;
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if(self) {
        self.ios7Manager = [decoder decodeObjectForKey:@"ios7Manager"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.ios7Manager forKey:@"ios7Manager"];
}

@end
