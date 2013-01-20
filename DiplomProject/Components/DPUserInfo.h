//
// Created by dmitrykorotchenkov on 19.01.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface DPUserInfo : NSObject

+ (void)setUsername:(NSString *)username avatarImageName:(NSString *)avatarImageName;

+ (NSString *)userName;

+ (NSString *)avatarUrl;


@end