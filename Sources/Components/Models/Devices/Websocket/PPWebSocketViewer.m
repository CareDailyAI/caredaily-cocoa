//
//  PPWebSocketViewer.m
//  Peoplepower
//
//  Created by Destry Teeter on 5/1/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPWebSocketViewer.h"

@implementation PPWebSocketViewer

- (void)sendCommandToCamera:(NSString *)command value:(NSString *)value sessionID:(BOOL)sessionID {
    NSString *requestJson = nil;
    
    // Pass JSON-Request as String value because server does not accept JSON in binary data.
    
    if(command == nil && value == nil && sessionID) {
        requestJson = [NSString stringWithFormat:@"{\"sessionId\":\"%@\",\"params\":[],\"requestAllParams\":true}",self.sessionId];
    }
    else {
        if(sessionID) {
            if([command isEqualToString:@"recordStream"]) {
                NSString *recordFormatString = @"";
                if([value isEqualToString:@"1"]) {
                    recordFormatString = @",{\"name\":\"recordFormat\",\"value\":\"0\",\"forward\":1}";
                }
                requestJson = [NSString stringWithFormat:@"{\"sessionId\":\"%@\",\"params\":[{\"name\":\"%@\",\"value\":\"%@\",\"forward\":1}%@]}",self.sessionId, command, value, recordFormatString];
            }
            else {
                requestJson = [NSString stringWithFormat:@"{\"sessionId\":\"%@\",\"params\":[{\"name\":\"%@\",\"setValue\":\"%@\"}]}",self.sessionId, command, value];
            }
        }
        else {
            requestJson = [NSString stringWithFormat:@"{\"params\":[{\"name\":\"%@\",\"setValue\":\"%@\"}]}", command, value];
        }
    }
    
#ifdef DEBUG
    NSLog(@"JSON Command: %@", requestJson);
#endif
    
    if (self.webSocket.readyState == SR_OPEN) {
        [self.webSocket send:requestJson];
    }
}

@end
