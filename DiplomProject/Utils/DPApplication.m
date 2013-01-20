//
// Created by dmitrykorotchenkov on 17.01.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "DPApplication.h"


static NSString *const kUsernameKey = @"loginUsernameKey";
static NSString *const kPasswordKey = @"loginPasswordKey";

@implementation DPApplication

+ (DPApplication *)instance {
    static DPApplication *instance;
    if (!instance) {
        instance = [[DPApplication alloc] init];
    }
    return instance;
}

- (void)loginUser:(NSString *)username password:(NSString *)password {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:username forKey:kUsernameKey];
    [defaults setObject:password forKey:kPasswordKey];
    [defaults synchronize];
}

- (void)signOut {
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removePersistentDomainForName:appDomain];
}

- (BOOL)isLogin {
    if (self.username && self.password)
        return YES;
    else
        return NO;
}

- (NSString *)username{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:kUsernameKey];
}

- (NSString *)password{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:kPasswordKey];
}

@end