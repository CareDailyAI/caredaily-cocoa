//
//  PPWebSocketConfiguration.h
//  Peoplepower
//
//  Created by Destry Teeter on 5/1/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PPWebSocketConfiguration : PPBaseModel

@property (nonatomic, strong) NSString *APIServerURL;
@property (nonatomic, strong) NSString *imageServerURL;
@property (nonatomic, strong) NSString *videoServerURL;
@property (nonatomic, strong) NSString *videoServerPort;
@property (nonatomic, strong) NSString *sessionId;
@property (nonatomic) BOOL isAPIServerSSL;
@property (nonatomic) BOOL isImageServerSSL;
@property (nonatomic) BOOL isVideoServerSSL;

@end
