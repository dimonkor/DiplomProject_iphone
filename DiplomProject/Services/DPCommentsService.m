//
// Created by dmitrykorotchenkov on 07.02.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "DPCommentsService.h"
#import "DPCommentsResponse.h"
#import "DPApplication.h"


@implementation DPCommentsService

- (void)getCommentsForPhotoID:(NSNumber *)photoID {
    NSDictionary *params = @{
            @"method" : @"get_comments",
            @"photo_id" : photoID.stringValue
    };
    [self sendRequest:params responseClass:[DPCommentsResponse class]];
}

- (void)sendComment:(NSNumber *)photoID comment:(NSString *)comment {
    DPApplication *application = [DPApplication instance];
    NSDictionary *params = @{
            @"method" : @"add_comment",
            @"photo_id" : photoID.stringValue,
            @"comment" : comment,
            @"user" : application.username,
            @"password" : application.password
    };
    [self sendRequest:params responseClass:[DPAbstractResponse class]];
}

@end