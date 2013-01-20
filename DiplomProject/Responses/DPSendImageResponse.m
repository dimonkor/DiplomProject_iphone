//
// Created by dmitrykorotchenkov on 17.01.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "DPSendImageResponse.h"
#import "RestKit.h"
#import "DPConstants.h"

@implementation DPSendImageResponse

+ (RKObjectMapping *)mapping {
    RKObjectMapping *mapping = [super mapping];
    [mapping addAttributeMappingsFromDictionary:@{@"content.url" : @"url"}];
    return mapping;
}

- (NSString *)originalUrl {
    return [NSString stringWithFormat:@"%@/images/original/%@", API_PATH, self.url];
}

- (NSString *)thumbnailUrl {
    return [NSString stringWithFormat:@"%@/images/thumbnail/%@", API_PATH, self.url];
}


@end