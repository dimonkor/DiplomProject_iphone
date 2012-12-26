        //
//  DPMainViewController.m
//  DiplomProject
//
//  Created by Dmitry Korotchenkov on 06.12.12.
//  Copyright (c) 2012 home. All rights reserved.
//

#import "DPMainViewController.h"
#import "RestKit.h"
#import "DPUIUtils.h"

#define CAMERA_TITLE @"Camera"
#define LIBRARY_TITLE @"Library"

@interface DPMainViewController ()
@property(nonatomic, strong) NSData *reciveData;


@end

@implementation DPMainViewController

- (IBAction)choisePhoto {
    BOOL camera = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    BOOL library = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
    UIActionSheet *actionSheet = nil;
    if (library && camera) {
        actionSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:CAMERA_TITLE, LIBRARY_TITLE, nil];
    } else if (library) {
        actionSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:LIBRARY_TITLE, nil];
    } else if (camera) {
        actionSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:CAMERA_TITLE, nil];
    } else {
        actionSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:nil];
    }
    [actionSheet showFromRect:CGRectZero inView:self.view animated:YES];
    
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *const clickedButton = [actionSheet buttonTitleAtIndex:buttonIndex];
    if ([clickedButton isEqualToString:LIBRARY_TITLE]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.delegate = self;
        picker.allowsEditing = NO;
        [self presentViewController:picker animated:YES completion:nil];
    } else if ([clickedButton isEqualToString:CAMERA_TITLE]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = NO;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:nil];
    }
    
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    [picker dismissViewControllerAnimated:YES completion:nil];

    NSString *url = @"http://192.168.0.219/diplom/save_image.php";


    NSURL *baseURL = [[NSURL alloc] initWithString:url];
    NSData *imageData = UIImageJPEGRepresentation(image, 1);
    AFHTTPClient *client = [AFHTTPClient clientWithBaseURL:baseURL];
    NSURLRequest *request = [client multipartFormRequestWithMethod:@"POST" path:nil parameters:nil constructingBodyWithBlock:^(id <AFMultipartFormData> formData){
        [formData appendPartWithFileData:imageData name:@"image" fileName:@"imageName" mimeType:@"image/jpeg"];
    }];


    showHUD();
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response , NSData *data,  NSError *error){
        if (error){

        }
        hideHUD();
    }];

}

@end
