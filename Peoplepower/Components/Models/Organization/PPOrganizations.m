//
//  PPOrganizations.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/8/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPOrganizations.h"
#import "PPCloudEngine.h"

@implementation PPOrganizations

__strong static PPOrganizations *_sharedObject = nil;

/**
 * Shared organizations across the entire application
 */
+ (PPOrganizations *)sharedOrganizations {
#ifdef DEBUG
    // Used this to see when our PPUser was getting overwritten
    //NSLog(@"PPUser is %@; Pro Security is %d", _sharedObject, _sharedObject.isProSecuritySubscriber);
#endif
    
    if(!_sharedObject) {
        _sharedObject = [[PPOrganizations alloc] initWithOrganizations:nil];
    }
    return _sharedObject;
}

- (id)initWithOrganizations:(NSArray *)organizations {
    self = [super init];
    if(self) {
        self.organizations = organizations;
    }
    return self;
}

/**
 * Get Organizations
 * Retrieve all organizations that match the given criteria
 *
 * @param organizationId PPOrganizationId Search field - Specific organization ID  to get information about
 * @param domainName NSString Search field - Exact domain name
 * @param name NSString Search field - First characters of organization name
 * @param callback PPOrganizationsBlock Array of available organizations
 **/
+ (void)getOrganizations:(PPOrganizationId)organizationId domainName:(NSString *)domainName name:(NSString *)name callback:(PPOrganizationsBlock)callback {
    NSMutableString *request = [NSMutableString stringWithString:@"organizations?"];
    
    if(organizationId != PPOrganizationIdNone) {
        [request appendFormat:@"organizationId=%li&", (long)organizationId];
    }
    if(domainName) {
        [request appendFormat:@"domainName=%@&", domainName];
    }
    if(name) {
        [request appendFormat:@"name=%@&", name];
    }
    
    // Create a custom admin cloud engine.  API key is not needed
    PPCloudEngine *adminEngine = [[PPCloudEngine alloc] initSingleton:PPCloudEngineTypeAdmin];
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.organizations.getOrganizations()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [adminEngine GET:request success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSMutableArray *organizations;
            
            if(!error) {
                organizations = [[NSMutableArray alloc] init];
                for(NSDictionary *organizationDict in [root objectForKey:@"organizations"]) {
                    PPOrganization *organization = [PPOrganization initWithDictionary:organizationDict];
                    [organizations addObject:organization];
                }
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(organizations, error);
            });
        });
    } failure:^(NSError *error) {
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@", error.userInfo]]);
            });
        });
    }];
}

/**
 * Get Organization groups.
 * Retrieve all organization groups that match the given criteria
 *
 * @param organizationId Required PPOrganizationId Organization ID or domain name
 * @param groupId PPOrganizationGroupId Search field - Group ID
 * @param name NSString Search field - First characters of group name
 * @param type PPOrganizationGroupType Search field - Group type
 * @param userTotals PPOrganizationUserTotals Request approved, applied and rejected group users
 * @param averageBills PPOrganizationAverageBills Request average monthly energy bill information (for specific group ID)
 * @param billsStartDate NSDate Monthly bill selected start date. By default it is the current date minus 400 days.
 * @param callback PPOrganizationGroupsBlock Array of available organization groups
 **/
