        //
//  DPMainViewController.m
//  DiplomProject
//
//  Created by Dmitry Korotchenkov on 06.12.12.
//  Copyright (c) 2012 home. All rights reserved.
//

#import "DPMainViewController.h"
#import "RestKit.h"

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
        picker.allowsEditing = YES;
        [self presentViewController:picker animated:YES completion:nil];
    } else if ([clickedButton isEqualToString:CAMERA_TITLE]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:nil];
    }
    
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    NSLog(@"choisePhoto");
    [picker dismissViewControllerAnimated:YES completion:nil];


    NSString *url = @"http://192.168.0.219/diplom/save_image.php";


    [RKObjectManager managerWithBaseURL:[[NSURL alloc] initWithString:url]];
    RKParams *params;

//    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[[NSURL alloc] initWithString:url]];
//    [request setData:UIImageJPEGRepresentation(image, 0.5) forKey:@"userfile"];
//    [request startSynchronous];

}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    self.reciveData = data;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *result = [[NSString alloc] initWithData:self.reciveData encoding:NSUTF8StringEncoding];
    NSLog(@"%@", result);
}
@end
