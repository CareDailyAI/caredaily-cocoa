//
//  PPWebSocketViewer.h
//  Peoplepower
//
//  Created by Destry Teeter on 5/1/18.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPWebSocket.h"

@interface PPWebSocketViewer : PPWebSocket

- (void)sendCommandToCamera:(NSString *)command value:(NSString *)value sessionID:(BOOL)sessionID;

@end
