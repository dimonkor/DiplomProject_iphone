//
// Created by dmitrykorotchenkov on 26.12.12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "DPLoginService.h"
#import "DPLoginResponse.h"


@implementation DPLoginService

-(void)sendUser:(NSString *)user password:(NSString *)password{
    NSDictionary *params = @{
            @"method":@"login",
            @"user":user,
            @"password":password
    };
    [self sendRequest:params responseClass:[DPLoginResponse class]];
}

@end