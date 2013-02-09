//
// Created by dmitrykorotchenkov on 24.01.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "DPFriendsListService.h"
#import "DPApplication.h"
#import "DPUsersListResponse.h"


@implementation DPFriendsListService

-(void)getFriends{
    DPApplication *application = [DPApplication instance];
    NSDictionary *params = @{
            @"method" : @"get_friends_list",
            @"user" : application.username,
            @"password" : application.password
    };
    [self sendRequest:params responseClass:[DPUsersListResponse class]];
}

-(void)getFriendsForUser:(NSNumber *)userId{
    DPApplication *application = [DPApplication instance];
    NSDictionary *params = @{
            @"method" : @"get_friends_list",
            @"user_id" : userId.stringValue
    };
    [self sendRequest:params responseClass:[DPUsersListResponse class]];
}

-(void)getSuggestions{
    DPApplication *application = [DPApplication instance];
    NSDictionary *params = @{
            @"method" : @"get_friends_suggestions",
            @"user" : application.username,
            @"password" : application.password
    };
    [self sendRequest:params responseClass:[DPUsersListResponse class]];
}

-(void)getListeners{
    DPApplication *application = [DPApplication instance];
    NSDictionary *params = @{
            @"method" : @"get_listeners_list",
            @"user" : application.username,
            @"password" : application.password
    };
    [self sendRequest:params responseClass:[DPUsersListResponse class]];
}

@end