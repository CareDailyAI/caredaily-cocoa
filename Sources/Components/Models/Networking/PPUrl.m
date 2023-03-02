//
//  PPUrl.m
//  Peoplepower
//
//  Copyright (c) 2023 People Power Company. All rights reserved.
//

#import "PPUrl.h"
#import "PPTimezone.h"

@implementation PPUrl

#pragma mark - Cloud Configuration

+ (PPCloudConnectivityCloud *)defaultCloud {
    NSDictionary *cloudDict = (NSDictionary *)[PPAppResources getPlistEntry:PP_PLIST_KEY_CONFIG_CLOUD filename:PP_PLIST_FILE_CONFIG];
    return [PPCloudConnectivityCloud initWithDictionary:cloudDict];
}

/**
 * Set custom cloud.
 * Defines custom cloud.  If no cloud is provided, then current setting will be removed and default cloud will be used.
 *
 * @param cloud PPCloudConnectivityCloud Cloud object with server definitions to be stored as user default.
 */
+ (void) setCustomCloud:(PPCloudConnectivityCloud *)cloud {
#ifdef DEBUG
    NSLog(@"%s cloud=%@", __PRETTY_FUNCTION__, cloud);
#endif
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if(cloud) {
            NSData *cloudData = [NSKeyedArchiver archivedDataWithRootObject:cloud];
        [defaults setObject:cloudData forKey:@"cloud"];
    }
    else {
        [defaults removeObjectForKey:@"cloud"];
    }
    [defaults synchronize];
}

/**
 * Set custom server.
 * Defines custom cloud server.
 *
 * @param server Required PPCloudConnectivityServer Server object to be stored as user default.
 */
+ (void)setCustomServer:(PPCloudConnectivityServer *)server {
    if(!server) {
#ifdef DEBUG
        NSLog(@"%s No server provided, ignore", __PRETTY_FUNCTION__);
#endif
        return;
    }
    PPCloudConnectivityCloud *cloud = [PPUrl getCustomCloud];
    NSInteger replacementIndex = NSNotFound;
    for(PPCloudConnectivityServer *existingServer in cloud.servers) {
        if([existingServer.type isEqualToString:server.type] && (server.brand == nil || [existingServer.brand isEqualToString:server.brand])) {
            replacementIndex = [cloud.servers indexOfObject:existingServer];
            break;
        }
    }
    
    if(replacementIndex != NSNotFound) {
        NSMutableArray *servers = [[NSMutableArray alloc] initWithArray:cloud.servers];
        [servers replaceObjectAtIndex:replacementIndex withObject:server];
        cloud.servers = servers;
        [PPUrl setCustomCloud:cloud];
    }
}

/**
 * @return the custom server address, or the default address if the custom address doesn't exist
 */
+ (PPCloudConnectivityCloud *)getCustomCloud {
    PPCloudConnectivityCloud *cloud = [self defaultCloud];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *cloudData = [defaults objectForKey:@"cloud"];
    if(cloudData) {
        cloud = (PPCloudConnectivityCloud *)[NSKeyedUnarchiver unarchiveObjectWithData:cloudData];
    }
    
    return cloud;
}

/**
 * @return YES if we should use a custom server address
 */
+ (BOOL) shouldUseCustomCloud {
    NSData *cloud = [[NSUserDefaults standardUserDefaults] objectForKey:@"cloud"];
    
    return (cloud != nil);
}

+ (NSString *)serverName:(BOOL)devicesServer {
    PPCloudConnectivityCloud *defaultCloud = [PPUrl defaultCloud];
	if([PPUrl shouldUseCustomCloud]) {
		defaultCloud = [self getCustomCloud];
	}
    
    return defaultCloud.name;
}


#pragma mark - Servers

+ (NSString *)appAPIServerURLString {
    PPCloudConnectivityServer *server;
    for(PPCloudConnectivityServer *defaultServer in [PPUrl getCustomCloud].servers) {
        if([defaultServer.type isEqualToString:CLOUD_CONNECTIVITY_SERVER_TYPE_APP_API]) {
            server = defaultServer;
            break;
        }
    }
    
    NSString *serverURLString = [server URLString];
    
    return serverURLString;
}

+ (NSString *)appWebsocketAPIServerURLString {
    PPCloudConnectivityServer *server;
    for(PPCloudConnectivityServer *defaultServer in [PPUrl getCustomCloud].servers) {
        if([defaultServer.type isEqualToString:CLOUD_CONNECTIVITY_SERVER_TYPE_WS_API]) {
            server = defaultServer;
            break;
        }
    }
    
    NSString *serverURLString = [server URLString];
    
    return serverURLString;
}

