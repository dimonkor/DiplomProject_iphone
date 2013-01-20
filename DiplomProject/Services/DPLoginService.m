//
// Created by dmitrykorotchenkov on 26.12.12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "DPLoginService.h"
#import "DPUserInfoResponse.h"


@implementation DPLoginService

-(void)sendUser:(NSString *)user password:(NSString *)password{
    NSDictionary *params = @{
            @"method":@"login",
            @"user":user,
            @"password":password
    };
    [self sendRequest:params responseClass:[DPUserInfoResponse class]];
}

@end