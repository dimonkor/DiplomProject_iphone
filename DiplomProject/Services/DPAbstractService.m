//
// Created by dmitrykorotchenkov on 23.12.12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "DPAbstractService.h"
#import "DPUIUtils.h"
#import "DPAbstractResponse.h"
#import "DPConstants.h"
#import "Network.h"


@implementation DPAbstractService

- (id)init {
    self = [super init];
    if (self) {
        self.connectionErrorBlock = ^{
            hideHUD();
            [DPUIUtils connectionError];
        };
        self.errorBlock = ^(DPAbstractResponse *response) {
            hideHUD();
            [DPUIUtils showError:response.error];
        };
        self.completionBlock = ^(DPAbstractResponse *response) {
            @throw ([NSException exceptionWithName:@"Not implemented" reason:@"Not implemented" userInfo:nil]);
        };
    }
    return self;
}

-(void)sendRequest:(NSDictionary *)params responseClass:(Class)responseClass{
    NSURL *baseURL = [[NSURL alloc] initWithString:(NSString *) API_PATH];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:baseURL];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[[DPUIUtils stringWithURLEncodedEntries:params] dataUsingEncoding:NSUTF8StringEncoding]] ;

    RKResponseDescriptor *responseDescriptor =
            [RKResponseDescriptor responseDescriptorWithMapping:[responseClass mapping]
                                                    pathPattern:nil keyPath:@"" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];

    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[responseDescriptor]];
    [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        NSLog(@"Recive response: %@" , [[NSString alloc] initWithData:operation.HTTPRequestOperation.responseData encoding:NSUTF8StringEncoding]);
        DPAbstractResponse *response = mappingResult.firstObject;
        if (!response || response.hasError){
            self.errorBlock(response);
        }
        else{
            self.completionBlock(response);
        }
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"Operation failed with error: %@", error);
        self.connectionErrorBlock();
    }];
    [objectRequestOperation start];
}

@end