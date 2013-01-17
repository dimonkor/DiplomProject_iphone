//
// Created by dmitrykorotchenkov on 13.01.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "DPSendImageService.h"
#import "DPAbstractResponse.h"


@implementation DPSendImageService

-(void)sendImage:(UIImage *)image{
    NSData *imageData = UIImageJPEGRepresentation(image, 1);
    NSDictionary *params = @{@"method":@"save_image",@"user":@"q",@"password":@"q"};
    [self sendRequest:params
        responseClass:[DPAbstractResponse class]
             withFile:imageData
             fileName:@"image"
             mimeType:@"image/jpeg"];


}

@end