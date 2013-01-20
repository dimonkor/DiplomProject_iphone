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
#import "RestKit.h"
#import "RKRequestOperationSubclass.h"
#import "RKObjectRequestOperation.h"


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

- (void)sendRequest:(NSDictionary *)params responseClass:(Class)responseClass {
    NSURL *baseURL = [[NSURL alloc] initWithString:(NSString *) API_PATH];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:baseURL];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[[DPUIUtils stringWithURLEncodedEntries:params] dataUsingEncoding:NSUTF8StringEncoding]];

    AFHTTPClient *client = [AFHTTPClient clientWithBaseURL:baseURL];
    request = [client requestWithMethod:@"POST" path:@"" parameters:params];

    RKResponseDescriptor *responseDescriptor =
            [RKResponseDescriptor responseDescriptorWithMapping:[responseClass mapping]
                                                    pathPattern:nil keyPath:@"" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];

    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[responseDescriptor]];
    [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        NSLog(@"Recive response: %@", [[NSString alloc] initWithData:operation.HTTPRequestOperation.responseData encoding:NSUTF8StringEncoding]);
        DPAbstractResponse *response = mappingResult.firstObject;
        if (!response || response.hasError) {
            self.errorBlock(response);
        }
        else {
            self.completionBlock(response);
        }
    }                                             failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"Operation failed with error: %@", error);
        self.connectionErrorBlock();
    }];
    [objectRequestOperation start];
}

- (void)sendRequest:(NSDictionary *)params
      responseClass:(Class)responseClass
           withFile:(NSData *)file
           fileName:(NSString *)fileName
           mimeType:(NSString *)mimeType {

    NSURL *baseURL = [[NSURL alloc] initWithString:(NSString *) API_PATH];
    AFHTTPClient *client = [AFHTTPClient clientWithBaseURL:baseURL];
    RKObjectManager *manager = [RKObjectManager managerWithBaseURL:baseURL];
    NSMutableURLRequest *request;
    if (file && fileName && mimeType) {
        request = [client multipartFormRequestWithMethod:@"POST" path:@"" parameters:params constructingBodyWithBlock:^(id <AFMultipartFormData> formData) {
            [formData appendPartWithFileData:file name:@"image" fileName:@"imageName" mimeType:@"image/jpeg"];
        }];
    }
    else {
        request = [client requestWithMethod:@"POST" path:nil parameters:params];
    }

    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            self.connectionErrorBlock();
        } else {
            NSString *MIMEType = @"application/json";
            NSError *error;
            id parsedData = [RKMIMETypeSerialization objectFromData:data MIMEType:MIMEType error:&error];
            if (parsedData == nil && error) {
                NSLog(@"parse error for string %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
                self.connectionErrorBlock();
            }

            NSDictionary *mappingsDictionary = @{@"" : [responseClass mapping]};
            RKMapperOperation *mapper = [[RKMapperOperation alloc] initWithRepresentation:parsedData mappingsDictionary:mappingsDictionary];
            NSError *mappingError = nil;
            BOOL isMapped = [mapper execute:&mappingError];
            if (isMapped && !mappingError) {
                DPAbstractResponse *abstractResponse = mapper.mappingResult.firstObject;
                if (abstractResponse.hasError) {
                    self.errorBlock(abstractResponse);
                } else {
                    self.completionBlock(abstractResponse);
                }
            }
        }

    }];
}

@end