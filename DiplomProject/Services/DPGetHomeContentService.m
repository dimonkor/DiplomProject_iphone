//
// Created by dmitrykorotchenkov on 20.01.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "DPGetHomeContentService.h"
#import "DPApplication.h"
#import "DPUserContentResponse.h"


@implementation DPGetHomeContentService


- (void)getHomeContent {
    DPApplication *application = [DPApplication instance];
    NSDictionary *params = @{
        @"method" : @"get_home_content",
        @"user" : application.username,
        @"password" : application.password
    };
    [self sendRequest:params responseClass:[DPUserContentResponse class]];
}

@end