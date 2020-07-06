//
//  PPBaseModel.m
//  Peoplepower
//
//  Copyright (c) 2020 People Power. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPCurlDebug.h"

PPBasicBlock _loginBlock;

@implementation PPBaseModel

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
    
	switch(resultCode) {
		case 0:
			return nil;
		case 1: // Internal Error
            [errorDetail setValue:[NSString stringWithFormat:NSLocalizedString(@"The %@ app had trouble connecting. Is your internet connection ok?", @"Error - The {App Name} app had trouble connecting. Is your internet connection ok?"), [PPBaseModel appName:NO]] forKey:NSLocalizedDescriptionKey];
			break;
		case 2: // Wrong API Key
			[errorDetail setValue:NSLocalizedString(@"You are no longer signed in", @"Error - You are no longer signed in") forKey:NSLocalizedDescriptionKey];
			break;
		case 3:
			[errorDetail setValue:NSLocalizedString(@"Wrong location ID or location is not related to the user", @"Error - Wrong location ID or location is not related to the user") forKey:NSLocalizedDescriptionKey];
			break;
		case 4: // Wrong device ID or device has not been found
			[errorDetail setValue:NSLocalizedString(@"That device is no longer in your account", @"Error - That device is no longer in your account") forKey:NSLocalizedDescriptionKey];
			break;
		case 5: // Device proxy (gateway) has not been found
			[errorDetail setValue:NSLocalizedString(@"Device command proxy (gateway) has not been found", @"Error - Device command proxy (gateway) has not been found") forKey:NSLocalizedDescriptionKey];
			break;
		case 6: // Object not found
			[errorDetail setValue:NSLocalizedString(@"That type of product isn't supported on this server.", @"Error - That type of product isn't supported on this server.") forKey:NSLocalizedDescriptionKey];
			break;
		case 7: // Access denied
			[errorDetail setValue:NSLocalizedString(@"Access denied", @"Error - Access denied") forKey:NSLocalizedDescriptionKey];
			break;
		case 8: // Wrong parameter value
			[errorDetail setValue:NSLocalizedString(@"Oops, you typed in something wrong there", @"Error - Oops, you typed in something wrong there") forKey:NSLocalizedDescriptionKey];
			break;
		case 9: // Missed mandatory parameter value
			[errorDetail setValue:NSLocalizedString(@"Please fill in all required fields", @"Error - Please fill in all required fields") forKey:NSLocalizedDescriptionKey];
			break;
		case 10: // No available device resources to complete operation
			[errorDetail setValue:NSLocalizedString(@"No available device resources to complete operation", @"Error - No available device resources to complete operation") forKey:NSLocalizedDescriptionKey];
			break;
		case 11: // Not enough free files space
			[errorDetail setValue:NSLocalizedString(@"The username or password you entered is incorrect", @"Error - The username or password you entered is incorrect") forKey:NSLocalizedDescriptionKey];
			break;
		case 12: // Invalid username or wrong password
			[errorDetail setValue:NSLocalizedString(@"The username or password you entered is incorrect", @"Error - The username or password you entered is incorrect") forKey:NSLocalizedDescriptionKey];
			break;
		case 13:
			[errorDetail setValue:NSLocalizedString(@"Wrong index value", @"Error - Wrong index value") forKey:NSLocalizedDescriptionKey];
			break;
		case 14: // Error in parsing of input data
			[errorDetail setValue: NSLocalizedString(@"Error in parsing of input data", @"Error - Error in parsing of input data") forKey:NSLocalizedDescriptionKey];
			break;
		case 15: // Missing required paid service for this operation
			[errorDetail setValue:NSLocalizedString(@"Wrong consumer ID", @"Error - Wrong consumer ID") forKey:NSLocalizedDescriptionKey];
			break;
		case 16: // User account is locked out
			[errorDetail setValue:NSLocalizedString(@"Account locked", @"Error - Account locked") forKey:NSLocalizedDescriptionKey];
			break;
		case 17: // A passcode, which has been sent to the user, is required to sign in
			[errorDetail setValue:NSLocalizedString(@"Wrong activation key", @"Error - Wrong activation key") forKey:NSLocalizedDescriptionKey];
			break;
		case 18: // Wrong rule schedule format
			[errorDetail setValue:NSLocalizedString(@"Wrong rule schedule format", @"Error - Wrong rule schedule format") forKey:NSLocalizedDescriptionKey];
			break;
		case 19: // Operation is temporary locked
            [errorDetail setValue:NSLocalizedString(@"This action is temporarily locked", @"Error - This action is temporarily locked") forKey:NSLocalizedDescriptionKey];
            if(argument != nil && ![argument isEqualToString:@""]) {
                [errorDetail setValue:argument forKey:NSLocalizedRecoverySuggestionErrorKey];
            }
			break;
		case 20: // Duplicate user name
			[errorDetail setValue:NSLocalizedString(@"Duplicate user name", @"Error - Duplicate user name") forKey:NSLocalizedDescriptionKey];
			break;
		case 21: // Device is offline or disconnected
			[errorDetail setValue:NSLocalizedString(@"Device is offline or disconnected", @"Error - Device is offline or disconnected") forKey:NSLocalizedDescriptionKey];
			break;
		case 22: // Device is under different location
			[errorDetail setValue:NSLocalizedString(@"That device belongs to someone else", @"Error - That device belongs to someone else") forKey:NSLocalizedDescriptionKey];
			break;
		case 23: // Rule generation error
			[errorDetail setValue:NSLocalizedString(@"Well that's strange, we had a problem saving that rule. Sorry about this!\n\nIf you have time, please contact support@peoplepowerco.com and describe the rule you were trying to create so we can fix it.", @"Error - Well that's strange, we had a problem saving that rule. Sorry about this!\n\nIf you have time, please contact support@peoplepowerco.com and describe the rule you were trying to create so we can fix it.") forKey:NSLocalizedDescriptionKey];
			break;
		case 24:
			[errorDetail setValue:NSLocalizedString(@"Wrong device registration code", @"Error - Wrong device registration code") forKey:NSLocalizedDescriptionKey];
			break;
		case 25: // Child object found
			[errorDetail setValue:NSLocalizedString(@"Number of pending device types for this user is more than allowed", @"Error - Number of pending device types for this user is more than allowed") forKey:NSLocalizedDescriptionKey];
			break;
		case 26: // Duplicate entity or property
			[errorDetail setValue:NSLocalizedString(@"Duplicate entity or property", @"Error - Duplicate entity or property") forKey:NSLocalizedDescriptionKey];
			break;
		case 27: // Server is busy or overloaded and cannot complete the request in reasonable time
			[errorDetail setValue:NSLocalizedString(@"Timeout in device communication", @"Error - Timeout in device communication") forKey:NSLocalizedDescriptionKey];
			break;
		case 28:
			[errorDetail setValue:NSLocalizedString(@"Device is not linked to any location", @"Error - Device is not linked to any location") forKey:NSLocalizedDescriptionKey];
			break;
        case 29: // Requested API method not found
            [errorDetail setValue:NSLocalizedString(@"Requested API method not found", @"Error - Requested API method not found") forKey:NSLocalizedDescriptionKey];
            break;
        case 30: // Service is temporary unavailable
            [errorDetail setValue:NSLocalizedString(@"Service is temporarily unavailable", @"Error - Service is temporarily unavailable") forKey:NSLocalizedDescriptionKey];
            break;
        case 31: // Unknown OAuth client
            [errorDetail setValue:NSLocalizedString(@"Unknown OAuth client", @"Error - Unknown OAuth client") forKey:NSLocalizedDescriptionKey];
            break;
        case 32: // External application error response
            [errorDetail setValue:NSLocalizedString(@"External application error response", @"Error - External application error response") forKey:NSLocalizedDescriptionKey];
            break;
        case 33: // Wrong operation token
            [errorDetail setValue:NSLocalizedString(@"Wrong operation token", @"Error - Wrong operation token") forKey:NSLocalizedDescriptionKey];
            break;
        case 34: // Cannot modify external resources
            [errorDetail setValue:NSLocalizedString(@"Cannot modify external resources", @"Error - Cannot modify external resources") forKey:NSLocalizedDescriptionKey];
            break;
        case 35: // Wrong phone number
            [errorDetail setValue:NSLocalizedString(@"Wrong phone number", @"Error - Wrong phone number") forKey:NSLocalizedDescriptionKey];
            break;
        case 36: // Operation canceled
            [errorDetail setValue:NSLocalizedString(@"Operation canceled", @"Error - Operation canceled") forKey:NSLocalizedDescriptionKey];
            break;
        case 37: // Cannot authorize user on external resource or cloud
            [errorDetail setValue:NSLocalizedString(@"Cannot authorize user on external resource or cloud", @"Error - 37") forKey:NSLocalizedDescriptionKey];
            break;
        case 38: // Requested resource is not available
            [errorDetail setValue:NSLocalizedString(@"Maximum reached", @"Error - Maximum reached") forKey:NSLocalizedDescriptionKey];
            if(argument != nil && ![argument isEqualToString:@""]) {
                [errorDetail setValue:argument forKey:NSLocalizedRecoverySuggestionErrorKey];
            }
            break;
        case 39: // Device not found on external cloud
            [errorDetail setValue:NSLocalizedString(@"Device not found on external cloud", @"Error - 39") forKey:NSLocalizedDescriptionKey];
            break;
        case 40: // Request not allowed in the current state of the resource
            [errorDetail setValue:NSLocalizedString(@"Request not allowed in the current state of the resource", @"Error - 40") forKey:NSLocalizedDescriptionKey];
            break;
        case 41: // Request has not been completed. It is not an error, just nothing to do.
            [errorDetail setValue:NSLocalizedString(@"Request has not been completed. It is not an error, just nothing to do.", @"Error - 41") forKey:NSLocalizedDescriptionKey];
            break;
        case 42: // Cannot connect to an external resource
            [errorDetail setValue:NSLocalizedString(@"Cannot connect to an external resource", @"Error - 42") forKey:NSLocalizedDescriptionKey];
            break;
        case 43:
            break;
        case 44: // Too often API calls
            [errorDetail setValue:NSLocalizedString(@"Too often API calls", @"Error - 44") forKey:NSLocalizedDescriptionKey];
            break;
        case 45: // The communication channel is not authenticated
            [errorDetail setValue:NSLocalizedString(@"The communication channel is not authenticated", @"Error - 45") forKey:NSLocalizedDescriptionKey];
            break;
        
		case 10000:
			[errorDetail setValue:NSLocalizedString(@"Having trouble connecting. If you're not viewing your camera from somewhere else, please try connecting again.", @"Error - Having trouble connecting. If you're not viewing your camera from somewhere else, please try connecting again.") forKey:NSLocalizedDescriptionKey];
			break;
		case 10001:
			[errorDetail setValue:NSLocalizedString(@"This camera is currently not available. Make sure it is up and running remotely.", @"Error - This camera is currently not available. Make sure it is up and running remotely.") forKey:NSLocalizedDescriptionKey];
			break;
		case 10002:
			[errorDetail setValue:NSLocalizedString(@"There was an error creating the camera, please try again later.", @"Error - There was an error creating the camera, please try again later.") forKey:NSLocalizedDescriptionKey];
			break;
        case -1009:
            // kCFErrorDomainCFNetwork
            // Not connected to the internet
            // fallthrough
		case 10003:
            [errorDetail setValue:[NSString stringWithFormat:NSLocalizedString(@"The %@ app had trouble connecting. Is your internet connection ok?", @"Error - The {App Name} app had trouble connecting. Is your internet connection ok?"), [PPBaseModel appName:NO]] forKey:NSLocalizedDescriptionKey];
			break;
		case 10004:
			[errorDetail setValue:NSLocalizedString(@"Lost the connection with the camera. Is your camera's WiFi strong enough?", @"Error - Lost the connection with the camera. Is your camera's WiFi strong enough?") forKey:NSLocalizedDescriptionKey];
			break;
		case 10005:
			[errorDetail setValue:NSLocalizedString(@"This camera detected some motion and is currently recording, try again in a few moments.", @"Error - This camera detected some motion and is currently recording, try again in a few moments.") forKey:NSLocalizedDescriptionKey];
			break;
		case 10006:
			[errorDetail setValue:NSLocalizedString(@"We're having trouble connecting to the camera. Are you and your camera on a good connection? Please try it again.", @"Error - We're having trouble connecting to the camera. Are you and your camera on a good connection? Please try it again.") forKey:NSLocalizedDescriptionKey];
			break;
        case 10007:
            [errorDetail setValue:NSLocalizedString(@"Your password must be at least 8 characters long.", @"Error - Your password must be at least 8 characters long.") forKey:NSLocalizedDescriptionKey];
            break;
		case 10008:
			if(argument == nil) {
				[errorDetail setValue:NSLocalizedString(@"You are already viewing this camera from somewhere else.", @"Error - You are already viewing this camera from somewhere else.") forKey:NSLocalizedDescriptionKey];
				
			} else {
				[errorDetail setValue:[NSString stringWithFormat:NSLocalizedString(@"\"%@\" seems to already be viewing this camera. Press the reconnect button to take over.", @"Error - {name} seems to already be viewing this camera. Press the reconnect button to take over."), argument] forKey:NSLocalizedDescriptionKey];
			}
			break;
		case 10009:
			[errorDetail setValue:NSLocalizedString(@"That wasn't the barcode you were looking for.", @"Error - That wasn't the barcode you were looking for.") forKey:NSLocalizedDescriptionKey];
			break;
		case 10010:
			[errorDetail setValue:NSLocalizedString(@"That barcode is corrupted.", @"Error - That barcode is corrupted.") forKey:NSLocalizedDescriptionKey];
			break;
		case 10011:
			[errorDetail setValue:NSLocalizedString(@"Having trouble connecting to Bluetooth!", @"Error - Having trouble connecting to Bluetooth!") forKey:NSLocalizedDescriptionKey];
			break;
		case 10012:
			[errorDetail setValue:NSLocalizedString(@"This device is too old to support Bluetooth LE", @"Error - This device is too old to support Bluetooth LE") forKey:NSLocalizedDescriptionKey];
			break;
        case 10013:
            [errorDetail setValue:[NSString stringWithFormat:NSLocalizedString(@"Please authorize %@ to access Bluetooth LE", @"Error - Please authorize {App Name} to access Bluetooth LE"), [PPBaseModel appName:NO]] forKey:NSLocalizedDescriptionKey];
			break;
        case 10014:
			[errorDetail setValue:NSLocalizedString(@"Bluetooth is currently powered off. Please go into your Settings and turn on Bluetooth.", @"Error - Bluetooth is currently powered off. Please go into your Settings and turn on Bluetooth.") forKey:NSLocalizedDescriptionKey];
			break;
        case 10015:
			[errorDetail setValue:NSLocalizedString(@"Waiting for Bluetooth to power up...", @"Error - Waiting for Bluetooth to power up...") forKey:NSLocalizedDescriptionKey];
			break;
		case 10016:
			[errorDetail setValue:NSLocalizedString(@"Couldn't save this video to your album!", @"Error - Couldn't save this video to your album!") forKey:NSLocalizedDescriptionKey];
			break;
		case 10017:
			[errorDetail setValue:NSLocalizedString(@"Corrupted video file!", @"Error - Corrupted video file!") forKey:NSLocalizedDescriptionKey];
			break;
		case 10018:
			[errorDetail setValue:[NSString stringWithFormat:NSLocalizedString(@"Can't save the video! Please grant %@ access to your Photos and Videos folder in iOS Settings > Privacy > Photos, then try your download again.", @"Error - Can't save the video! Please grant {App Name} access to your Photos and Videos folder in iOS Settings > Privacy > Photos, then try your download again."), [PPBaseModel appName:NO]] forKey:NSLocalizedDescriptionKey];
			break;
		case 10019:
			[errorDetail setValue:NSLocalizedString(@"Error uploading", @"Error - Error uploading") forKey:NSLocalizedDescriptionKey];
			break;
		case 10020:
			[errorDetail setValue:NSLocalizedString(@"Can't play this video! Did you delete it remotely? Do you have a good connection?", @"Error - Can't play this video! Did you delete it remotely? Do you have a good connection?") forKey:NSLocalizedDescriptionKey];
			break;
		case 10021:
			[errorDetail setValue:NSLocalizedString(@"Please select at least one day this rule should repeat.", @"Error - Please select at least one day this rule should repeat.") forKey:NSLocalizedDescriptionKey];
			break;
		case 10022:
			[errorDetail setValue:NSLocalizedString(@"Please name this device", @"Error - Please name this device") forKey:NSLocalizedDescriptionKey];
			break;
		case 10023:
            [errorDetail setValue:[NSString stringWithFormat:NSLocalizedString(@"An email has been sent to you with instructions on how to add this device to your %@ account.", @"Error - An email has been sent to you with instructions on how to add this device to your {App Name} account."), [PPBaseModel appName:NO]] forKey:NSLocalizedDescriptionKey];
			break;
		case 10024:
			[errorDetail setValue:NSLocalizedString(@"Thank you, our team will look into this.", @"Error - Thank you, our team will look into this.") forKey:NSLocalizedDescriptionKey];
			break;
		case 10025:
			[errorDetail setValue:NSLocalizedString(@"TED is not activated properly.", @"Error - TED is not activated properly.") forKey:NSLocalizedDescriptionKey];
			break;
		case 10026:
			[errorDetail setValue:NSLocalizedString(@"Couldn't contact Blue Line.", @"Error - Couldn't contact Blue Line.") forKey:NSLocalizedDescriptionKey];
			break;
		case 10027:
			[errorDetail setValue:NSLocalizedString(@"Not activated.", @"Error - Not activated.") forKey:NSLocalizedDescriptionKey];
			break;
		case 10028:
            [errorDetail setValue:[NSString stringWithFormat:NSLocalizedString(@"We believe there is a firewall blocking access to the %@ camera.", @"Error - We believe there is a firewall blocking access to the {App Name} camera."), [PPBaseModel appName:NO]] forKey:NSLocalizedDescriptionKey];
            break;
        case 10029:
            [errorDetail setValue:NSLocalizedString(@"Unable to connect Galileo 30-pin", @"Error - Unable to connect Galileo 30-pin") forKey:NSLocalizedDescriptionKey];
            break;
        case 10030:
            [errorDetail setValue:NSLocalizedString(@"We couldn't contact the LintAlert Pro Plus. Press and release the Circle RESET button, then hold the Square CONFIG button for 3 seconds. Reconnect to the LintAlert's Wi-Fi network in your iOS Wi-Fi Settings, then try again.", @"Error - Unable to connect the LintAlert") forKey:NSLocalizedDescriptionKey];
            break;
        case 10031:
            [errorDetail setValue:NSLocalizedString(@"IP Camera configuration requires either an IP or a DDNS address.", @"Error - Unable to configure IP Camera - No IP or DDNS address") forKey:NSLocalizedDescriptionKey];
            break;
        case 10032:
            [errorDetail setValue:NSLocalizedString(@"Could not verify IP Camera", @"Error - Unable to verify IP Camera") forKey:NSLocalizedDescriptionKey];
            break;
        case 10033:
            [errorDetail setValue:NSLocalizedString(@"Unable to configure default admin user", @"Error - Unable to configure default admin user") forKey:NSLocalizedDescriptionKey];
            break;
        case 10034:
            [errorDetail setValue:NSLocalizedString(@"Unable to enable IP Camera UPnP", @"Error - Unable to enable IP Camera UPnP") forKey:NSLocalizedDescriptionKey];
            break;
        case 10035:
            [errorDetail setValue:NSLocalizedString(@"Unable to change camera name", @"Error - Unable to change camera name") forKey:NSLocalizedDescriptionKey];
            break;
        case 10036:
            [errorDetail setValue:NSLocalizedString(@"Unable to get camera name", @"Error - Unable to get camera name") forKey:NSLocalizedDescriptionKey];
            break;
        case 10037:
            [errorDetail setValue:NSLocalizedString(@"Unable to change DDNS", @"Error - Unable to change DDNS") forKey:NSLocalizedDescriptionKey];
            break;
        case 10038:
            [errorDetail setValue:NSLocalizedString(@"Unable to get DDNS", @"Error - Unable to get DDNS") forKey:NSLocalizedDescriptionKey];
            break;
        case 10039:
            [errorDetail setValue:NSLocalizedString(@"Unable to register an IP Camera with this device type.  Please ensure that your camera is online and that you chose the correct device to add.", @"Error - Unable to get register IP Camera") forKey:NSLocalizedDescriptionKey];
            break;
        case 10040:
            [errorDetail setValue:NSLocalizedString(@"Too many registration attempts. Please try again in a few minutes.", @"Error - Too many registration attempts. Please try again in a few minutes.") forKey:NSLocalizedDescriptionKey];
            break;
        case 10041:
            [errorDetail setValue:NSLocalizedString(@"Unable to upload file!", @"Error - Unable to upload file!") forKey:NSLocalizedDescriptionKey];
            break;
        case 10042:
            [errorDetail setValue:NSLocalizedString(@"Unable to download firmware!", @"Error - Unable to download firmware!") forKey:NSLocalizedDescriptionKey];
            break;
        case 10043:
            [errorDetail setValue:NSLocalizedString(@"Unable to start up your camera! Please contact support.", @"Error - Unable to start up your camera! Please contact support.") forKey:NSLocalizedDescriptionKey];
            break;
            
            // Address Book
        case 20000:
            [errorDetail setValue:NSLocalizedString(@"This app requires access to your contacts to function properly. Please visit to the \"Privacy\" section in the iPhone Settings app.", @"Error - This app requires access to your contacts to function properly. Please visit to the \"Privacy\" section in the iPhone Settings app.") forKey:NSLocalizedDescriptionKey];
            break;
        case 20001:
            [errorDetail setValue:NSLocalizedString(@"There was a problem referencing your Address Book.", @"Error - There was a problem referencing your Address Book.") forKey:NSLocalizedDescriptionKey];
            break;
        case 20002:
            [errorDetail setValue:NSLocalizedString(@"An error occurred when attempting to request access to your Address Book.", @"Error - An error occurred when attempting to request access to your Address Book.") forKey:NSLocalizedDescriptionKey];
            break;
        case 20003:
            [errorDetail setValue:NSLocalizedString(@"You can still add friends manually using \"Search email or phone\"", @"Error - You can still add friends manually using \"Search email or phone\"") forKey:NSLocalizedDescriptionKey];
            break;
        case 20004:
            [errorDetail setValue:NSLocalizedString(@"There was a problem referencing your Address Book, please check your privacy settings.", @"Error - There was a problem referencing your Address Book, please check your privacy settings.") forKey:NSLocalizedDescriptionKey];
            break;
        case 20005:
            [errorDetail setValue:NSLocalizedString(@"There are no contacts on this device.  Tap 'Search' or 'Scan someone's bar code' to add a friend manually.", @"Error - There are no contacts on this device.  Tap 'Search' or 'Scan someone's bar code' to add a friend manually.") forKey:NSLocalizedDescriptionKey];
            
            // Location Services
        case 30000:
            [errorDetail setValue:NSLocalizedString(@"\"Geofencing\" is not available for this mode.", @"Error - \"Geofencing\" is not available for this mode.") forKey:NSLocalizedDescriptionKey];
            break;
        case 30001:
            [errorDetail setValue:NSLocalizedString(@"Your location is already set this mode.", @"Error - Your location is already set this mode.") forKey:NSLocalizedDescriptionKey];
            break;
        case 30002:
            [errorDetail setValue:NSLocalizedString(@"Failed to register for location services.", @"Error - Failed to register for location services.") forKey:NSLocalizedDescriptionKey];
            break;
        case 30003:
            [errorDetail setValue:NSLocalizedString(@"Duplicate state change for region.", @"Error - Duplicate state change for region.") forKey:NSLocalizedDescriptionKey];
            break;
            
            // SMS Susbcribers
        case 40000:
            [errorDetail setValue:NSLocalizedString(@"Your new phone number cannot receive SMS messages.", @"Error - SMS Subscriber - Error updating phone number") forKey:NSLocalizedDescriptionKey];
            break;
        case 40001:
            [errorDetail setValue:NSLocalizedString(@"Your phone number cannot receive SMS messages.  Please use a phone number that can receive SMS messages.", @"Error - Invalid phone number") forKey:NSLocalizedDescriptionKey];
            break;
            
            // Photo Data
        case 50000:
            [errorDetail setValue:NSLocalizedString(@"This app needs access to your \"Photo Data\" in order for you to upload images and videos you've already taken on this device.  You may allow this in the iOS > Settings > Privacy menu.", @"Error - Photo Data - Privacy - Not Determined") forKey:NSLocalizedDescriptionKey];
            break;
        case 50001:
            [errorDetail setValue:NSLocalizedString(@"This application is not able to access your \"Photo Data\" due to some restrictions.  Please check the iOS > Settings > Privacy menu.", @"Error - Photo Data - Privacy - Restricted") forKey:NSLocalizedDescriptionKey];
            break;
        case 50002:
            [errorDetail setValue:NSLocalizedString(@"Access to your \"Photo Data\" was previously denied.  Please check the iOS > Settings > Privacy menu.", @"Error - Photo Data - Privacy - Denied") forKey:NSLocalizedDescriptionKey];
            break;
        case 50003:
            [errorDetail setValue:NSLocalizedString(@"You've chosen to not allow this application access to your \"Photo Data\".  You will be asked for permission again the next time you access this feature.", @"Error - Photo Data - Privacy - Denied") forKey:NSLocalizedDescriptionKey];
            break;
            
            // Video Authorization
        case 60000:
            [errorDetail setValue:NSLocalizedString(@"This app needs access to your \"Camera\" in order for you to capture new videos and pictures.  You may allow this in the iOS > Settings > Privacy menu.", @"Error - Camera - Privacy - Not Determined") forKey:NSLocalizedDescriptionKey];
            break;
        case 60001:
            [errorDetail setValue:NSLocalizedString(@"This application is not able to access your \"Camera\" due to some restrictions.  Please check the iOS > Settings > Privacy menu.", @"Error - Camera - Privacy - Restricted") forKey:NSLocalizedDescriptionKey];
            break;
        case 60002:
            [errorDetail setValue:NSLocalizedString(@"Access to your \"Camera\" was previously denied.  Please check the iOS > Settings > Privacy menu.", @"Error - Camera - Privacy - Denied") forKey:NSLocalizedDescriptionKey];
            break;
        case 60003:
            [errorDetail setValue:NSLocalizedString(@"You've chosen to not allow this application access to your \"Camera\".  You will be asked for permission again the next time you access this feature.", @"Error - Photo Data - Privacy - Denied") forKey:NSLocalizedDescriptionKey];
            break;
            
            // Video Authorization
        case 70000:
            [errorDetail setValue:NSLocalizedString(@"This app needs access to your \"Microphone\" in order for you to capture audio.  You may allow this in the iOS > Settings > Privacy menu.", @"Error - Microphone - Privacy - Not Determined") forKey:NSLocalizedDescriptionKey];
            break;
        case 70001:
            [errorDetail setValue:NSLocalizedString(@"This application is not able to access your \"Microphone\" due to some restrictions.  Please check the iOS > Settings > Privacy menu.", @"Error - Microphone - Privacy - Restricted") forKey:NSLocalizedDescriptionKey];
            break;
        case 70002:
            [errorDetail setValue:NSLocalizedString(@"Access to your \"Microphone\" was previously denied.  Please check the iOS > Settings > Privacy menu.", @"Error - Microphone - Privacy - Denied") forKey:NSLocalizedDescriptionKey];
            break;
        case 70003:
            [errorDetail setValue:NSLocalizedString(@"You've chosen to not allow this application access to your \"Microphone\".  You will be asked for permission again the next time you access this feature.", @"Error - Photo Data - Privacy - Denied") forKey:NSLocalizedDescriptionKey];
            break;
            
            // Push Notifications
        case 80000:
            [errorDetail setValue:NSLocalizedString(@"This app needs access to your \"Push Notifications\" in order for you to receive push notifications.  You may allow this in the iOS > Settings > Privacy menu.", @"Error - Push Notifications - Privacy - Not Determined") forKey:NSLocalizedDescriptionKey];
            break;
        case 80001:
            [errorDetail setValue:NSLocalizedString(@"You are currently testing out \"Push Notifications\", with some restrictions.  Please check the iOS > Settings > Privacy menu.", @"Error - Push Notifications - Privacy - Provisional") forKey:NSLocalizedDescriptionKey];
            break;
        case 80002:
            [errorDetail setValue:NSLocalizedString(@"Access to your \"Push Notifications\" was previously denied.  Please check the iOS > Settings > Privacy menu.", @"Error - Push Notifications - Privacy - Denied") forKey:NSLocalizedDescriptionKey];
            break;
        case 80003:
            [errorDetail setValue:NSLocalizedString(@"You've chosen to not allow this application access to your \"Push Notifications\".  You can change your app settings in your profile page.", @"Error - Push Notifications - Privacy - Denied") forKey:NSLocalizedDescriptionKey];
            break;
            
        default:
            [errorDetail setValue:[NSString stringWithFormat:NSLocalizedString(@"Oops, something went wrong.  Please contact support. (%li)", @"Error - Default"), (long)resultCode] forKey:NSLocalizedDescriptionKey];
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

	return [NSError errorWithDomain:@"com.peoplepowerco.lib.Peoplepower" code:resultCode userInfo:errorDetail];
}

