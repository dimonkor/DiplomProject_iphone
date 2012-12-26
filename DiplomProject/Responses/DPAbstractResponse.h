//
// Created by dmitrykorotchenkov on 23.12.12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@class RKObjectMapping;


@interface DPAbstractResponse : NSObject

@property(nonatomic, strong) NSNumber *success;
@property(nonatomic, strong) NSString *error;

+ (RKObjectMapping *)mapping;

- (BOOL)hasError;


@end