//
// Created by dmitrykorotchenkov on 17.01.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "DPAbstractResponse.h"


@interface DPSendImageResponse : DPAbstractResponse

@property(nonatomic, strong) NSString *url;

- (NSString *)originalUrl;

- (NSString *)thumbnailUrl;


@end