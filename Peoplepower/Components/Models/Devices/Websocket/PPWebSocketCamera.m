//
//  PPWebSocketCamera.m
//  Peoplepower
//
//  Created by Destry Teeter on 5/1/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPWebSocketCamera.h"

@implementation PPWebSocketCamera

- (void)sendMeasurementToViewer:(NSString *)command value:(NSString *)value sessionID:(BOOL)sessionID {
    NSString *requestJson = nil;
    
    // Pass JSON-Request as String value because server does not accept JSON in binary data.
    
    if(sessionID) {
        requestJson = [NSString stringWithFormat:@"{\"sessionId\":\"%@\",\"params\":[{\"name\":\"%@\",\"value\":\"%@\"}]}", self.sessionId, command, value];
    } else {
        requestJson = [NSString stringWithFormat:@"{\"params\":[{\"name\":\"%@\",\"value\":\"%@\"}]}", command, value];
    }
    
    if (self.webSocket.readyState == SR_OPEN) {
        [self.webSocket send:requestJson];
    }
}


- (void)requestTotalViewers {
#ifdef DEBUG
    NSLog(@"%s", __PRETTY_FUNCTION__);
#endif
    NSString *requestJson = nil;
    
    // Pass JSON-Request as String value because server does not accept JSON in binary data.
    requestJson = [NSString stringWithFormat:@"{\"sessionId\":\"%@\",\"requestViewers\":\"true\"}", self.sessionId];
    
    if (self.webSocket.readyState == SR_OPEN) {
        [self.webSocket send:requestJson];
    }
}

@end
