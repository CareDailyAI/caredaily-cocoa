//
//  PPBaseModel.m
//  Peoplepower
//
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPCurlDebug.h"

PPBasicBlock _loginBlock;

static NSString *kTrackingKey = @"com.peoplepowerco.lib.Peoplepower.trackingDisabled";

@implementation PPBaseModel

+ (void)disableTracking:(BOOL)disabled {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:disabled forKey:kTrackingKey];
    [userDefaults synchronize];
}

+ (NSString *)appName:(BOOL)apiFriendly {
    
    NSString *appName = (NSString *)[PPAppResources getPlistEntry:PP_PLIST_KEY_CONFIG_APP_NAME filename:PP_PLIST_FILE_CONFIG];
    if(!appName || !apiFriendly) {
        appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
    }
    
    return appName;
}

+ (NSString *)brandName {
    
    NSString *brand = (NSString *)[PPAppResources getPlistEntry:PP_PLIST_KEY_CONFIG_BRAND filename:PP_PLIST_FILE_CONFIG];
    if(!brand) {
        brand = @"default";
    }
    return brand;
}

+ (NSString *)urlScheme {
    if([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleURLTypes"]) {
        NSArray *urlTypes = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleURLTypes"];
        for(NSDictionary *urlType in urlTypes) {
            if(urlType[@"CFBundleURLName"]) {
                if([urlType[@"CFBundleURLName"] isEqualToString:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]]) {
                    if(urlType[@"CFBundleURLSchemes"]) {
                        NSArray *urlSchemes = urlType[@"CFBundleURLSchemes"];
                        return [urlSchemes firstObject];
                    }
                }
            }
        }
    }
    return [PPBaseModel appName:NO];
}

+ (NSString *)pilotFallbackAppName:(BOOL)apiFriendly {
    
    NSString *appName = (NSString *)[PPAppResources getPlistEntry:PP_PLIST_KEY_CONFIG_PILOT_FALLBACK_APP_NAME filename:PP_PLIST_FILE_CONFIG];
    if(!appName || !apiFriendly) {
        appName = [PPBaseModel appName:apiFriendly];
    }
    
    return appName;
}

+ (NSString *)pilotFallbackBrandName {
    NSString *brand = (NSString *)[PPAppResources getPlistEntry:PP_PLIST_KEY_CONFIG_PILOT_FALLBACK_BRAND filename:PP_PLIST_FILE_CONFIG];
    if(!brand) {
        brand = [PPBaseModel brandName];
    }
    return brand;
}


+ (void)setLoginNeededBlock:(PPBasicBlock)loginBlock {
	_loginBlock = [loginBlock copy];
}

+ (void)throwLoginBlock {
    if(_loginBlock) {
        _loginBlock();
    }
}

+ (NSError *)resultCodeToNSError:(NSInteger)resultCode {
    return [PPBaseModel resultCodeToNSError:resultCode originatingClass:nil argument:nil];
}

+ (NSError *)resultCodeToNSError:(NSInteger)resultCode argument:(NSString *)argument {
    return [PPBaseModel resultCodeToNSError:resultCode originatingClass:nil argument:argument];
}

+ (NSError *)resultCodeToNSError:(NSInteger)resultCode originatingClass:(NSString *)originatingClass{
    return [PPBaseModel resultCodeToNSError:resultCode originatingClass:originatingClass argument:nil];
}

