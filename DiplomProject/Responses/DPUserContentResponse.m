//
// Created by dmitrykorotchenkov on 20.01.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "DPUserContentResponse.h"
#import "RestKit.h"
#import "DPContentElement.h"


@implementation DPUserContentResponse

+ (RKObjectMapping *)mapping {
    RKObjectMapping *mapping = [super mapping];
    [mapping addAttributeMappingsFromDictionary:@{@"canAddToFriends" : @"canAddToFriends"}];
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"content"
                                                                            toKeyPath:@"content"
                                                                          withMapping:[DPContentElement mapping]]];
    return mapping;
}


@end