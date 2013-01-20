//
// Created by dmitrykorotchenkov on 13.01.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "DPSendImageService.h"
#import "DPSendImageResponse.h"
#import "DPApplication.h"
#import "UIImage+fixOrientation.h"


@implementation DPSendImageService

- (void)sendImage:(UIImage *)image {
    NSData *imageData = UIImageJPEGRepresentation(image.fixOrientation, 0.8);
    DPApplication *application = [DPApplication instance];
    NSDictionary *params = @{@"method" : @"save_image",
            @"user" : application.username,
            @"password" : application.password
    };
    [self sendRequest:params
        responseClass:[DPSendImageResponse class]
             withFile:imageData
             fileName:@"image"
             mimeType:@"image/jpg"];


}

@end