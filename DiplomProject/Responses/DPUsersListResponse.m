//
// Created by dmitrykorotchenkov on 24.01.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "DPUsersListResponse.h"
#import "RestKit.h"
#import "DPUser.h"


@implementation DPUsersListResponse

+ (RKObjectMapping *)mapping {
    RKObjectMapping *mapping = [super mapping];
    [mapping addAttributeMappingsFromArray:@[@"count"]];
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"content"
                                                                            toKeyPath:@"users"
                                                                          withMapping:[DPUser mapping]]];
    return mapping;
}

@end