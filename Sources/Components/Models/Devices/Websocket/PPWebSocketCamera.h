//
//  PPWebSocketCamera.h
//  Peoplepower
//
//  Created by Destry Teeter on 5/1/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPWebSocket.h"

@interface PPWebSocketCamera : PPWebSocket

- (void)sendMeasurementToViewer:(NSString *)command value:(NSString *)value sessionID:(BOOL)sessionID;
- (void)requestTotalViewers;

@end
