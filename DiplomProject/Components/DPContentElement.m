//
// Created by dmitrykorotchenkov on 20.01.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "DPContentElement.h"
#import "RestKit.h"
#import "DPConstants.h"

@implementation DPContentElement

+ (RKObjectMapping *)mapping {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:self];
    [mapping addAttributeMappingsFromArray:@[
            @"user_id",
            @"username",
            @"avatar_url",
            @"photo_url",
            @"photo_width",
            @"photo_height"
    ]];
    return mapping;
}

-(NSString *)thumbnailUrl{
    return [NSString stringWithFormat:@"%@/images/thumbnail/%@",API_PATH,self.photo_url];
}

-(NSString *)originalUrl{
    return [NSString stringWithFormat:@"%@/images/original/%@",API_PATH,self.photo_url];
}

-(CGSize)originalSize{
    return CGSizeMake(self.photo_width.intValue, self.photo_height.intValue);
}

-(CGSize)thumbnailSize{
    return CGSizeMake(280, self.photo_height.intValue * 280 / self.photo_width.intValue);
}

@end