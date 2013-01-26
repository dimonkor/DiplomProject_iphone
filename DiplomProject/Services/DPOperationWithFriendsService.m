//
// Created by dmitrykorotchenkov on 26.01.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "DPOperationWithFriendsService.h"
#import "DPApplication.h"
#import "DPAbstractResponse.h"


@implementation DPOperationWithFriendsService

-(void)addFriend:(NSNumber *)friendID{
    DPApplication *application = [DPApplication instance];
    NSDictionary *params = @{
            @"method" : @"add_friend",
            @"user" : application.username,
            @"password" : application.password,
            @"friend_id" : friendID
    };
    [self sendRequest:params responseClass:[DPAbstractResponse class]];
}


-(void)deleteFriend:(NSNumber *)friendID{
    DPApplication *application = [DPApplication instance];
    NSDictionary *params = @{
            @"method" : @"delete_friend",
            @"user" : application.username,
            @"password" : application.password,
            @"friend_id" : friendID
    };
    [self sendRequest:params responseClass:[DPAbstractResponse class]];
}

@end