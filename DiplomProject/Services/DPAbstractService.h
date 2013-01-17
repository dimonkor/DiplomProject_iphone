//
// Created by dmitrykorotchenkov on 23.12.12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@class DPAbstractResponse;
@class RKObjectRequestOperation;


@interface DPAbstractService : NSObject

@property(nonatomic, strong) void (^connectionErrorBlock)();
@property(nonatomic, strong) void (^errorBlock)(DPAbstractResponse *);
@property(nonatomic, strong) void (^completionBlock)(DPAbstractResponse *);

@property(nonatomic, strong) RKObjectRequestOperation *objectRequestOperation;

- (void)sendRequest:(NSDictionary *)params responseClass:(Class)responseClass;

- (void)sendRequest:(NSDictionary *)params responseClass:(Class)responseClass withFile:(NSData *)file fileName:(NSString *)fileName mimeType:(NSString *)mimeType;


@end