//
// Created by dmitrykorotchenkov on 09.02.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

static NSString *const kFriendCellID = @"friendTableCellID";

@interface DPUsersListController : UIViewController

@property(nonatomic, strong) NSArray *dataSource;

- (UITableViewCell *)getUserCell:(UITableView *)tableView forIndex:(NSUInteger)index1;

- (void)selectRow:(NSIndexPath *)indexPath;


@end