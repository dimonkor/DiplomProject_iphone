//
// Created by dmitrykorotchenkov on 26.12.12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "DPLoginResponse.h"
#import "RestKit.h"


@implementation DPLoginResponse

+ (RKObjectMapping *)mapping {
    RKObjectMapping *mapping = [super mapping];
    [mapping addAttributeMappingsFromDictionary:@{
            @"content.firstname" : @"firstName",
            @"content.lastname" : @"lastName"
    }];
    return mapping;
}


@end