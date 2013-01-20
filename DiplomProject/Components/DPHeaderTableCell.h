//
// Created by dmitrykorotchenkov on 20.01.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "Three20UI.h"

@class TTImageView;


@interface DPHeaderTableCell : UITableViewCell <TTImageViewDelegate>
- (void)fillWithName:(NSString *)username avatarUrl:(NSString *)avatarUrl;


@end