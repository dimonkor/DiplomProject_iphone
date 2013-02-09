//
// Created by dmitrykorotchenkov on 07.02.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "DPAbstractResponse.h"


@interface DPCommentsResponse : DPAbstractResponse

@property (nonatomic, strong) NSArray *comments;
@property (nonatomic, strong) NSNumber *count;

@end