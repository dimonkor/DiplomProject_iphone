//
// Created by dmitrykorotchenkov on 24.01.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

static NSString *const kFriendCellID = @"friendTableCellID";

@class DPFriendsListService;
@class DPOperationWithFriendsService;

@interface DPFriendsListController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@end