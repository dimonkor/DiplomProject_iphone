//
//  DPMainViewController.m
//  DiplomProject
//
//  Created by Dmitry Korotchenkov on 06.12.12.
//  Copyright (c) 2012 home. All rights reserved.
//

#import "DPMainViewController.h"
#import "RestKit.h"
#import "DPUIUtils.h"
#import "DPSendImageService.h"
#import "DPAbstractResponse.h"
#import "DPSendImageResponse.h"
#import "DPApplication.h"

@interface DPMainViewController ()
@property(nonatomic, strong) DPSendImageService *service;


@end

@implementation DPMainViewController

- (IBAction)choisePhoto {
    [super choicePhoto:NO];
}


- (void)didFinishPickingImage:(UIImage *)image {
    if ([[DPApplication instance] isLogin]) {
        self.service = [[DPSendImageService alloc] init];
        self.service.completionBlock = ^(DPAbstractResponse *response) {
            DPSendImageResponse *castedResponse = (DPSendImageResponse *) response;
            NSLog(castedResponse.thumbnailUrl);
            hideHUD();
        };
        showHUD();
        [self.service sendImage:image];
    } else {
        [DPUIUtils showError:@"Пожалуйста пройдите заново авторизацию в приложении"];
    }
}


@end
