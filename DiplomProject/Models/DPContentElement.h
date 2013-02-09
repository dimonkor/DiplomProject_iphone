//
// Created by dmitrykorotchenkov on 20.01.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@class RKObjectMapping;


@interface DPContentElement : NSObject

@property (nonatomic, strong) NSNumber *user_id;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *avatar_url;
@property (nonatomic, strong) NSString *photo_url;
@property (nonatomic, strong) NSNumber *photo_width;
@property (nonatomic, strong) NSNumber *photo_height;
@property (nonatomic, strong) NSNumber *photo_id;

+ (RKObjectMapping *)mapping;

- (NSString *)thumbnailUrl;

- (NSString *)originalUrl;

- (NSString *)avatarUrl;

- (CGSize)originalSize;

- (CGSize)thumbnailSize;


@end