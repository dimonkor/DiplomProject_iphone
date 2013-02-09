//
// Created by dmitrykorotchenkov on 09.02.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "DPUsersListController.h"
#import "DPUserTableCell.h"
#import "DPFriendViewController.h"



@implementation DPUsersListController

- (UITableViewCell *)getUserCell:(UITableView *)tableView forIndex:(NSUInteger)index {
    DPUserTableCell *cell = [tableView dequeueReusableCellWithIdentifier:kFriendCellID];
    if (!cell) {
        cell = [[DPUserTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kFriendCellID];
    }
    [cell fillWithUserInfo:[self.dataSource objectAtIndex:index]];
    return cell;
}

- (void)selectRow:(NSIndexPath *)indexPath {
    DPFriendViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"friendViewController"];
    controller.userInfo = self.dataSource[(NSUInteger) indexPath.row];
    [self.navigationController pushViewController:controller animated:YES];
}

@end