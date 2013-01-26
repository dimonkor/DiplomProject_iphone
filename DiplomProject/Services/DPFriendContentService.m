//
// Created by dmitrykorotchenkov on 21.01.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "DPFriendContentService.h"
#import "DPUserContentResponse.h"
#import "DPApplication.h"


@implementation DPFriendContentService

- (void)getUserContentForID:(NSInteger)userID {
    DPApplication *application = [DPApplication instance];
    NSDictionary *params = @{
            @"method" : @"get_friend_content",
            @"user_id" : [NSString stringWithFormat:@"%i",userID],
            @"user" : application.username,
            @"password" : application.password
    };
    [self sendRequest:params responseClass:[DPUserContentResponse class]];
}

@end