+ (NSString *)webappServerURLString {
    PPCloudConnectivityServer *webAppServer;
    for(PPCloudConnectivityServer *server in [self getCustomCloud].servers) {
        if([server.type isEqualToString:CLOUD_CONNECTIVITY_SERVER_TYPE_WEB_APP]) {
            webAppServer = server;
            break;
        }
    }
    
    return [webAppServer URLString];
}

+ (NSString *)streamingServerURLString:(PPCloudConnectivityServer *)server {
    if(!server) {
        for(PPCloudConnectivityServer *defaultServer in [PPUrl getCustomCloud].servers) {
            if([defaultServer.type isEqualToString:CLOUD_CONNECTIVITY_SERVER_TYPE_STREAMING]) {
                server = defaultServer;
                break;
            }
        }
    }
    
    NSString *serverURLString = [server URLString];
    
    return serverURLString;
}

+ (NSString *)deviceIOServerURLString:(PPCloudConnectivityServer *)server {
    if(!server) {
        for(PPCloudConnectivityServer *defaultServer in [PPUrl getCustomCloud].servers) {
            if([defaultServer.type isEqualToString:CLOUD_CONNECTIVITY_SERVER_TYPE_DEVICE_IO]) {
                server = defaultServer;
                break;
            }
        }
    }
    
    NSString *serverURLString = [NSString stringWithFormat:@"%@/mljson", [server URLString]];
    
    return serverURLString;
}

#pragma mark - Webapp endpoints

+ (NSString *)feedbackURL {
    return [NSString stringWithFormat:@"%@/settings/feature.html", [PPUrl webappServerURLString]];
}

+ (NSString *)problemURL {
    return [NSString stringWithFormat:@"%@/settings/problem.html", [PPUrl webappServerURLString]];
}

+ (NSString *)FAQURL {
    return [NSString stringWithFormat:@"%@/settings/faq.html", [PPUrl webappServerURLString]];
}

+ (NSString *)termsURL {
    return [NSString stringWithFormat:@"%@/settings/terms.html", [PPUrl webappServerURLString]];
}

+ (NSString *)privacyURL {
    return [NSString stringWithFormat:@"%@/settings/privacy.html", [PPUrl webappServerURLString]];
}

+ (NSString *)emergencyServerURL {
    return @"http://www.peoplepowerco.com";
}

+ (NSString *)supportUrl {
    return [NSString stringWithFormat:@"https://peoplepowerco.zendesk.com/hc/%@", [PPUrl languageCode]];
}

#pragma mark - Webapp Language

+ (NSString *)languageCode {
    return NSLocalizedStringWithDefaultValue(@"language.code", nil, [PPBaseModel bundle], @"en", @"Language Code: 'en', 'zh', etc...");
}

#pragma mark - Developer Server

+ (void) setDeveloperServer:(BOOL)useDeveloper {
	[[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d", useDeveloper] forKey:@"useDeveloper"];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL) shouldUseDeveloperServer {
    return [@"1" isEqualToString:[[NSUserDefaults standardUserDefaults] stringForKey:@"useDeveloper"]];
}

#pragma mark - Webapp version

/**
 * @param customVersion NSString version of the web app server to connect to.  Leave blank to select the pre-loaded default version
 */
+ (void) setCustomWebappVersion:(NSString *)customVersion {
#ifdef DEBUG
    NSLog(@"%s version=%@", __PRETTY_FUNCTION__, customVersion);
#endif
    if(customVersion == nil) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"customWebappVersion"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else {
        [[NSUserDefaults standardUserDefaults] setObject:customVersion forKey:@"customWebappVersion"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

/**
 * @return the webapp version
 */
+ (NSString *)webappVersion {
    NSString *version = [[NSUserDefaults standardUserDefaults] stringForKey:@"customWebappVersion"];
    
    if(!version || [version isEqualToString:@""]) {
        return [NSString stringWithFormat:@"%i", HTTP_DEFAULT_WEBVIEW_VERSION];
    }
    
    return version;
}

#pragma mark - Streaming File URLs

+ (NSURL *)streamingURLWithTempkey:(NSString *)tempKey withID:(NSString *)ID{
	return [NSURL URLWithString:[NSString stringWithFormat:@"%@/cloud/json/files/%@/%@",[PPUrl appAPIServerURLString],tempKey,ID]];
}

+ (NSURL *)keylessStreamingURL:(NSInteger)fileId {
	return [NSURL URLWithString:[NSString stringWithFormat:@"%@/cloud/json/files/%ld",[PPUrl appAPIServerURLString], (long)fileId]];
}

@end
