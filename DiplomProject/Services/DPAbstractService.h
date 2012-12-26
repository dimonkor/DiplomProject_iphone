//
// Created by dmitrykorotchenkov on 23.12.12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@class DPAbstractResponse;


@interface DPAbstractService : NSObject

@property(nonatomic, strong) void (^connectionErrorBlock)();
@property(nonatomic, strong) void (^errorBlock)(DPAbstractResponse *);
@property(nonatomic, strong) void (^completionBlock)(DPAbstractResponse *);

- (void)sendRequest:(NSDictionary *)params responseClass:(Class)responseClass;

@end