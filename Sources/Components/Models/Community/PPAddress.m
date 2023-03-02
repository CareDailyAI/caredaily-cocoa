//
//  PPAddress.m
//  Peoplepower
//
//  Created by Destry Teeter on 1/21/20.
//  Copyright © 2023 People Power Company. All rights reserved.
//

#import "PPAddress.h"

@implementation PPAddress

- (id)initWithStreet1:(NSString *)street1
              street2:(NSString *)street2
                 city:(NSString *)city
                state:(PPState *)state
              country:(PPCountry *)country
                  zip:(NSString *)zip {
    self = [super init];
    if(self) {
        self.street1 = street1;
        self.street2 = street2;
        self.city = city;
        self.state = state;
        self.country = country;
        self.zip = zip;
    }
    return self;
}

+ (PPAddress *)initWithDictionary:(NSDictionary *)addressDict {
    NSString *street1 = [addressDict objectForKey:@"addrStreet1"];
    NSString *street2 = [addressDict objectForKey:@"addrStreet2"];
    NSString *city = [addressDict objectForKey:@"addrCity"];
    PPState *state = [PPState initWithDictionary:[addressDict objectForKey:@"state"]];
    PPCountry *country = [PPCountry initWithDictionary:[addressDict objectForKey:@"country"]];
    NSString *zip = [addressDict objectForKey:@"zip"];
    
    PPAddress *address = [[PPAddress alloc] initWithStreet1:street1
                                                    street2:street2
                                                       city:city
                                                      state:state
                                                    country:country
                                                        zip:zip];
    return address;
}

+ (NSDictionary *)dataFromAddress:(PPAddress *)address {
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithCapacity:0];
    if (address.street1) {
        [data setValue:address.street1 forKey:@"addrStreet1"];
    }
    
    if (address.street2) {
        [data setValue:address.street2 forKey:@"addrStreet2"];
    }
    if (address.city) {
        [data setValue:address.city forKey:@"addrCity"];
    }
    if (address.state.stateId != PPStateIdNone) {
        [data setValue:@{@"id":@(address.state.stateId)} forKey:@"state"];
    }
    if (address.country.countryId != PPCountryIdNone) {
        [data setValue:@{@"id":@(address.country.countryId)} forKey:@"country"];
    }
    if (address.zip) {
        [data setValue:address.zip forKey:@"zip"];
    }
    if (data.allKeys.count == 0) {
        data = nil;
    }
    return data;
}

@end
