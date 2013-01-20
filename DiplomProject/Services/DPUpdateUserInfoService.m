//
// Created by dmitrykorotchenkov on 19.01.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "DPUpdateUserInfoService.h"
#import "DPUserInfoResponse.h"
#import "DPApplication.h"


@implementation DPUpdateUserInfoService

- (void)sendNewUsername:(NSString *)newUsername {
    [self sendNewUsername:newUsername avatar:nil];
}

- (void)sendNewUsername:(NSString *)newUsername avatar:(UIImage *)avatar {
    DPApplication *application = [DPApplication instance];
    NSDictionary *params = @{
            @"method" : @"update_user_info",
            @"new_username" : newUsername,
            @"user" : application.username,
            @"password" : application.password
    };

    if (avatar){
        NSData *imageData = UIImageJPEGRepresentation(avatar, 0.8);
        [self sendRequest:params
            responseClass:[DPUserInfoResponse class]
                 withFile:imageData
                 fileName:@"image"
                 mimeType:@"image/jpg"];
    }
    else{
        [self sendRequest:params responseClass:[DPUserInfoResponse class]];
    }
}

@end