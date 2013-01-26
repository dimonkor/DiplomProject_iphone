//
// Created by dmitrykorotchenkov on 25.01.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "TTImageViewWithDefaultAvatar.h"


@implementation TTImageViewWithDefaultAvatar


- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIImage *image = [UIImage imageNamed:@"devault_avatar_image.jpeg"];
        self.defaultImage = image;
    }

    return self;
}


@end