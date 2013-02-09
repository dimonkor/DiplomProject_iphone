//
// Created by dmitrykorotchenkov on 20.01.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "DPViewControllerWithActionSheet.h"

@class DPGetHomeContentService;
@class DPContentElement;
@class DPHeaderTableCell;


static NSString *const kContentElementCellID = @"contentElementCellID";

@interface DPRibbonViewController : DPViewControllerWithActionSheet <UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate>

@property(nonatomic, strong) NSArray *dataSource;
@property(strong, nonatomic) IBOutlet UITableView *tableView;
@property(strong, nonatomic) IBOutlet DPHeaderTableCell *headerTableCell;

- (void)didSelectElement:(DPContentElement *)element;

- (void)didSelectPhoto:(NSNumber *)photoId;


- (DPHeaderTableCell *)getHeaderCell;


@end