//
// Created by dmitrykorotchenkov on 23.12.12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

void showHUD();

void hideHUD();

@interface DPUIUtils : NSObject
+ (UIWindow *)appWindow;

+ (void)connectionError;

+ (void)showError:(NSString *)error;

+ (void)showMessage:(NSString *)text withTitle:(NSString *)title;

+ (NSString *)stringWithURLEncodedEntries:(NSDictionary *)dictionary;


@end