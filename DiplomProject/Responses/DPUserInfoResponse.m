//
// Created by dmitrykorotchenkov on 26.12.12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "DPUserInfoResponse.h"
#import "RestKit.h"


@implementation DPUserInfoResponse

+ (RKObjectMapping *)mapping {
    RKObjectMapping *mapping = [super mapping];
    [mapping addAttributeMappingsFromDictionary:@{
            @"content.username" : @"username",
            @"content.avatar_url" : @"avatar_url"
    }];
    return mapping;
}


@end