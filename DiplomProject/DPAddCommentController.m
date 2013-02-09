//
// Created by dmitrykorotchenkov on 08.02.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "DPAddCommentController.h"
#import "Three20Lite.h"
#import "DPCommentsService.h"
#import "DPAbstractResponse.h"
#import "DPUIUtils.h"

@interface DPAddCommentController ()

@property(strong, nonatomic) IBOutlet UITextView *textView;
@property(nonatomic, strong) DPCommentsService *service;


@end

@implementation DPAddCommentController


- (IBAction)send:(id)sender {
    self.service = [[DPCommentsService alloc] init];
    self.service.completionBlock = ^(DPAbstractResponse *response){
        hideHUD();
        [self dismissModalViewController];
    };
    [self.service sendComment:self.photoID comment:self.textView.text];
    showHUD();
}

- (IBAction)cancel:(id)sender {
    [self dismissModalViewController];
}


- (void)viewDidLoad {
    self.textView.returnKeyType = UIReturnKeyDone;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewDidUnload {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [self setTextView:nil];
    [super viewDidUnload];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    /*
    Reduce the size of the text view so that it's not obscured by the keyboard.
    Animate the resize so that it's in sync with the appearance of the keyboard.
    */
    NSDictionary *userInfo = [notification userInfo];

    // Get the origin of the keyboard when it's displayed.
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];

    // Get the top of the keyboard as the y coordinate of its origin in self's view's coordinate system. The bottom of the text view's frame should align with the top of the keyboard's final position.
    CGRect keyboardRect = [aValue CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];

    CGFloat keyboardTop = keyboardRect.origin.y;
    CGRect newTextViewFrame = self.view.bounds;
    newTextViewFrame.size.height = keyboardTop - self.view.bounds.origin.y;

    // Get the duration of the animation.
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];

    // Animate the resize of the text view's frame in sync with the keyboard's appearance.
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:animationDuration];

    UITextView *textView = self.textView;
    textView.frame = newTextViewFrame;

    [UIView commitAnimations];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    /*
    Restore the size of the text view (fill self's view).
    Animate the resize so that it's in sync with the disappearance of the keyboard.
    */
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];

    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:animationDuration];

    UITextView *textView = self.textView;
    textView.frame = self.view.bounds;

    [UIView commitAnimations];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqual:@"\n"]) {
        textView.resignFirstResponder;
        return NO;
    } else {
        return YES;
    }

}


@end