+ (NSDictionary *)processJSONResponse:(NSData *)responseData error:(NSError **)error {
    return [PPBaseModel processJSONResponse:responseData originatingClass:nil error:error];
}

+ (NSDictionary *)processJSONResponse:(NSData *)responseData originatingClass:(NSString *)originatingClass error:(NSError **)error {
    
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    if(responseString.length == 0) {
        return nil;
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
            return parsedObject;
        }
        else if(resultCode == 19 && [parsedObject objectForKey:@"lockTime"] && [parsedObject objectForKey:@"lockTimeout"]) {
            NSDate *lockTime = [NSDate dateWithTimeIntervalSince1970:[parsedObject[@"lockTime"] integerValue] / 1000];
            NSInteger lockTimeout = [parsedObject[@"lockTimeout"] integerValue] / 1000;
            NSInteger unlockTime = [[lockTime dateByAddingTimeInterval:lockTimeout] timeIntervalSinceNow];
            NSInteger seconds = unlockTime % 60;
            NSInteger minutes = (unlockTime / 60) % 60;
            NSInteger hours = unlockTime / 3600;
            NSMutableArray *timeArray = [[NSMutableArray alloc] initWithCapacity:3];
            
            if(hours > 0) {
                [timeArray addObject:[NSString stringWithFormat:NSLocalizedString(@"%02li hours", @""), hours]];
            }
            if(minutes > 0) {
                [timeArray addObject:[NSString stringWithFormat:NSLocalizedString(@"%02li minutes", @""), minutes]];
            }
            if(seconds > 0) {
                [timeArray addObject:[NSMutableString stringWithFormat:NSLocalizedString(@"%02li seconds", @""), seconds]];
            }
            
            NSMutableString *timeString = [[NSMutableString alloc] initWithCapacity:0];
            BOOL appendComma = NO;
            for(NSString *time in timeArray) {
                
                if(appendComma) {
                    [timeString appendString:NSLocalizedString(@", ", @"")];
                }
                if(time == [timeArray lastObject]) {
                    [timeString appendString:NSLocalizedString(@"and ", @"")];
                }
                [timeString appendString:time];
                if([timeArray count] > 2) {
                    appendComma = YES;
                }
            }
            NSString *argument;
            if (timeString != nil) {
                argument = [NSString stringWithFormat:NSLocalizedString(@"Try again in %@", @""), timeString];
            }
            *error = [PPBaseModel resultCodeToNSError:resultCode argument:argument];
        }
        else if(resultCodeMessage != nil && ![resultCodeMessage isEqualToString:@""]) {
            *error = [PPBaseModel resultCodeToNSError:resultCode originatingClass:originatingClass argument:resultCodeMessage];
        }
        else {
            *error = [PPBaseModel resultCodeToNSError:resultCode originatingClass:originatingClass];
        }
    }
    
    PPLogAPI(@"%@", [PPCurlDebug responseToDescription:parsedObject]);
    
    return parsedObject;
}

@end
