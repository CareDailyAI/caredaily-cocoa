//
//  RLMObject+PPExtras.m
//  Peoplepower
//
//  Created by Destry Teeter on 6/5/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "RLMObject+PPExtras.h"

@implementation RLMObject (PPExtras)

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *headerDictionary = [NSMutableDictionary dictionary];
    RLMObjectSchema *schema = self.objectSchema;
    for (RLMProperty *property in schema.properties) {
        if([self[property.name] isKindOfClass:[RLMArray class]]){
            NSMutableArray *arrayObjects = [[NSMutableArray alloc] init];
            RLMArray *currentArray = self[property.name];
            NSInteger numElements = [currentArray count];
            for(int i = 0; i<numElements; i++){
                [arrayObjects addObject:[[currentArray objectAtIndex:i] dictionaryRepresentation]];
            }
            headerDictionary[property.name] = arrayObjects;
        }else if([self[property.name] isKindOfClass:[RLMObject class]]){
            RLMObject *currentElement = self[property.name];
            headerDictionary[property.name] = [currentElement dictionaryRepresentation];
        }else{
            headerDictionary[property.name] = self[property.name];
        }
        
    }
    return headerDictionary;
}

@end
