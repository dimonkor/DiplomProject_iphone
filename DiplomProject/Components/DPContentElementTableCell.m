//
//  DPContentElementTableCell.m
//  DiplomProject
//
//  Created by Dmitry Korotchenkov on 20.01.13.
//  Copyright (c) 2013 home. All rights reserved.
//

#import "DPContentElementTableCell.h"
#import "DPContentElement.h"
#import "Three20UI.h"
#import "UIViewAdditions.h"

@interface DPContentElementTableCell ()
@property(strong, nonatomic) TTImageView *avatarView;
@property(strong, nonatomic) IBOutlet UILabel *nameLabel;
@property(nonatomic, strong) TTImageView *ttImageView;

@end

@implementation DPContentElementTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.ttImageView = [[TTImageView alloc] initWithFrame:CGRectMake(20, 45, 320, 100)];
    [self addSubview:self.ttImageView];
    self.avatarView = [[TTImageView alloc] initWithFrame:CGRectMake(20, 10, 25, 25)];
    [self addSubview:self.avatarView];
}


- (void)fillWithElement:(DPContentElement *)element {
    self.ttImageView.size = element.thumbnailSize;
    self.ttImageView.urlPath = element.thumbnailUrl;
    self.avatarView.urlPath = element.avatar_url;
    self.nameLabel.text = element.username;
}

- (IBAction)tapOnUser:(id)sender {
}

@end
