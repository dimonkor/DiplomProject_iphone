//
// Created by dmitrykorotchenkov on 20.01.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "DPHomeContentResponse.h"
#import "RestKit.h"
#import "DPContentElement.h"


@implementation DPHomeContentResponse

+ (RKObjectMapping *)mapping {
    RKObjectMapping *mapping = [super mapping];
    [mapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"content"
                                                                            toKeyPath:@"content"
                                                                          withMapping:[DPContentElement mapping]]];
    return mapping;
}


@end