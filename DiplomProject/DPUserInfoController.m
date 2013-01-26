//
// Created by dmitrykorotchenkov on 19.01.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "DPUserInfoController.h"
#import "TTURLRequest.h"
#import "UIViewAdditions.h"
#import "DPUserInfo.h"
#import "DPUIUtils.h"
#import "DPApplication.h"
#import "DPUpdateUserInfoService.h"
#import "DPAbstractResponse.h"
#import "DPUserInfoResponse.h"
#import "TTImageViewInternal.h"
#import "DPConstants.h"
#import "DPUser.h"

@interface DPUserInfoController ()

@property(strong, nonatomic) IBOutlet UIView *avatarViewHolder;
@property(strong, nonatomic) IBOutlet UITextField *textField;
@property(nonatomic, strong) DPUpdateUserInfoService *userInfoService;
@property(nonatomic, strong) TTImageView *imageView;
@property(nonatomic) BOOL isNeedUpdateAvatar;

@end

@implementation DPUserInfoController


- (void)loadView {
    [super loadView];
    CGSize size = self.avatarViewHolder.frame.size;
    self.imageView = [[TTImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    self.imageView.defaultImage = [UIImage imageNamed:@"default_avatar_image.jpeg"];
    self.imageView.delegate = self;
    [self.imageView setUrlPath:DPUserInfo.avatarUrl];
    [self.avatarViewHolder addSubview:self.imageView];
    self.textField.text = [DPUserInfo userName];
    self.textField.delegate = self;
    self.textField.returnKeyType = UIReturnKeyDone;

    [self.avatarViewHolder addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(choicePhoto)]];
}

- (void)choicePhoto {
    [super choicePhoto:YES];
}


- (void)didFinishPickingImage:(UIImage *)image {
    [self.imageView setImage:image];
    self.isNeedUpdateAvatar = YES;
}


- (void)imageView:(TTImageView *)imageView didLoadImage:(UIImage *)image {
    if (image.size.width / image.size.height > self.avatarViewHolder.size.width / self.avatarViewHolder.size.height) {
        imageView.height = self.avatarViewHolder.size.width / image.size.width * image.size.height;
        imageView.width = self.avatarViewHolder.width;
    } else {
        imageView.width = self.avatarViewHolder.size.height / image.size.height * image.size.width;
        imageView.height = self.avatarViewHolder.height;
    }
    CGSize size = self.avatarViewHolder.frame.size;
    [imageView setCenter:CGPointMake(size.width / 2, size.height / 2)];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

- (IBAction)saveInfo:(id)sender {
    [self.textField resignFirstResponder];
    if (YES) {

        if (!self.userInfoService) {
            self.userInfoService = [[DPUpdateUserInfoService alloc] init];
        }
        self.userInfoService.completionBlock = ^(DPUserInfoResponse *response) {
            self.isNeedUpdateAvatar = NO;
            [DPUserInfo setUsername:response.userInfo.username avatarImageName:response.userInfo.avatarUrl];
            hideHUD();
        };
        showHUD();
        if (self.isNeedUpdateAvatar) {
            [self.userInfoService sendNewUsername:self.textField.text avatar:self.imageView.image];
        }
        else {
            [self.userInfoService sendNewUsername:self.textField.text];
        }

    }
}

- (IBAction)signOut:(id)sender {
    [[DPApplication instance] signOut];
    [DPUIUtils appWindow].rootViewController = [self.storyboard instantiateViewControllerWithIdentifier:loginControllerID];
}


- (void)viewDidUnload {
    [self setAvatarViewHolder:nil];
    [self setTextField:nil];
    [super viewDidUnload];
}
@end