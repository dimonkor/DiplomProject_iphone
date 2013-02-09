//
// Created by dmitrykorotchenkov on 19.01.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "DPViewControllerWithActionSheet.h"
#import "DPUIUtils.h"

#define CAMERA_TITLE @"Камера"
#define LIBRARY_TITLE @"Библиотека изображений"

@interface DPViewControllerWithActionSheet ()

@property(nonatomic) BOOL isAllowEditing;

@end

@implementation DPViewControllerWithActionSheet

- (void)choicePhoto:(BOOL)allowEditing {
    self.isAllowEditing = allowEditing;
    BOOL camera = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
    BOOL library = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
    UIActionSheet *actionSheet = nil;
    if (library && camera) {
        actionSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Отмена" destructiveButtonTitle:nil otherButtonTitles:CAMERA_TITLE, LIBRARY_TITLE, nil];
    } else if (library) {
        actionSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Отмена" destructiveButtonTitle:nil otherButtonTitles:LIBRARY_TITLE, nil];
    } else if (camera) {
        actionSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Отмена" destructiveButtonTitle:nil otherButtonTitles:CAMERA_TITLE, nil];
    } else {
        actionSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"Отмена" destructiveButtonTitle:nil otherButtonTitles:nil];
    }
    [actionSheet showFromRect:CGRectZero inView:[DPUIUtils appWindow] animated:YES];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *const clickedButton = [actionSheet buttonTitleAtIndex:buttonIndex];
    if ([clickedButton isEqualToString:LIBRARY_TITLE]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.delegate = self;
        picker.allowsEditing = self.isAllowEditing;
        [self presentViewController:picker animated:YES completion:nil];
    } else if ([clickedButton isEqualToString:CAMERA_TITLE]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = self.isAllowEditing;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:nil];
    }

}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *editingImage = [info objectForKey:UIImagePickerControllerEditedImage];
    if (editingImage) {
        [self didFinishPickingImage:editingImage];
    } else {
        [self didFinishPickingImage:[info objectForKey:UIImagePickerControllerOriginalImage]];
    }
}


- (void)didFinishPickingImage:(UIImage *)image {
}

@end