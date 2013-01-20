//
// Created by dmitrykorotchenkov on 19.01.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "DPAbstractService.h"


@interface DPUpdateUserInfoService : DPAbstractService
- (void)sendNewUsername:(NSString *)newUsername;

- (void)sendNewUsername:(NSString *)newUsername avatar:(UIImage *)avatar;


@end