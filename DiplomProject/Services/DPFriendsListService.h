//
// Created by dmitrykorotchenkov on 24.01.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "DPAbstractService.h"


@interface DPFriendsListService : DPAbstractService
- (void)getFriends;

- (void)getSuggestions;

- (void)getListeners;


@end