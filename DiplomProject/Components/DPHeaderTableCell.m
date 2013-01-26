//
// Created by dmitrykorotchenkov on 20.01.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "DPHeaderTableCell.h"
#import "Three20UI.h"
#import "UIViewAdditions.h"
#import "TTImageViewWithDefaultAvatar.h"

@interface DPHeaderTableCell ()

@property(strong, nonatomic) IBOutlet UIView *avatarHolder;

@property(strong, nonatomic) IBOutlet UILabel *usernameLabel;
@property(nonatomic, strong) TTImageView *ttImageView;


@end

@implementation DPHeaderTableCell

- (void)fillWithName:(NSString *)username avatarUrl:(NSString *)avatarUrl {
    if (!self.ttImageView) {
        self.ttImageView = [[TTImageViewWithDefaultAvatar alloc] initWithFrame:CGRectMake(0, 0, self.avatarHolder.width, self.avatarHolder.height)];
        self.ttImageView.delegate= self;
        [self.avatarHolder addSubview:self.ttImageView];
    }
    if (self.ttImageView.urlPath != avatarUrl) {
        self.ttImageView.urlPath = avatarUrl;
    }
    self.usernameLabel.text = username;

}


- (void)imageView:(TTImageView *)imageView didLoadImage:(UIImage *)image {
    if (image.size.width / image.size.height > self.avatarHolder.size.width / self.avatarHolder.size.height) {
        imageView.height = self.avatarHolder.size.width / image.size.width * image.size.height;
        imageView.width = self.avatarHolder.width;
    } else {
        imageView.width = self.avatarHolder.size.height / image.size.height * image.size.width;
        imageView.height = self.avatarHolder.height;
    }
    CGSize size = self.avatarHolder.frame.size;
    [imageView setCenter:CGPointMake(size.width / 2, size.height / 2)];
}


@end