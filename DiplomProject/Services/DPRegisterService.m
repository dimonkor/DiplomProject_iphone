//
// Created by dmitrykorotchenkov on 19.01.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "DPRegisterService.h"
#import "DPUserInfoResponse.h"


@implementation DPRegisterService

-(void)sendUser:(NSString *)user password:(NSString *)password{
    NSDictionary *params = @{
            @"method":@"register",
            @"user":user,
            @"password":password
    };
    [self sendRequest:params responseClass:[DPUserInfoResponse class]];
}

@end