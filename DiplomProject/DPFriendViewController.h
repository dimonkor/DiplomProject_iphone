//
// Created by dmitrykorotchenkov on 21.01.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "DPRibbonViewController.h"

@class DPFriendContentService;
@class DPUser;
@class DPOperationWithFriendsService;


@interface DPFriendViewController : DPRibbonViewController

@property(nonatomic, strong)DPUser *userInfo;

@end