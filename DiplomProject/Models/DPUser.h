//
// Created by dmitrykorotchenkov on 24.01.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "RestKit.h"

@interface DPUser : NSObject

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *avatarUrl;
@property (nonatomic, strong) NSNumber *userId;

+ (RKObjectMapping *)mapping;

@end