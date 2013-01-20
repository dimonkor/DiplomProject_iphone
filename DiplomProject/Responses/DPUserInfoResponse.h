//
// Created by dmitrykorotchenkov on 26.12.12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "DPAbstractResponse.h"


@interface DPUserInfoResponse : DPAbstractResponse

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *avatar_url;

@end