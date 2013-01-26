//
//  DPContentElementTableCell.h
//  DiplomProject
//
//  Created by Dmitry Korotchenkov on 20.01.13.
//  Copyright (c) 2013 home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DPRibbonViewController.h"

@class DPContentElement;

@interface DPContentElementTableCell : UITableViewCell

- (void)fillWithElement:(DPContentElement *)element ribbonController:(DPRibbonViewController *)ribbonViewController;

@end
