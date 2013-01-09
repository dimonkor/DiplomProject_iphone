//
// Created by dmitrykorotchenkov on 26.12.12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "DPAbstractResponse.h"


@interface DPLoginResponse : DPAbstractResponse

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;

@end