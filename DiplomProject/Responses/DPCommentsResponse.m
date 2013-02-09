//
// Created by dmitrykorotchenkov on 07.02.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "DPCommentsResponse.h"
#import "RestKit.h"
#import "DPComment.h"


@implementation DPCommentsResponse

+ (RKObjectMapping *)mapping {
    RKObjectMapping *mapping = [super mapping];
    [mapping addAttributeMappingsFromDictionary:@{@"count" : @"count"}];
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"content"
                                                                            toKeyPath:@"comments"
                                                                          withMapping:[DPComment mapping]]];
    return mapping;
}


@end