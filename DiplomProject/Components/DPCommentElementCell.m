//
// Created by dmitrykorotchenkov on 07.02.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "DPCommentElementCell.h"
#import "UIViewAdditions.h"

@interface DPCommentElementCell()
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) IBOutlet UILabel *textLabel;

@end

@implementation DPCommentElementCell


+(CGFloat)cellHeightForComment:(NSString *)comment{
    CGSize size = [self commentSize:comment];
    return 40 + size.height + 10;
}

- (void)layoutSubviews {
}


+ (CGSize)commentSize:(NSString *)comment {
    UIFont *font = [UIFont fontWithName:@"Helvetica" size:12];
    CGSize size = [comment sizeWithFont:font
                      constrainedToSize:CGSizeMake(280, CGFLOAT_MAX)
                          lineBreakMode:NSLineBreakByTruncatingTail];
    return size;
}

-(void)fillWithUsername:(NSString *)username comment:(NSString *)comment{
    self.usernameLabel.text = username;
    self.textLabel.text = comment;
    self.textLabel.size = [DPCommentElementCell commentSize:comment];
}

@end