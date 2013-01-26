//
// Created by dmitrykorotchenkov on 24.01.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@class TTImageViewWithDefaultAvatar;
@class DPUser;


@interface DPUserTableCell : UITableViewCell
- (void)fillWithUserInfo:(DPUser *)user;


@end