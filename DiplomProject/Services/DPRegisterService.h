//
// Created by dmitrykorotchenkov on 19.01.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "DPAbstractService.h"


@interface DPRegisterService : DPAbstractService
- (void)sendUser:(NSString *)user password:(NSString *)password;

@end