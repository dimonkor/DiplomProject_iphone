//
// Created by dmitrykorotchenkov on 20.01.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "DPRibbonViewController.h"
#import "DPHeaderTableCell.h"
#import "UIViewAdditions.h"
#import "DPContentElementTableCell.h"
#import "DPUserInfo.h"
#import "DPGetHomeContentService.h"
#import "DPAbstractResponse.h"
#import "DPHomeContentResponse.h"
#import "DPContentElement.h"

@interface DPRibbonViewController ()

@property(strong, nonatomic) IBOutlet DPHeaderTableCell *headerTableCell;
@property(nonatomic, strong) DPGetHomeContentService *service;
@property(nonatomic, strong) NSArray *dataSource;
@property (strong, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation DPRibbonViewController

- (void)loadView {
    [super loadView];
    self.service = [[DPGetHomeContentService alloc] init];
    self.service.completionBlock = ^(DPAbstractResponse *response) {
        DPHomeContentResponse *castedResponse = (DPHomeContentResponse *) response;
        self.dataSource = castedResponse.content;
        [self.tableView reloadData];
    };
    [self.service getHomeContent];

}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.dataSource && self.dataSource.count>0)
        return 2;
    else
        return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0)
        return 1;
    else
        return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        [self.headerTableCell fillWithName:[DPUserInfo userName] avatarUrl:[DPUserInfo avatarUrl]];
        return self.headerTableCell;
    }
    else {
        DPContentElementTableCell *cell = [tableView dequeueReusableCellWithIdentifier:kContentElementCellID];
        cell = cell ? : [[DPContentElementTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kContentElementCellID];
        [cell fillWithElement:self.dataSource[(NSUInteger) indexPath.row]];
        return cell;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0)
        return self.headerTableCell.height;
    else
        return ((DPContentElement *) self.dataSource[(NSUInteger) indexPath.row]).thumbnailSize.height + 45 + 10;

}


- (void)viewDidUnload {
    [self setTableView:nil];
    [super viewDidUnload];
}
@end