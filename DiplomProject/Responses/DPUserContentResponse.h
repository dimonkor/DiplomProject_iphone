//
// Created by dmitrykorotchenkov on 20.01.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "DPAbstractResponse.h"


@interface DPUserContentResponse : DPAbstractResponse

@property (nonatomic, strong) NSArray *content;
@property (nonatomic, strong) NSNumber *canAddToFriends;

@end