+ (NSError *)resultCodeToNSError:(NSInteger)resultCode originatingClass:(NSString *)originatingClass argument:(NSString *)argument {
	NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
    
    // Explicitly prevent tracking of some errors
    BOOL track = ![[NSUserDefaults standardUserDefaults] boolForKey:kTrackingKey];
    
	switch(resultCode) {
		case 0:
			return nil;
		case 1: // Internal Error
            [errorDetail setValue:[NSString stringWithFormat:NSLocalizedStringFromTableInBundle(@"The %@ app had trouble connecting. Is your internet connection ok?", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - The {App Name} app had trouble connecting. Is your internet connection ok?"), [PPBaseModel appName:NO]] forKey:NSLocalizedDescriptionKey];
			break;
		case 2: // Wrong API Key
			[errorDetail setValue:NSLocalizedStringFromTableInBundle(@"You are no longer signed in", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - You are no longer signed in") forKey:NSLocalizedDescriptionKey];
			break;
		case 3:
			[errorDetail setValue:NSLocalizedStringFromTableInBundle(@"Wrong location ID or location is not related to the user", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Wrong location ID or location is not related to the user") forKey:NSLocalizedDescriptionKey];
			break;
		case 4: // Wrong device ID or device has not been found
			[errorDetail setValue:NSLocalizedStringFromTableInBundle(@"That device is no longer in your account", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - That device is no longer in your account") forKey:NSLocalizedDescriptionKey];
			break;
		case 5: // Device proxy (gateway) has not been found
			[errorDetail setValue:NSLocalizedStringFromTableInBundle(@"Device command proxy (gateway) has not been found", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Device command proxy (gateway) has not been found") forKey:NSLocalizedDescriptionKey];
			break;
		case 6: // Object not found
			[errorDetail setValue:NSLocalizedStringFromTableInBundle(@"That type of product isn't supported on this server.", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - That type of product isn't supported on this server.") forKey:NSLocalizedDescriptionKey];
			break;
		case 7: // Access denied
			[errorDetail setValue:NSLocalizedStringFromTableInBundle(@"Access denied", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Access denied") forKey:NSLocalizedDescriptionKey];
			break;
		case 8: // Wrong parameter value
			[errorDetail setValue:NSLocalizedStringFromTableInBundle(@"Oops, you typed in something wrong there", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Oops, you typed in something wrong there") forKey:NSLocalizedDescriptionKey];
			break;
		case 9: // Missed mandatory parameter value
			[errorDetail setValue:NSLocalizedStringFromTableInBundle(@"Please fill in all required fields", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Please fill in all required fields") forKey:NSLocalizedDescriptionKey];
			break;
		case 10: // No available device resources to complete operation
			[errorDetail setValue:NSLocalizedStringFromTableInBundle(@"No available device resources to complete operation", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - No available device resources to complete operation") forKey:NSLocalizedDescriptionKey];
			break;
		case 11: // Not enough free files space
			[errorDetail setValue:NSLocalizedStringFromTableInBundle(@"The username or password you entered is incorrect", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - The username or password you entered is incorrect") forKey:NSLocalizedDescriptionKey];
			break;
		case 12: // Invalid username or wrong password
			[errorDetail setValue:NSLocalizedStringFromTableInBundle(@"The username or password you entered is incorrect", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - The username or password you entered is incorrect") forKey:NSLocalizedDescriptionKey];
			break;
		case 13:
			[errorDetail setValue:NSLocalizedStringFromTableInBundle(@"Wrong index value", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Wrong index value") forKey:NSLocalizedDescriptionKey];
			break;
		case 14: // Error in parsing of input data
			[errorDetail setValue: NSLocalizedStringFromTableInBundle(@"Error in parsing of input data", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Error in parsing of input data") forKey:NSLocalizedDescriptionKey];
			break;
		case 15: // Missing required paid service for this operation
			[errorDetail setValue:NSLocalizedStringFromTableInBundle(@"Wrong consumer ID", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Wrong consumer ID") forKey:NSLocalizedDescriptionKey];
			break;
		case 16: // User account is locked out
            track = NO;
			[errorDetail setValue:NSLocalizedStringFromTableInBundle(@"Account locked", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Account locked") forKey:NSLocalizedDescriptionKey];
			break;
		case 17: // A passcode, which has been sent to the user, is required to sign in
			[errorDetail setValue:NSLocalizedStringFromTableInBundle(@"Wrong activation key", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Wrong activation key") forKey:NSLocalizedDescriptionKey];
			break;
		case 18: // Wrong rule schedule format
			[errorDetail setValue:NSLocalizedStringFromTableInBundle(@"Wrong rule schedule format", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Wrong rule schedule format") forKey:NSLocalizedDescriptionKey];
			break;
		case 19: // Operation is temporary locked
            [errorDetail setValue:NSLocalizedStringFromTableInBundle(@"This action is temporarily locked", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - This action is temporarily locked") forKey:NSLocalizedDescriptionKey];
            if(argument != nil && ![argument isEqualToString:@""]) {
                [errorDetail setValue:argument forKey:NSLocalizedRecoverySuggestionErrorKey];
            }
			break;
		case 20: // Duplicate user name
			[errorDetail setValue:NSLocalizedStringFromTableInBundle(@"Duplicate user name", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Duplicate user name") forKey:NSLocalizedDescriptionKey];
			break;
		case 21: // Device is offline or disconnected
			[errorDetail setValue:NSLocalizedStringFromTableInBundle(@"Device is offline or disconnected", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Device is offline or disconnected") forKey:NSLocalizedDescriptionKey];
			break;
		case 22: // Device is under different location
			[errorDetail setValue:NSLocalizedStringFromTableInBundle(@"That device belongs to someone else", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - That device belongs to someone else") forKey:NSLocalizedDescriptionKey];
			break;
		case 23: // Rule generation error
			[errorDetail setValue:NSLocalizedStringFromTableInBundle(@"Well that's strange, we had a problem saving that rule. Sorry about this!\n\nIf you have time, please contact support and describe the rule you were trying to create so we can fix it.", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Well that's strange, we had a problem saving that rule. Sorry about this!\n\nIf you have time, please contact support and describe the rule you were trying to create so we can fix it.") forKey:NSLocalizedDescriptionKey];
			break;
		case 24:
			[errorDetail setValue:NSLocalizedStringFromTableInBundle(@"Wrong device registration code", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Wrong device registration code") forKey:NSLocalizedDescriptionKey];
			break;
		case 25: // Child object found
			[errorDetail setValue:NSLocalizedStringFromTableInBundle(@"Number of pending device types for this user is more than allowed", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Number of pending device types for this user is more than allowed") forKey:NSLocalizedDescriptionKey];
			break;
		case 26: // Duplicate entity or property
			[errorDetail setValue:NSLocalizedStringFromTableInBundle(@"Duplicate entity or property", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Duplicate entity or property") forKey:NSLocalizedDescriptionKey];
			break;
		case 27: // Server is busy or overloaded and cannot complete the request in reasonable time
			[errorDetail setValue:NSLocalizedStringFromTableInBundle(@"Timeout in device communication", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Timeout in device communication") forKey:NSLocalizedDescriptionKey];
			break;
		case 28:
			[errorDetail setValue:NSLocalizedStringFromTableInBundle(@"Device is not linked to any location", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Device is not linked to any location") forKey:NSLocalizedDescriptionKey];
			break;
        case 29: // Requested API method not found
            [errorDetail setValue:NSLocalizedStringFromTableInBundle(@"Requested API method not found", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Requested API method not found") forKey:NSLocalizedDescriptionKey];
            break;
        case 30: // Service is temporary unavailable
            [errorDetail setValue:NSLocalizedStringFromTableInBundle(@"Service is temporarily unavailable", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Service is temporarily unavailable") forKey:NSLocalizedDescriptionKey];
            break;
        case 31: // Unknown OAuth client
            [errorDetail setValue:NSLocalizedStringFromTableInBundle(@"Unknown OAuth client", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Unknown OAuth client") forKey:NSLocalizedDescriptionKey];
            break;
        case 32: // External application error response
            [errorDetail setValue:NSLocalizedStringFromTableInBundle(@"External application error response", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - External application error response") forKey:NSLocalizedDescriptionKey];
            break;
        case 33: // Wrong operation token
            [errorDetail setValue:NSLocalizedStringFromTableInBundle(@"Wrong operation token", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Wrong operation token") forKey:NSLocalizedDescriptionKey];
            break;
        case 34: // Cannot modify external resources
            [errorDetail setValue:NSLocalizedStringFromTableInBundle(@"Cannot modify external resources", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Cannot modify external resources") forKey:NSLocalizedDescriptionKey];
            break;
        case 35: // Wrong phone number
            [errorDetail setValue:NSLocalizedStringFromTableInBundle(@"Wrong phone number", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Wrong phone number") forKey:NSLocalizedDescriptionKey];
            break;
        case 36: // Operation canceled
            [errorDetail setValue:NSLocalizedStringFromTableInBundle(@"Operation canceled", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Operation canceled") forKey:NSLocalizedDescriptionKey];
            break;
        case 37: // Cannot authorize user on external resource or cloud
            [errorDetail setValue:NSLocalizedStringFromTableInBundle(@"Cannot authorize user on external resource or cloud", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - 37") forKey:NSLocalizedDescriptionKey];
            break;
        case 38: // Requested resource is not available
            [errorDetail setValue:NSLocalizedStringFromTableInBundle(@"Maximum reached", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Maximum reached") forKey:NSLocalizedDescriptionKey];
            if(argument != nil && ![argument isEqualToString:@""]) {
                [errorDetail setValue:argument forKey:NSLocalizedRecoverySuggestionErrorKey];
            }
            break;
        case 39: // Device not found on external cloud
            [errorDetail setValue:NSLocalizedStringFromTableInBundle(@"Device not found on external cloud", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - 39") forKey:NSLocalizedDescriptionKey];
            break;
        case 40: // Request not allowed in the current state of the resource
            [errorDetail setValue:NSLocalizedStringFromTableInBundle(@"Request not allowed in the current state of the resource", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - 40") forKey:NSLocalizedDescriptionKey];
            break;
        case 41: // Request has not been completed. It is not an error, just nothing to do.
            [errorDetail setValue:NSLocalizedStringFromTableInBundle(@"Request has not been completed. It is not an error, just nothing to do.", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - 41") forKey:NSLocalizedDescriptionKey];
            break;
        case 42: // Cannot connect to an external resource
            [errorDetail setValue:NSLocalizedStringFromTableInBundle(@"Cannot connect to an external resource", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - 42") forKey:NSLocalizedDescriptionKey];
            break;
        case 43:
            break;
        case 44: // Too often API calls
            [errorDetail setValue:NSLocalizedStringFromTableInBundle(@"Too often API calls", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - 44") forKey:NSLocalizedDescriptionKey];
            break;
        case 45: // The communication channel is not authenticated
            [errorDetail setValue:NSLocalizedStringFromTableInBundle(@"The communication channel is not authenticated", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - 45") forKey:NSLocalizedDescriptionKey];
            break;
        
		case 10000:
			[errorDetail setValue:NSLocalizedStringFromTableInBundle(@"Having trouble connecting. If you're not viewing your camera from somewhere else, please try connecting again.", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Having trouble connecting. If you're not viewing your camera from somewhere else, please try connecting again.") forKey:NSLocalizedDescriptionKey];
			break;
		case 10001:
			[errorDetail setValue:NSLocalizedStringFromTableInBundle(@"This camera is currently not available. Make sure it is up and running remotely.", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - This camera is currently not available. Make sure it is up and running remotely.") forKey:NSLocalizedDescriptionKey];
			break;
		case 10002:
			[errorDetail setValue:NSLocalizedStringFromTableInBundle(@"There was an error creating the camera, please try again later.", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - There was an error creating the camera, please try again later.") forKey:NSLocalizedDescriptionKey];
			break;
        case -1009:
            // kCFErrorDomainCFNetwork
            // Not connected to the internet
            // fallthrough
		case 10003:
            [errorDetail setValue:[NSString stringWithFormat:NSLocalizedStringFromTableInBundle(@"The %@ app had trouble connecting. Is your internet connection ok?", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - The {App Name} app had trouble connecting. Is your internet connection ok?"), [PPBaseModel appName:NO]] forKey:NSLocalizedDescriptionKey];
			break;
		case 10004:
			[errorDetail setValue:NSLocalizedStringFromTableInBundle(@"Lost the connection with the camera. Is your camera's WiFi strong enough?", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Lost the connection with the camera. Is your camera's WiFi strong enough?") forKey:NSLocalizedDescriptionKey];
			break;
		case 10005:
			[errorDetail setValue:NSLocalizedStringFromTableInBundle(@"This camera detected some motion and is currently recording, try again in a few moments.", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - This camera detected some motion and is currently recording, try again in a few moments.") forKey:NSLocalizedDescriptionKey];
			break;
		case 10006:
			[errorDetail setValue:NSLocalizedStringFromTableInBundle(@"We're having trouble connecting to the camera. Are you and your camera on a good connection? Please try it again.", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - We're having trouble connecting to the camera. Are you and your camera on a good connection? Please try it again.") forKey:NSLocalizedDescriptionKey];
			break;
        case 10007:
            [errorDetail setValue:NSLocalizedStringFromTableInBundle(@"Your password must be at least 8 characters long.", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Your password must be at least 8 characters long.") forKey:NSLocalizedDescriptionKey];
            break;
		case 10008:
			if(argument == nil) {
				[errorDetail setValue:NSLocalizedStringFromTableInBundle(@"You are already viewing this camera from somewhere else.", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - You are already viewing this camera from somewhere else.") forKey:NSLocalizedDescriptionKey];
				
			} else {
				[errorDetail setValue:[NSString stringWithFormat:NSLocalizedStringFromTableInBundle(@"\"%@\" seems to already be viewing this camera. Press the reconnect button to take over.", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - {name} seems to already be viewing this camera. Press the reconnect button to take over."), argument] forKey:NSLocalizedDescriptionKey];
			}
			break;
		case 10009:
			[errorDetail setValue:NSLocalizedStringFromTableInBundle(@"That wasn't the barcode you were looking for.", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - That wasn't the barcode you were looking for.") forKey:NSLocalizedDescriptionKey];
			break;
		case 10010:
			[errorDetail setValue:NSLocalizedStringFromTableInBundle(@"That barcode is corrupted.", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - That barcode is corrupted.") forKey:NSLocalizedDescriptionKey];
			break;
		case 10011:
			[errorDetail setValue:NSLocalizedStringFromTableInBundle(@"Having trouble connecting to Bluetooth!", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Having trouble connecting to Bluetooth!") forKey:NSLocalizedDescriptionKey];
			break;
		case 10012:
            track = NO;
			[errorDetail setValue:NSLocalizedStringFromTableInBundle(@"This device is too old to support Bluetooth LE", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - This device is too old to support Bluetooth LE") forKey:NSLocalizedDescriptionKey];
			break;
        case 10013:
            track = NO;
            [errorDetail setValue:[NSString stringWithFormat:NSLocalizedStringFromTableInBundle(@"Please authorize %@ to access Bluetooth LE", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Please authorize {App Name} to access Bluetooth LE"), [PPBaseModel appName:NO]] forKey:NSLocalizedDescriptionKey];
			break;
        case 10014:
            track = NO;
			[errorDetail setValue:NSLocalizedStringFromTableInBundle(@"Bluetooth is currently powered off. Please go into your Settings and turn on Bluetooth.", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Bluetooth is currently powered off. Please go into your Settings and turn on Bluetooth.") forKey:NSLocalizedDescriptionKey];
			break;
        case 10015:
            track = NO;
			[errorDetail setValue:NSLocalizedStringFromTableInBundle(@"Waiting for Bluetooth to power up...", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Waiting for Bluetooth to power up...") forKey:NSLocalizedDescriptionKey];
			break;
		case 10016:
			[errorDetail setValue:NSLocalizedStringFromTableInBundle(@"Couldn't save this video to your album!", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Couldn't save this video to your album!") forKey:NSLocalizedDescriptionKey];
			break;
		case 10017:
			[errorDetail setValue:NSLocalizedStringFromTableInBundle(@"Corrupted video file!", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Corrupted video file!") forKey:NSLocalizedDescriptionKey];
			break;
		case 10018:
			[errorDetail setValue:[NSString stringWithFormat:NSLocalizedStringFromTableInBundle(@"Can't save the video! Please grant %@ access to your Photos and Videos folder in iOS Settings > Privacy > Photos, then try your download again.", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Can't save the video! Please grant {App Name} access to your Photos and Videos folder in iOS Settings > Privacy > Photos, then try your download again."), [PPBaseModel appName:NO]] forKey:NSLocalizedDescriptionKey];
			break;
		case 10019:
			[errorDetail setValue:NSLocalizedStringFromTableInBundle(@"Error uploading", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Error uploading") forKey:NSLocalizedDescriptionKey];
			break;
		case 10020:
			[errorDetail setValue:NSLocalizedStringFromTableInBundle(@"Can't play this video! Did you delete it remotely? Do you have a good connection?", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Can't play this video! Did you delete it remotely? Do you have a good connection?") forKey:NSLocalizedDescriptionKey];
			break;
		case 10021:
			[errorDetail setValue:NSLocalizedStringFromTableInBundle(@"Please select at least one day this rule should repeat.", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Please select at least one day this rule should repeat.") forKey:NSLocalizedDescriptionKey];
			break;
		case 10022:
			[errorDetail setValue:NSLocalizedStringFromTableInBundle(@"Please name this device", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Please name this device") forKey:NSLocalizedDescriptionKey];
			break;
		case 10023:
            [errorDetail setValue:[NSString stringWithFormat:NSLocalizedStringFromTableInBundle(@"An email has been sent to you with instructions on how to add this device to your %@ account.", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - An email has been sent to you with instructions on how to add this device to your {App Name} account."), [PPBaseModel appName:NO]] forKey:NSLocalizedDescriptionKey];
			break;
		case 10024:
			[errorDetail setValue:NSLocalizedStringFromTableInBundle(@"Thank you, our team will look into this.", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Thank you, our team will look into this.") forKey:NSLocalizedDescriptionKey];
			break;
		case 10025:
			[errorDetail setValue:NSLocalizedStringFromTableInBundle(@"TED is not activated properly.", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - TED is not activated properly.") forKey:NSLocalizedDescriptionKey];
			break;
		case 10026:
			[errorDetail setValue:NSLocalizedStringFromTableInBundle(@"Couldn't contact Blue Line.", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Couldn't contact Blue Line.") forKey:NSLocalizedDescriptionKey];
			break;
		case 10027:
			[errorDetail setValue:NSLocalizedStringFromTableInBundle(@"Not activated.", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Not activated.") forKey:NSLocalizedDescriptionKey];
			break;
		case 10028:
            [errorDetail setValue:[NSString stringWithFormat:NSLocalizedStringFromTableInBundle(@"We believe there is a firewall blocking access to the %@ camera.", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - We believe there is a firewall blocking access to the {App Name} camera."), [PPBaseModel appName:NO]] forKey:NSLocalizedDescriptionKey];
            break;
        case 10029:
            [errorDetail setValue:NSLocalizedStringFromTableInBundle(@"Unable to connect Galileo 30-pin", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Unable to connect Galileo 30-pin") forKey:NSLocalizedDescriptionKey];
            break;
        case 10030:
            [errorDetail setValue:NSLocalizedStringFromTableInBundle(@"We couldn't contact the LintAlert Pro Plus. Press and release the Circle RESET button, then hold the Square CONFIG button for 3 seconds. Reconnect to the LintAlert's Wi-Fi network in your iOS Wi-Fi Settings, then try again.", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Unable to connect the LintAlert") forKey:NSLocalizedDescriptionKey];
            break;
        case 10031:
            [errorDetail setValue:NSLocalizedStringFromTableInBundle(@"IP Camera configuration requires either an IP or a DDNS address.", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Unable to configure IP Camera - No IP or DDNS address") forKey:NSLocalizedDescriptionKey];
            break;
        case 10032:
            [errorDetail setValue:NSLocalizedStringFromTableInBundle(@"Could not verify IP Camera", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Unable to verify IP Camera") forKey:NSLocalizedDescriptionKey];
            break;
        case 10033:
            [errorDetail setValue:NSLocalizedStringFromTableInBundle(@"Unable to configure default admin user", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Unable to configure default admin user") forKey:NSLocalizedDescriptionKey];
            break;
        case 10034:
            [errorDetail setValue:NSLocalizedStringFromTableInBundle(@"Unable to enable IP Camera UPnP", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Unable to enable IP Camera UPnP") forKey:NSLocalizedDescriptionKey];
            break;
        case 10035:
            [errorDetail setValue:NSLocalizedStringFromTableInBundle(@"Unable to change camera name", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Unable to change camera name") forKey:NSLocalizedDescriptionKey];
            break;
        case 10036:
            [errorDetail setValue:NSLocalizedStringFromTableInBundle(@"Unable to get camera name", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Unable to get camera name") forKey:NSLocalizedDescriptionKey];
            break;
        case 10037:
            [errorDetail setValue:NSLocalizedStringFromTableInBundle(@"Unable to change DDNS", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Unable to change DDNS") forKey:NSLocalizedDescriptionKey];
            break;
        case 10038:
            [errorDetail setValue:NSLocalizedStringFromTableInBundle(@"Unable to get DDNS", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Unable to get DDNS") forKey:NSLocalizedDescriptionKey];
            break;
        case 10039:
            [errorDetail setValue:NSLocalizedStringFromTableInBundle(@"Unable to register an IP Camera with this device type.  Please ensure that your camera is online and that you chose the correct device to add.", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Unable to get register IP Camera") forKey:NSLocalizedDescriptionKey];
            break;
        case 10040:
            [errorDetail setValue:NSLocalizedStringFromTableInBundle(@"Too many registration attempts. Please try again in a few minutes.", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Too many registration attempts. Please try again in a few minutes.") forKey:NSLocalizedDescriptionKey];
            break;
        case 10041:
            [errorDetail setValue:NSLocalizedStringFromTableInBundle(@"Unable to upload file!", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Unable to upload file!") forKey:NSLocalizedDescriptionKey];
            break;
        case 10042:
            [errorDetail setValue:NSLocalizedStringFromTableInBundle(@"Unable to download firmware!", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Unable to download firmware!") forKey:NSLocalizedDescriptionKey];
            break;
        case 10043:
            [errorDetail setValue:NSLocalizedStringFromTableInBundle(@"Unable to start up your camera! Please contact support.", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Unable to start up your camera! Please contact support.") forKey:NSLocalizedDescriptionKey];
            break;
            
            // Address Book
        case 20000:
            [errorDetail setValue:NSLocalizedStringFromTableInBundle(@"This app requires access to your contacts to function properly. Please visit to the \"Privacy\" section in the iPhone Settings app.", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - This app requires access to your contacts to function properly. Please visit to the \"Privacy\" section in the iPhone Settings app.") forKey:NSLocalizedDescriptionKey];
            break;
        case 20001:
            [errorDetail setValue:NSLocalizedStringFromTableInBundle(@"Unable to access your address book.", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Unable to access your address book.") forKey:NSLocalizedDescriptionKey];
            break;
        case 20002:
            [errorDetail setValue:NSLocalizedStringFromTableInBundle(@"An error occurred when attempting to request access to your Address Book.", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - An error occurred when attempting to request access to your Address Book.") forKey:NSLocalizedDescriptionKey];
            break;
        case 20003:
            [errorDetail setValue:NSLocalizedStringFromTableInBundle(@"You can still add friends manually using \"Search email or phone\"", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - You can still add friends manually using \"Search email or phone\"") forKey:NSLocalizedDescriptionKey];
            break;
        case 20004:
            [errorDetail setValue:NSLocalizedStringFromTableInBundle(@"Unable to access your address book. Please check your privacy settings.", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Unable to access your address book. Please check your privacy settings.") forKey:NSLocalizedDescriptionKey];
            break;
        case 20005:
            [errorDetail setValue:NSLocalizedStringFromTableInBundle(@"There are no contacts on this device.  Tap 'Search' or 'Scan someone's bar code' to add a friend manually.", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - There are no contacts on this device.  Tap 'Search' or 'Scan someone's bar code' to add a friend manually.") forKey:NSLocalizedDescriptionKey];
            
            // Location Services
        case 30000:
            [errorDetail setValue:NSLocalizedStringFromTableInBundle(@"\"Geofencing\" is not available for this mode.", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - \"Geofencing\" is not available for this mode.") forKey:NSLocalizedDescriptionKey];
            break;
        case 30001:
            [errorDetail setValue:NSLocalizedStringFromTableInBundle(@"Your location is already set this mode.", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Your location is already set this mode.") forKey:NSLocalizedDescriptionKey];
            break;
        case 30002:
            [errorDetail setValue:NSLocalizedStringFromTableInBundle(@"Failed to register for location services.", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Failed to register for location services.") forKey:NSLocalizedDescriptionKey];
            break;
        case 30003:
            [errorDetail setValue:NSLocalizedStringFromTableInBundle(@"Duplicate state change for region.", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Duplicate state change for region.") forKey:NSLocalizedDescriptionKey];
            break;
            
            // SMS Susbcribers
        case 40000:
            [errorDetail setValue:NSLocalizedStringFromTableInBundle(@"Your new phone number cannot receive SMS messages.", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - SMS Subscriber - Error updating phone number") forKey:NSLocalizedDescriptionKey];
            break;
        case 40001:
            [errorDetail setValue:NSLocalizedStringFromTableInBundle(@"Your phone number cannot receive SMS messages.  Please use a phone number that can receive SMS messages.", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Invalid phone number") forKey:NSLocalizedDescriptionKey];
            break;
            
            // Photo Data
        case 50000:
            [errorDetail setValue:NSLocalizedStringFromTableInBundle(@"This app needs access to your \"Photo Data\" in order for you to upload images and videos you've already taken on this device.  You may allow this in the iOS > Settings > Privacy menu.", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Photo Data - Privacy - Not Determined") forKey:NSLocalizedDescriptionKey];
            break;
        case 50001:
            [errorDetail setValue:NSLocalizedStringFromTableInBundle(@"This application is not able to access your \"Photo Data\" due to some restrictions.  Please check the iOS > Settings > Privacy menu.", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Photo Data - Privacy - Restricted") forKey:NSLocalizedDescriptionKey];
            break;
        case 50002:
            [errorDetail setValue:NSLocalizedStringFromTableInBundle(@"Access to your \"Photo Data\" was previously denied.  Please check the iOS > Settings > Privacy menu.", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Photo Data - Privacy - Denied") forKey:NSLocalizedDescriptionKey];
            break;
        case 50003:
            [errorDetail setValue:NSLocalizedStringFromTableInBundle(@"You've chosen to not allow this application access to your \"Photo Data\".  You will be asked for permission again the next time you access this feature.", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Photo Data - Privacy - Denied") forKey:NSLocalizedDescriptionKey];
            break;
            
            // Video Authorization
        case 60000:
            [errorDetail setValue:NSLocalizedStringFromTableInBundle(@"This app needs access to your \"Camera\" in order for you to capture new videos and pictures.  You may allow this in the iOS > Settings > Privacy menu.", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Camera - Privacy - Not Determined") forKey:NSLocalizedDescriptionKey];
            break;
        case 60001:
            [errorDetail setValue:NSLocalizedStringFromTableInBundle(@"This application is not able to access your \"Camera\" due to some restrictions.  Please check the iOS > Settings > Privacy menu.", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Camera - Privacy - Restricted") forKey:NSLocalizedDescriptionKey];
            break;
        case 60002:
            [errorDetail setValue:NSLocalizedStringFromTableInBundle(@"Access to your \"Camera\" was previously denied.  Please check the iOS > Settings > Privacy menu.", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Camera - Privacy - Denied") forKey:NSLocalizedDescriptionKey];
            break;
        case 60003:
            [errorDetail setValue:NSLocalizedStringFromTableInBundle(@"You've chosen to not allow this application access to your \"Camera\".  You will be asked for permission again the next time you access this feature.", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Photo Data - Privacy - Denied") forKey:NSLocalizedDescriptionKey];
            break;
            
            // Video Authorization
        case 70000:
            [errorDetail setValue:NSLocalizedStringFromTableInBundle(@"This app needs access to your \"Microphone\" in order for you to capture audio.  You may allow this in the iOS > Settings > Privacy menu.", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Microphone - Privacy - Not Determined") forKey:NSLocalizedDescriptionKey];
            break;
        case 70001:
            [errorDetail setValue:NSLocalizedStringFromTableInBundle(@"This application is not able to access your \"Microphone\" due to some restrictions.  Please check the iOS > Settings > Privacy menu.", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Microphone - Privacy - Restricted") forKey:NSLocalizedDescriptionKey];
            break;
        case 70002:
            [errorDetail setValue:NSLocalizedStringFromTableInBundle(@"Access to your \"Microphone\" was previously denied.  Please check the iOS > Settings > Privacy menu.", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Microphone - Privacy - Denied") forKey:NSLocalizedDescriptionKey];
            break;
        case 70003:
            [errorDetail setValue:NSLocalizedStringFromTableInBundle(@"You've chosen to not allow this application access to your \"Microphone\".  You will be asked for permission again the next time you access this feature.", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Photo Data - Privacy - Denied") forKey:NSLocalizedDescriptionKey];
            break;
            
            // Push Notifications
        case 80000:
            [errorDetail setValue:NSLocalizedStringFromTableInBundle(@"This app needs access to your \"Push Notifications\" in order for you to receive push notifications.  You may allow this in the iOS > Settings > Privacy menu.", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Push Notifications - Privacy - Not Determined") forKey:NSLocalizedDescriptionKey];
            break;
        case 80001:
            [errorDetail setValue:NSLocalizedStringFromTableInBundle(@"You are currently testing out \"Push Notifications\", with some restrictions.  Please check the iOS > Settings > Privacy menu.", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Push Notifications - Privacy - Provisional") forKey:NSLocalizedDescriptionKey];
            break;
        case 80002:
            [errorDetail setValue:NSLocalizedStringFromTableInBundle(@"Access to your \"Push Notifications\" was previously denied.  Please check the iOS > Settings > Privacy menu.", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Push Notifications - Privacy - Denied") forKey:NSLocalizedDescriptionKey];
            break;
        case 80003:
            [errorDetail setValue:NSLocalizedStringFromTableInBundle(@"You've chosen to not allow this application access to your \"Push Notifications\".  You can change your app settings in your profile page.", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Push Notifications - Privacy - Denied") forKey:NSLocalizedDescriptionKey];
            break;
            
        default:
            [errorDetail setValue:[NSString stringWithFormat:NSLocalizedStringFromTableInBundle(@"Oops, something went wrong.  Please contact support. (%li)", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Default"), (long)resultCode] forKey:NSLocalizedDescriptionKey];
            argument = nil;
            break;
	}
    
    if(argument != nil && ![argument isEqualToString:@""]) {
        BOOL setArgument = YES;
        
        if(resultCode == 10003) {
#ifdef DEBUG
            setArgument = YES;
#else
            setArgument = NO;
#endif
        }

        if(setArgument) {
            [errorDetail setValue:argument forKey:NSLocalizedRecoverySuggestionErrorKey];
        }
    }
	
    if(track) {
        NSMutableDictionary *properties = [[NSMutableDictionary alloc] initWithCapacity:3];
        [properties setObject:[NSString stringWithFormat:@"%ld", (long)resultCode] forKey:@"Code"];
        if([errorDetail objectForKey:NSLocalizedDescriptionKey] != nil) {
            [properties setObject:[errorDetail objectForKey:NSLocalizedDescriptionKey] forKey:@"Description"];
        }
        if([errorDetail objectForKey:NSLocalizedRecoverySuggestionErrorKey] != nil) {
            [properties setObject:[errorDetail objectForKey:NSLocalizedRecoverySuggestionErrorKey] forKey:@"Recovery"];
        }
        if (originatingClass) {
            [properties setObject:originatingClass forKey:@"Location"];
        }
        
        [PPUserAnalytics track:@"error" properties:properties logLevel:ANALYTICS_LEVEL_INFO];
    }

	return [NSError errorWithDomain:@"com.peoplepowerco.lib.Peoplepower" code:resultCode userInfo:errorDetail];
}

+ (NSDictionary *)processJSONResponse:(NSData *)responseData error:(NSError **)error {
    return [PPBaseModel processJSONResponse:responseData originatingClass:nil error:error];
}

+ (NSDictionary *)processJSONResponse:(NSData *)responseData originatingClass:(NSString *)originatingClass error:(NSError **)error {
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    if(responseString.length == 0) {
        return @{};
    }
    
    NSError *parsingError = nil;
    NSDictionary *parsedObject;
    NSInteger resultCode = 0;
    NSString *resultCodeMessage = nil;
    parsedObject = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&parsingError];
    
    if(parsingError) {
        *error = parsingError;
        return nil;
    }
    
    resultCode = ((NSString *)[parsedObject objectForKey:@"resultCode"]).integerValue;
    resultCodeMessage = ((NSString *)[parsedObject objectForKey:@"resultCodeMessage"]);
    
    if(resultCode > 0) {
        if(resultCode == 2) {
            [PPBaseModel throwLoginBlock];
            
            // Ignore any argument
            *error = [PPBaseModel resultCodeToNSError:resultCode originatingClass:originatingClass];
            return nil;
        }
        else if((resultCode == 19
                 || resultCode == 44)
                && [parsedObject objectForKey:@"lockTime"] && [parsedObject objectForKey:@"lockTimeout"]) {
            NSDate *lockTime = [NSDate dateWithTimeIntervalSince1970:[parsedObject[@"lockTime"] integerValue] / 1000];
            NSInteger lockTimeout = [parsedObject[@"lockTimeout"] integerValue] / 1000;
            NSInteger unlockTime = [[lockTime dateByAddingTimeInterval:lockTimeout] timeIntervalSinceNow];
            NSInteger seconds = unlockTime % 60;
            NSInteger minutes = (unlockTime / 60) % 60;
            NSInteger hours = unlockTime / 3600;
            NSMutableArray *timeArray = [[NSMutableArray alloc] initWithCapacity:3];
            
            if(hours > 0) {
                [timeArray addObject:[NSString stringWithFormat:NSLocalizedStringFromTableInBundle(@"%li %@", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @""), (long)hours, (hours == 1) ? NSLocalizedStringFromTableInBundle(@"hour", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"") : NSLocalizedStringFromTableInBundle(@"hours", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"")]];
            }
            if(minutes > 0) {
                [timeArray addObject:[NSString stringWithFormat:NSLocalizedStringFromTableInBundle(@"%li %@", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @""), (long)minutes, (minutes == 1) ? NSLocalizedStringFromTableInBundle(@"minute", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"") : NSLocalizedStringFromTableInBundle(@"minutes", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"")]];
            }
            if(seconds > 0) {
                [timeArray addObject:[NSString stringWithFormat:NSLocalizedStringFromTableInBundle(@"%li %@", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @""), (long)seconds, (seconds == 1) ? NSLocalizedStringFromTableInBundle(@"second", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"") : NSLocalizedStringFromTableInBundle(@"seconds", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"")]];
            }
            
            NSString *argument = NSLocalizedStringFromTableInBundle(@"Try again later.", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"");
            if ([timeArray count] > 0) {
                NSMutableString *timeString = [[NSMutableString alloc] initWithCapacity:0];
                BOOL appendComma = NO;
                for(NSString *time in timeArray) {
                    
                    if(appendComma) {
                        [timeString appendString:NSLocalizedStringFromTableInBundle(@",", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Character - Comma")];
                    }
                    if(time != [timeArray firstObject]) {
                        [timeString appendString:NSLocalizedStringFromTableInBundle(@" ", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Character - Space")];
                    }
                    if ([timeArray count] > 1) {
                        if(time == [timeArray lastObject]) {
                            [timeString appendString:NSLocalizedStringFromTableInBundle(@"&", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Character - Ampersand")];
                            [timeString appendString:NSLocalizedStringFromTableInBundle(@" ", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Character - Space")];
                        }
                    }
                    [timeString appendString:time];
                    if([timeArray count] > 2) {
                        appendComma = YES;
                    }
                }
                argument = [NSString stringWithFormat:NSLocalizedStringFromTableInBundle(@"Try again in %@", nil, [NSBundle bundleWithIdentifier:@"com.peoplepowerco.lib.Peoplepower.iOS"], @"Error - Try again in {time}"), timeString];
            }
            *error = [PPBaseModel resultCodeToNSError:resultCode argument:argument];
        }
        else if(resultCodeMessage != nil && ![resultCodeMessage isEqualToString:@""]) {
            *error = [PPBaseModel resultCodeToNSError:resultCode originatingClass:originatingClass argument:resultCodeMessage];
        }
        else {
            *error = [PPBaseModel resultCodeToNSError:resultCode originatingClass:originatingClass];
        }
        return nil;
    }
    
    PPLogAPI(@"%@", [PPCurlDebug responseToDescription:parsedObject]);
    
    return parsedObject;
}

@end
