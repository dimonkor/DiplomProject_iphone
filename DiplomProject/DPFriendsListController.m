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
@property(strong, nonatomic) IBOutlet UITableViewCell *listenerCell;
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
        [weakSelf.tableView reloadData];
    };
    showHUD();
    [self.service getFriends];
}


- (UITableView *)tableView {
    return (UITableView *) self.view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0)
        return 1;
    else
        return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0)
        return self.listenerCell;
    else {
        NSUInteger index = (NSUInteger) indexPath.row;
        return [self getUserCell:tableView forIndex:index];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        [self performSegueWithIdentifier:@"listenersSegueID" sender:self];
    }
    else {
        [self selectRow:indexPath];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0)
        return NO;
    else
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


- (void)viewDidUnload {
    [self setListenerCell:nil];
    [super viewDidUnload];
}
@end