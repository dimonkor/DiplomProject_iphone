//
// Created by dmitrykorotchenkov on 21.01.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "DPFriendViewController.h"
#import "DPFriendContentService.h"
#import "DPUserContentResponse.h"
#import "DPHeaderTableCell.h"
#import "DPContentElement.h"
#import "DPUser.h"
#import "DPOperationWithFriendsService.h"
#import "DPUIUtils.h"


@interface DPFriendViewController ()
@property(nonatomic, strong) DPFriendContentService *service;
@property(nonatomic, strong) DPOperationWithFriendsService *addFriendService;


@end

@implementation DPFriendViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }

    return self;
}


- (void)viewWillAppear:(BOOL)animated {
    if (self.userInfo){
        self.service = [[DPFriendContentService alloc] init];
        __weak DPFriendViewController *weakSelf = self;
        self.service.completionBlock = ^(DPUserContentResponse *response) {
            if (response.canAddToFriends.boolValue){
                weakSelf.navigationItem.rightBarButtonItem.enabled = YES;
            }
            weakSelf.dataSource = response.content;
            [weakSelf.tableView reloadData];
        };
        [self.service getUserContentForID:self.userInfo.userId.intValue];
    }
}
- (IBAction)addFriend:(id)sender {
    self.addFriendService = [[DPOperationWithFriendsService alloc] init];
    __weak DPFriendViewController *weakSelf = self;
    self.addFriendService.completionBlock = ^(DPAbstractResponse *response){
        weakSelf.navigationItem.rightBarButtonItem.enabled = NO;
        hideHUD();
    };
    showHUD();
    [self.addFriendService addFriend:self.userInfo.userId];
}

- (DPHeaderTableCell *)getHeaderCell {
    [self.headerTableCell fillWithName:self.userInfo.username avatarUrl:self.userInfo.avatarUrl];
    return self.headerTableCell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.headerTableCell)
        return [super tableView:tableView numberOfRowsInSection:section];
    else{
        return 0;
    }
}


@end