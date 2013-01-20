//
// Created by dmitrykorotchenkov on 19.01.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface DPViewControllerWithActionSheet : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate>
- (void)choicePhoto:(BOOL)allowEditing;

- (void)didFinishPickingImage:(UIImage *)image;

@end