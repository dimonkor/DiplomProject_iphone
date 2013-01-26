//
// Created by dmitrykorotchenkov on 21.01.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "DPAbstractService.h"


@interface DPFriendContentService : DPAbstractService
- (void)getUserContentForID:(NSInteger)userID;

@end