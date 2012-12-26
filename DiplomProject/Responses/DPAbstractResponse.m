//
// Created by dmitrykorotchenkov on 23.12.12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "DPAbstractResponse.h"
#import "RestKit.h"


@implementation DPAbstractResponse

+ (RKObjectMapping *)mapping {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:self];
    [mapping addAttributeMappingsFromArray:@[@"error", @"success"]];
    return mapping;
}

-(BOOL)hasError{
    if (self.error)
        return YES;
    else
        return NO;
}

@end