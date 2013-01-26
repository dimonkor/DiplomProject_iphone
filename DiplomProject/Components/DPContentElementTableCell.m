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
#import "DPRibbonViewController.h"
#import "TTImageViewWithDefaultAvatar.h"

@interface DPContentElementTableCell ()
@property(strong, nonatomic) TTImageView *avatarView;
@property(strong, nonatomic) IBOutlet UILabel *nameLabel;
@property(nonatomic, strong) TTImageView *ttImageView;
@property(nonatomic, weak) DPContentElement *element;
@property(nonatomic, weak) DPRibbonViewController *ribbonViewController;


@end

@implementation DPContentElementTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.ttImageView = [[TTImageView alloc] initWithFrame:CGRectMake(20, 75, 320, 100)];
    [self addSubview:self.ttImageView];
    self.avatarView = [[TTImageViewWithDefaultAvatar alloc] initWithFrame:CGRectMake(20, 10, 50, 50)];
    [self insertSubview:self.avatarView atIndex:0];
}


- (void)fillWithElement:(DPContentElement *)element ribbonController:(DPRibbonViewController *)ribbonViewController {
    self.ttImageView.size = element.thumbnailSize;
    self.ttImageView.urlPath = element.thumbnailUrl;
    self.avatarView.urlPath = element.avatarUrl;
    self.nameLabel.text = element.username;
    self.element = element;
    self.ribbonViewController = ribbonViewController;
}

- (IBAction)tapOnUser:(id)sender {
    if (self.ribbonViewController && self.element){
        [self.ribbonViewController didSelectElement:self.element];
    }
}

@end
