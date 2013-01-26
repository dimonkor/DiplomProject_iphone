//
// Created by dmitrykorotchenkov on 26.01.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "DPSearchUsersService.h"
#import "DPApplication.h"
#import "DPUsersListResponse.h"


@implementation DPSearchUsersService

-(void)searchString:(NSString *)string{
    DPApplication *application = [DPApplication instance];
    NSDictionary *params = @{
            @"method" : @"find_user",
            @"search_string" : string,
            @"user" : application.username,
            @"password" : application.password
    };
    [self sendRequest:params responseClass:[DPUsersListResponse class]];
}

@end