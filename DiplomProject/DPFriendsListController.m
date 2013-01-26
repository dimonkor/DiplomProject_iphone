//
// Created by dmitrykorotchenkov on 24.01.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "DPFriendsListController.h"
#import "DPFriendsListService.h"
#import "DPAbstractResponse.h"
#import "DPUsersListResponse.h"
#import "DPUserTableCell.h"
#import "DPUser.h"
#import "DPUIUtils.h"
#import "DPFriendViewController.h"
#import "DPOperationWithFriendsService.h"

@interface DPFriendsListController ()
@property(nonatomic, strong) DPFriendsListService *service;
@property(nonatomic, strong) NSArray *dataSource;
@property(nonatomic, strong) DPOperationWithFriendsService *deleteFriendService;


@end

@implementation DPFriendsListController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.service = self.service ? : [[DPFriendsListService alloc] init];
    __weak DPFriendsListController *weakSelf = self;
    self.service.completionBlock = ^(DPUsersListResponse *response) {
        hideHUD();
        weakSelf.dataSource = response.users;
        [(UITableView *) weakSelf.view reloadData];
    };
    showHUD();
    [self.service getFriends];
}


- (UITableView *)tableView {
    return (UITableView *) self.view;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DPUserTableCell *cell = [tableView dequeueReusableCellWithIdentifier:kFriendCellID];
    if (!cell) {
        cell = [[DPUserTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kFriendCellID];
    }
    [cell fillWithUserInfo:[self.dataSource objectAtIndex:(NSUInteger) indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DPFriendViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"friendViewController"];
    controller.userInfo = self.dataSource[(NSUInteger) indexPath.row];
    [self.navigationController pushViewController:controller animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    self.deleteFriendService = [[DPOperationWithFriendsService alloc] init];
    __weak DPFriendsListController *weakSelf = self;
    self.deleteFriendService.completionBlock = ^(DPAbstractResponse *response) {
        NSMutableArray *tmpArray = [weakSelf.dataSource mutableCopy];
        [tmpArray removeObjectAtIndex:(NSUInteger) indexPath.row];
        weakSelf.dataSource = [NSArray arrayWithArray:tmpArray];
        [weakSelf.tableView reloadData];
        hideHUD();
    };
    showHUD();
    DPUser *user = self.dataSource[(NSUInteger) indexPath.row];
    [self.deleteFriendService deleteFriend:user.userId];

}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCellEditingStyle result = UITableViewCellEditingStyleDelete;
    return result;
}


@end