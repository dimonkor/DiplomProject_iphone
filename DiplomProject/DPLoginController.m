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
#import "DPLoginResponse.h"

@interface DPLoginController ()

@property(strong, nonatomic) IBOutlet UITextField *username;
@property(strong, nonatomic) IBOutlet UITextField *password;
@property(nonatomic, strong) DPLoginService *service;


@end

@implementation DPLoginController

- (IBAction)done:(id)sender {
    
    self.service = [[DPLoginService alloc] init];
    self.service.completionBlock = ^(DPAbstractResponse *response){
        DPLoginResponse *castedResponse = (DPLoginResponse *) response;
//        [self performSegueWithIdentifier:@"gotoMainView" sender:self];
    };

    [self.service sendUser:self.username.text password:self.password.text];


}

@end
