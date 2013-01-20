//
// Created by dmitrykorotchenkov on 17.01.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface DPApplication : NSObject
+ (DPApplication *)instance;

- (void)loginUser:(NSString *)username password:(NSString *)password;

- (void)signOut;

- (BOOL)isLogin;

- (NSString *)username;

- (NSString *)password;


@end