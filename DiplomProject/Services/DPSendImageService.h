//
// Created by dmitrykorotchenkov on 13.01.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "DPAbstractService.h"


@interface DPSendImageService : DPAbstractService
- (void)sendImage:(UIImage *)image forFriends:(BOOL)forFriends;

@end