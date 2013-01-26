//
// Created by dmitrykorotchenkov on 26.01.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "DPAbstractService.h"


@interface DPSearchUsersService : DPAbstractService
- (void)searchString:(NSString *)string;

@end