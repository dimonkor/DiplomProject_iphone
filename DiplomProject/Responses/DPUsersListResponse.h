//
// Created by dmitrykorotchenkov on 24.01.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "DPAbstractResponse.h"


@interface DPUsersListResponse : DPAbstractResponse

@property (nonatomic, strong) NSArray *users;
@property (nonatomic, strong) NSNumber *count;

@end