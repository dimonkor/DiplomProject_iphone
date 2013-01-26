//
// Created by dmitrykorotchenkov on 26.12.12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "DPAbstractResponse.h"

@class DPUser;


@interface DPUserInfoResponse : DPAbstractResponse

@property (nonatomic, strong) DPUser *userInfo;

@end