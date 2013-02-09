//
// Created by dmitrykorotchenkov on 07.02.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "DPAbstractService.h"


@interface DPCommentsService : DPAbstractService
- (void)getCommentsForPhotoID:(NSNumber *)photoID;

- (void)sendComment:(NSNumber *)photoID comment:(NSString *)comment;


@end