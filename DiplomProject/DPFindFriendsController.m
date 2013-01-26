//
// Created by dmitrykorotchenkov on 26.01.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "DPFindFriendsController.h"
#import "DPFriendsListService.h"
#import "DPUsersListResponse.h"
#import "DPUIUtils.h"
#import "DPUserTableCell.h"
#import "DPFriendsListController.h"
#import "DPFriendViewController.h"
#import "DPUser.h"
#import "DPContentElement.h"
#import "DPSearchUsersService.h"

@interface DPFindFriendsController ()

@property(nonatomic, strong) NSArray *dataSource;
@property(nonatomic, strong) NSArray *searchDataSource;
@property(nonatomic, strong) DPFriendsListService *service;
@property(nonatomic, strong) DPSearchUsersService *searchService;


@end

@implementation DPFindFriendsController

- (UITableView *)tableView {
    return (UITableView *) self.view;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.service = self.service ? : [[DPFriendsListService alloc] init];
    __weak DPFindFriendsController *weakSelf = self;
    self.service.completionBlock = ^(DPUsersListResponse *response) {
        hideHUD();
        weakSelf.dataSource = response.users;
        [self.tableView reloadData];
    };
    showHUD();
    self.searchService = [[DPSearchUsersService alloc] init];
    [self.service getSuggestions];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([tableView isEqual:self.tableView])
        return self.dataSource.count;
    else
        return self.searchDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DPUserTableCell *cell = [tableView dequeueReusableCellWithIdentifier:kFriendCellID];
    if (!cell) {
        cell = [[DPUserTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kFriendCellID];
    }
    if ([tableView isEqual:self.tableView]) {
        [cell fillWithUserInfo:[self.dataSource objectAtIndex:(NSUInteger) indexPath.row]];
    }
    else {
        [cell fillWithUserInfo:[self.searchDataSource objectAtIndex:(NSUInteger) indexPath.row]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DPFriendViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"friendViewController"];
    if (tableView == self.tableView) {
        controller.userInfo = self.dataSource[(NSUInteger) indexPath.row];
    } else {
        controller.userInfo = self.searchDataSource[(NSUInteger) indexPath.row];
    }
    [self.navigationController pushViewController:controller animated:YES];
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {

    if (searchString.length > 0) {
        [self.searchService cancel];

        __weak DPFindFriendsController *weakSelf = self;
        self.searchService.completionBlock = ^(DPUsersListResponse *response) {
            weakSelf.searchDataSource = response.users;
            [weakSelf.searchDisplayController.searchResultsTableView reloadData];
        };
        [self.searchService searchString:searchString];
    }


    return NO;
}


- (void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller {
    self.searchDisplayController.searchResultsTableView.rowHeight = 70;
}

- (void)searchDisplayControllerDidBeginSearch:(UISearchDisplayController *)controller {
    NSLog(@"dfsdf");
}


- (void)viewDidUnload {
    [super viewDidUnload];
}
@end