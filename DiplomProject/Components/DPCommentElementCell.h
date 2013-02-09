//
// Created by dmitrykorotchenkov on 07.02.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface DPCommentElementCell : UITableViewCell
+ (CGFloat)cellHeightForComment:(NSString *)comment;

- (void)fillWithUsername:(NSString *)username comment:(NSString *)comment;


@end