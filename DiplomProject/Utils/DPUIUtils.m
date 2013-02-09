//
// Created by dmitrykorotchenkov on 23.12.12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "DPUIUtils.h"
#import "MBProgressHUD.h"
#import "DPAppDelegate.h"

void showHUD(){
    MBProgressHUD *const hud = [MBProgressHUD showHUDAddedTo:[DPUIUtils appWindow] animated:YES];
//    hud.labelText = @"Loading";
//    hud.labelFont = [UIFont fontWithName:FONT_BOLD size:16];
}

void hideHUD(){
    [MBProgressHUD hideHUDForView:[DPUIUtils appWindow] animated:YES];
//    [MBProgressHUD hideAllHUDsForView:[DPUIUtils appWindow] animated:YES];
}

@implementation DPUIUtils

+ (UIWindow *)appWindow {
    return [self appDelegate].window;
}

+ (DPAppDelegate *)appDelegate {
    UIApplication *application = [UIApplication sharedApplication];
    return (DPAppDelegate *) application.delegate;
}

+ (void)connectionError {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Ошибка" message:@"Нет соединения с сервером" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

+ (void)showError:(NSString *)error {
    [self showMessage:error withTitle:@"Ошибка"];
}

+ (void)showMessage:(NSString *)text withTitle:(NSString *)title {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:text delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

+ (NSString *)stringWithURLEncodedEntries:(NSDictionary *)dictionary {
    NSMutableArray* parts = [NSMutableArray array];
    for (id key in [dictionary allKeys]){
        [parts addObject:[NSString stringWithFormat:@"%@=%@", key, [dictionary objectForKey:key]]];
    }
    return [parts componentsJoinedByString:@"&"];
}

@end