//
// Created by dmitrykorotchenkov on 07.02.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "DPCommentsController.h"
#import "DPCommentElementCell.h"
#import "DPComment.h"
#import "DPCommentsService.h"
#import "DPCommentsResponse.h"
#import "DPUIUtils.h"
#import "DPAddCommentController.h"


@interface DPCommentsController()
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *dataSource;
@property(nonatomic, strong) DPCommentsService *commentsService;


@end

@implementation DPCommentsController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.commentsService = [[DPCommentsService alloc] init];
    self.commentsService.completionBlock = ^(DPCommentsResponse *response){
        self.dataSource = response.comments;
        [self.tableView reloadData];
        hideHUD();
    };
    showHUD();
    [self.commentsService getCommentsForPhotoID:self.photo_id];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DPCommentElementCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commentCellID"];
    DPComment *comment = self.dataSource[(NSUInteger) indexPath.row];
    [cell fillWithUsername:comment.username comment:comment.comment];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    DPComment *comment = self.dataSource[(NSUInteger) indexPath.row];
    return [DPCommentElementCell cellHeightForComment:comment.comment];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"addCommentSegueID"]){
        DPAddCommentController * controller = [(UINavigationController *)segue.destinationViewController visibleViewController];
        controller.photoID = self.photo_id;
    }
    [super prepareForSegue:segue sender:sender];
}


@end