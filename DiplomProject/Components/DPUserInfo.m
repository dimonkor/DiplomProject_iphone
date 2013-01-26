//
// Created by dmitrykorotchenkov on 19.01.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "DPUserInfo.h"
#import "DPConstants.h"

static NSString *kUsernameKey = @"usernameInfoLey";
static NSString *kAvatarUrlNameKey = @"avatarUrlUserInfo";

@implementation DPUserInfo

+ (void)setUsername:(NSString *)username avatarImageName:(NSString *)avatarImageName {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:username forKey:kUsernameKey];
    [defaults setObject:avatarImageName forKey:kAvatarUrlNameKey];
    [defaults synchronize];
}

+ (NSString *)userName {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:kUsernameKey];
}

+ (NSString *)avatarUrl {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *imageName = [defaults objectForKey:kAvatarUrlNameKey];
    return imageName;
    return [NSString stringWithFormat:@"%@/images/thumbnail/%@",API_PATH,imageName];
}



@end