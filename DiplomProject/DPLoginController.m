//
//  DPLoginController.m
//  DiplomProject
//
//  Created by Dmitry Korotchenkov on 23.12.12.
//  Copyright (c) 2012 home. All rights reserved.
//

#import "DPLoginController.h"
#import "AFHTTPClient.h"
#import "DPUIUtils.h"
#import "DPAbstractResponse.h"
#import "RestKit.h"
#import "DPAbstractService.h"
#import "DPAbstractService.h"

@interface DPLoginController ()

@property(strong, nonatomic) IBOutlet UITextField *username;
@property(strong, nonatomic) IBOutlet UITextField *password;
@property(nonatomic, strong) DPAbstractService *service;


@end

@implementation DPLoginController

- (IBAction)done:(id)sender {
    
    self.service = [[DPAbstractService alloc] init];
    self.service.completionBlock = ^(DPAbstractResponse *response){
        NSLog(@"complete");
    };

    [self.service sendRequest:@{@"qwe":@"dfsdf"} responseClass:[DPAbstractResponse class]];


}

@end
