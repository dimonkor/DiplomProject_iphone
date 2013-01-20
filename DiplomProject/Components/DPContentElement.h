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

+ (RKObjectMapping *)mapping;

- (NSString *)thumbnailUrl;

- (NSString *)originalUrl;

- (CGSize)originalSize;

- (CGSize)thumbnailSize;


@end