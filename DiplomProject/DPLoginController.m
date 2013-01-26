//
//  DPLoginController.m
//  DiplomProject
//
//  Created by Dmitry Korotchenkov on 23.12.12.
//  Copyright (c) 2012 home. All rights reserved.
//

#import "DPLoginController.h"
#import "DPAbstractResponse.h"
#import "DPAbstractService.h"
#import "DPLoginService.h"
#import "DPUserInfoResponse.h"
#import "DPApplication.h"
#import "DPUIUtils.h"
#import "DPRegisterService.h"
#import "DPUserInfo.h"
#import "DPConstants.h"
#import "DPUser.h"

@interface DPLoginController ()

@property(strong, nonatomic) IBOutlet UITextField *username;
@property(strong, nonatomic) IBOutlet UITextField *password;
@property(nonatomic, strong) DPLoginService *loginService;
@property(nonatomic, strong) DPRegisterService *registerService;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentController;


@end

@implementation DPLoginController

- (IBAction)done:(id)sender {

    __weak DPLoginController *weakSelf = self;
    void (^completionBlock)(DPUserInfoResponse *) = ^(DPUserInfoResponse *response) {
        [[DPApplication instance] loginUser:weakSelf.username.text password:weakSelf.password.text];
        [DPUserInfo setUsername:response.userInfo.username avatarImageName:response.userInfo.avatarUrl];
        hideHUD();
        [DPUIUtils appWindow].rootViewController = [self.storyboard instantiateViewControllerWithIdentifier:mainTabBarControllerID];
        if (self.segmentController.selectedSegmentIndex == 1){
            [DPUIUtils showMessage:@"Пожалуйста заполните информацию о себе" withTitle:@"Инфо"];
        }

    };

    if (self.segmentController.selectedSegmentIndex == 0){
        self.loginService = [[DPLoginService alloc] init];
        self.loginService.completionBlock = completionBlock;
        showHUD();
        [self.loginService sendUser:self.username.text password:self.password.text];
    }
    else{
        self.registerService = [[DPRegisterService alloc] init];
        self.registerService.completionBlock = completionBlock;
        showHUD();
        [self.registerService sendUser:self.username.text password:self.password.text];
    }




}

@end