+ (void)getGroups:(PPOrganizationId)organizationId groupId:(PPOrganizationGroupId)groupId name:(NSString *)name type:(PPOrganizationGroupType)type userTotals:(PPOrganizationUserTotals)userTotals averageBills:(PPOrganizationAverageBills)averageBills billsStartDate:(NSDate *)billsStartDate callback:(PPOrganizationsGroupsBlock)callback {
    NSMutableString *request = [NSMutableString stringWithFormat:@"organizations/%li/groups?", (long)organizationId];
    
    if(groupId != PPOrganizationGroupIdNone) {
        [request appendFormat:@"groupId=%li&", (long)groupId];
    }
    if(name) {
        [request appendFormat:@"name=%@&", [PPNSString stringByAddingURIPercentEscapesUsingEncoding:NSUTF8StringEncoding toString:name]];
    }
    if(type != PPOrganizationGroupTypeNone) {
        [request appendFormat:@"type=%li&", (long)type];
    }
    if(userTotals != PPOrganizationUserTotalsNone) {
        [request appendFormat:@"userTotals=%@&", (userTotals) ? @"true" : @"false"];
    }
    if(averageBills != PPOrganizationAverageBillsNone) {
        [request appendFormat:@"averageBills=%@&", (averageBills) ? @"true" : @"false"];
    }
    if(billsStartDate) {
        [request appendFormat:@"startDate=%@&", [PPNSString stringByAddingURIPercentEscapesUsingEncoding:NSUTF8StringEncoding toString:[PPNSDate apiFriendStringFromDate:billsStartDate]]];
    }
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.organizations.getGroups()", DISPATCH_QUEUE_SERIAL);
    [[PPCloudEngine sharedAdminEngine] setCompleteionQueue:queue];
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAdminEngine] GET:request success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSMutableArray *groups;
            
            if(!error) {
                groups = [[NSMutableArray alloc] init];
                for(NSDictionary *groupDict in [root objectForKey:@"groups"]) {
                    PPOrganizationGroup *group = [PPOrganizationGroup initWithDictionary:groupDict];
                    [groups addObject:group];
                }
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(groups, error);
            });
        });
    } failure:^(NSError *error) {
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@", error.userInfo]]);
            });
        });
    }];
}

/**
 * Add or Update user
 *
 * @param organizationId Required PPOrganizationId Organization to join
 * @param groupId PPOrganizationGroupId Organization group to join
 * @param status PPOrganizationStatus New status for these users
 * @param userId PPUserId User Id to add or update
 * @param notes NSString Notes to include
 *
 * @param callback PPOrganizationsUpdateUserBlock Update users callback block
 */
+ (void)joinOrganization:(PPOrganizationId)organizationId groupId:(PPOrganizationGroupId)groupId status:(PPOrganizationStatus)status userId:(PPUserId)userId notes:(NSString *)notes callback:(PPOrganizationsUpdateUserBlock)callback {
    NSMutableString *urlString = [NSMutableString stringWithFormat:@"organizations/%li/users/%li?", (long)organizationId, (long)userId];
    
    
    NSMutableString *JSONString = [NSMutableString stringWithFormat:@"{"];
    BOOL appendComma = NO;
    if(groupId) {
        [JSONString appendFormat:@"\"groupId\":\"%li\"", (long)groupId];
        appendComma = YES;
    }
    if(status != PPOrganizationStatusNone) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"status\":\"%li\"", (long)status];
        appendComma = YES;
    }
    if(notes) {
        if(appendComma) {
            [JSONString appendString:@","];
        }
        [JSONString appendFormat:@"\"notes\":\"%@\"", notes];
    }
    
    [JSONString appendString:@"}"];
    NSError *error;
    
    NSMutableURLRequest *request = [[[PPCloudEngine sharedAdminEngine] getRequestSerializer] requestWithMethod:@"PUT" URLString:[NSURL URLWithString:urlString relativeToURL:[[PPCloudEngine sharedAdminEngine] getBaseURL]].absoluteString parameters:nil error:&error];
    
    [request setHTTPBody:[JSONString dataUsingEncoding:NSUTF8StringEncoding]];
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.ioscore.organizations.joinOrganization()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    [[PPCloudEngine sharedAdminEngine] operationWithRequest:request success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPOrganizationStatus newStatus = PPOrganizationStatusNone;
            
            if(!error) {
                newStatus = (PPOrganizationStatus)((NSString *)[root objectForKey:@"status"]).integerValue;
            }
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(newStatus, error);
            });
        });
    } failure:^(NSError *error) {
        dispatch_async(queue, ^{
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(PPOrganizationStatusNone, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@", error.userInfo]]);
            });
        });
    }];
}

@end
