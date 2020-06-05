//
//  PPVersion.m
//  Peoplepower
//
//  Copyright (c) 2020 People Power. All rights reserved.
//

#import "PPVersion.h"

@implementation PPVersion

+ (PPVersion *)myVersion {
	NSDictionary* infoDict = [[NSBundle mainBundle] infoDictionary];
	return [[PPVersion alloc] initWithVersion:[infoDict objectForKey:@"CFBundleShortVersionString"]];
}

- (id)initWithVersion:(NSString *)versionString {
	self = [super init];
	if(self) {
		NSArray *chunks = [versionString componentsSeparatedByString:@"."];
		
		if (chunks.count >= 1) {
			_major = [[chunks objectAtIndex:0] intValue];
		}
		
		if (chunks.count >= 2) {
			_minor = [[chunks objectAtIndex:1] intValue];
		}
		
		if (chunks.count >= 3) {
			_build = [[chunks objectAtIndex:2] intValue];
		}
		
		if (chunks.count >= 4) {
			_commit = [chunks objectAtIndex:3];
		}
	}
	
	return self;
}


/**
 * @return YES if this version instance is older than the current version of this app
 */
- (BOOL)isOlderThanMyVersion {
	PPVersion *myVersion = [PPVersion myVersion];
	return [self isOlderThan:myVersion];
}

/**
 * @return YES if this version instance is older than the given version argument
 */
- (BOOL) isOlderThan:(PPVersion *)version {
	if(version.major > _major) {
		return YES;
	}
	
	if(version.minor > _minor) {
		return YES;
	}
	
	if(version.build > _build) {
		return YES;
	}
	
	return NO;
}

/**
 * @return YES if this version instance is newer than the current version of this app
 */
- (BOOL)isNewerThanMyVersion {
	PPVersion *myVersion = [PPVersion myVersion];
	return [self isNewerThan:myVersion];
}

/**
 * @return YES if this version instance is newer than the given version argument
 */
- (BOOL)isNewerThan:(PPVersion *)version {
	if(version.major > _major) {
		return NO;
	}
	
	if(version.minor > _minor) {
		return NO;
	}
	
	if(version.build > _build) {
		return NO;
	}
	
	if(version.major == _major && version.minor == _minor && version.build == _build) {
		return NO;
	}
	
	return YES;
}

- (BOOL)isNewerThanOrEqualTo:(PPVersion *)version {
	if(version.major > _major) {
		return NO;
	}
	
	if(version.minor > _minor) {
		return NO;
	}
	
	if(version.build > _build) {
		return NO;
	}
	
	return YES;
}


- (NSString *)toNSString {
	NSString *versionString = [NSString stringWithFormat:@"%ld.%ld.%ld", (long)_major, (long)_minor, (long)_build];
	if(_commit != nil) {
		versionString = [versionString stringByAppendingString:[NSString stringWithFormat:@".%@", _commit]];
	}
	return versionString;
}


@end
