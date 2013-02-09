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
#import "DPCommentsController.h"

static NSString *const kForAllBtn = @"Всех";

static NSString *const kForFriendsBtn = @"Друзей";

@interface DPRibbonViewController ()

@property(nonatomic, strong) DPGetHomeContentService *service;

@property(nonatomic, strong) DPSendImageService *sendImageService;
@property(nonatomic, strong) UIImage *image;
@property(nonatomic, strong) UIActionSheet *actionSheet;


@end

@implementation DPRibbonViewController

- (void)viewWillAppear:(BOOL)animated {
    [self updateContent];
}

- (void)updateContent {
    self.service = self.service ? : [[DPGetHomeContentService alloc] init];
    __weak DPRibbonViewController *weakSelf = self;
    self.service.completionBlock = ^(DPAbstractResponse *response) {
        hideHUD();
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
    self.image = image;
    self.actionSheet = [[UIActionSheet alloc] initWithTitle:@"Фотография доступна для"
                                                   delegate:self
                                          cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:kForAllBtn, kForFriendsBtn, nil];
    [self.actionSheet showFromRect:CGRectZero inView:[DPUIUtils appWindow] animated:YES];


}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ([actionSheet isEqual:self.actionSheet]) {

        if ([[DPApplication instance] isLogin]) {
            self.sendImageService = self.sendImageService ? : [[DPSendImageService alloc] init];
            __weak DPRibbonViewController *weakSelf = self;
            self.sendImageService.completionBlock = ^(DPSendImageResponse *response) {
                hideHUD();
                hideHUD();
                NSLog(response.thumbnailUrl);
                [weakSelf updateContent];
            };
            showHUD();
            NSString *const clickedButton = [actionSheet buttonTitleAtIndex:buttonIndex];
            if ([clickedButton isEqualToString:kForAllBtn]) {
                [self.sendImageService sendImage:self.image forFriends:NO];
            } else if ([clickedButton isEqualToString:kForFriendsBtn]) {
                [self.sendImageService sendImage:self.image forFriends:YES];
            }
        } else {
            [DPUIUtils showError:@"Пожалуйста пройдите заново авторизацию в приложении"];
        }

    } else {
        [super actionSheet:actionSheet clickedButtonAtIndex:buttonIndex];
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

- (void)didSelectPhoto:(NSNumber *)photoId {
    DPCommentsController *commentsController = [self.storyboard instantiateViewControllerWithIdentifier:@"commentcControllerID"];
    commentsController.photo_id = photoId;
    [self.navigationController pushViewController:commentsController animated:YES];

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