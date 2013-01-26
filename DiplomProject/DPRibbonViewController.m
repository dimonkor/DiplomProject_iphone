//
// Created by dmitrykorotchenkov on 20.01.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "DPRibbonViewController.h"
#import "DPHeaderTableCell.h"
#import "UIViewAdditions.h"
#import "DPContentElementTableCell.h"
#import "DPUserInfo.h"
#import "DPGetHomeContentService.h"
#import "DPAbstractResponse.h"
#import "DPUserContentResponse.h"
#import "DPContentElement.h"
#import "DPFriendViewController.h"
#import "DPUser.h"
#import "DPUIUtils.h"
#import "DPApplication.h"
#import "DPSendImageService.h"
#import "DPSendImageResponse.h"

@interface DPRibbonViewController ()

@property(nonatomic, strong) DPGetHomeContentService *service;

@property(nonatomic, strong) DPSendImageService *sendImageService;


@end

@implementation DPRibbonViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateContent];
}

- (void)updateContent {
    self.service = [[DPGetHomeContentService alloc] init];
    __weak DPRibbonViewController *weakSelf = self;
    self.service.completionBlock = ^(DPAbstractResponse *response) {
        DPUserContentResponse *castedResponse = (DPUserContentResponse *) response;
        weakSelf.dataSource = castedResponse.content;
        [weakSelf.tableView reloadData];
        hideHUD();
    };
    showHUD();
    [self.service getHomeContent];
}

- (IBAction)choisePhoto {
    [super choicePhoto:NO];
}


- (void)didFinishPickingImage:(UIImage *)image {
    if ([[DPApplication instance] isLogin]) {
        self.sendImageService = self.sendImageService ? : [[DPSendImageService alloc] init];
        __weak DPRibbonViewController *weakSelf = self;
        self.sendImageService.completionBlock = ^(DPSendImageResponse *response) {
            hideHUD();
            NSLog(response.thumbnailUrl);
            [weakSelf updateContent];
        };
        showHUD();
        [self.sendImageService sendImage:image];
    } else {
        [DPUIUtils showError:@"Пожалуйста пройдите заново авторизацию в приложении"];
    }
}

- (void)didSelectElement:(DPContentElement *)element {
    if (![self isMemberOfClass:[DPFriendViewController class]]) {
        DPFriendViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"friendViewController"];
        DPUser *user = [[DPUser alloc] init];
        user.avatarUrl = element.avatar_url;
        user.username = element.username;
        user.userId = element.user_id;
        controller.userInfo = user;
        [self.navigationController pushViewController:controller animated:YES];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.dataSource && self.dataSource.count > 0)
        return 2;
    else
        return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0)
        return 1;
    else
        return self.dataSource.count;
}

- (DPHeaderTableCell *)getHeaderCell {
    [self.headerTableCell fillWithName:[DPUserInfo userName] avatarUrl:[DPUserInfo avatarUrl]];
    return self.headerTableCell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return self.getHeaderCell;
    }
    else {
        DPContentElementTableCell *cell = [tableView dequeueReusableCellWithIdentifier:kContentElementCellID];
        cell = cell ? : [[DPContentElementTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kContentElementCellID];
        [cell fillWithElement:self.dataSource[(NSUInteger) indexPath.row] ribbonController:self];
        return cell;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0)
        return self.headerTableCell.height;
    else
        return ((DPContentElement *) self.dataSource[(NSUInteger) indexPath.row]).thumbnailSize.height + 70 + 10;

}


- (void)viewDidUnload {
    [self setTableView:nil];
    [super viewDidUnload];
}
@end