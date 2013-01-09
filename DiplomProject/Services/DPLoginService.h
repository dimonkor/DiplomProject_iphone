//
// Created by dmitrykorotchenkov on 26.12.12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "DPAbstractService.h"


@interface DPLoginService : DPAbstractService
- (void)sendUser:(NSString *)user password:(NSString *)password;

@end