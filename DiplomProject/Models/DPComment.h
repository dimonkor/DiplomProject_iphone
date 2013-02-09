//
// Created by dmitrykorotchenkov on 07.02.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@class RKObjectMapping;


@interface DPComment : NSObject

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *comment;

+ (RKObjectMapping *)mapping;

@end