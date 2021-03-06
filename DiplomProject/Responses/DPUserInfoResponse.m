//
// Created by dmitrykorotchenkov on 26.12.12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "DPUserInfoResponse.h"
#import "RestKit.h"
#import "DPUser.h"


@implementation DPUserInfoResponse

+ (RKObjectMapping *)mapping {
    RKObjectMapping *mapping = [super mapping];
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"content"
                                                                            toKeyPath:@"userInfo"
                                                                          withMapping:[DPUser mapping]]];
    return mapping;
}


@end