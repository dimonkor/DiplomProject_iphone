//
// Created by dmitrykorotchenkov on 09.02.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "DPListenersController.h"
#import "DPFriendsListService.h"
#import "DPUIUtils.h"
#import "DPUsersListResponse.h"
#import "DPFriendsListController.h"


@interface DPListenersController ()
@property(nonatomic, strong) DPFriendsListService *service;

@end

@implementation DPListenersController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.service = self.service ? : [[DPFriendsListService alloc] init];
    __weak DPListenersController *weakSelf = self;
    self.service.completionBlock = ^(DPUsersListResponse *response) {
        hideHUD();
        weakSelf.dataSource = response.users;
        [weakSelf.tableView reloadData];
    };
    showHUD();
    [self.service getListeners];
}

- (UITableView *)tableView {
    return (UITableView *) self.view;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger index = (NSUInteger) indexPath.row;
    return [self getUserCell:tableView forIndex:index];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self selectRow:indexPath];
}

@end