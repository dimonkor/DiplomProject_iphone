//
// Created by dmitrykorotchenkov on 24.01.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "DPUser.h"
#import "DPConstants.h"

@implementation DPUser

+(RKObjectMapping *)mapping{
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:self];
    [mapping addAttributeMappingsFromDictionary:@{
            @"username" : @"username",
            @"avatar_url" : @"avatarUrl",
            @"user_id" : @"userId"
    }];
    return mapping;
}

-(NSString *)avatarUrl{
    if (_avatarUrl.length>3)
        return [NSString stringWithFormat:@"%@/images/%@",API_PATH,_avatarUrl];
    else
        return nil;
}

@end