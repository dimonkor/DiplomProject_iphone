//
// Created by dmitrykorotchenkov on 24.01.13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "DPUserTableCell.h"
#import "DPUser.h"
#import "TTImageViewWithDefaultAvatar.h"

@interface DPUserTableCell ()
@property (strong, nonatomic) UILabel *usernameLabel;
@property(nonatomic, strong) TTImageViewWithDefaultAvatar *avatar;
@end

@implementation DPUserTableCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [self createAvatarView];
        [self createUsernameLabel];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    return self;
}

- (void)createAvatarView {
    self.avatar = [[TTImageViewWithDefaultAvatar alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
    self.avatar.defaultImage = [UIImage imageNamed:@"devault_avatar_image.jpeg"];
    [self addSubview:self.avatar];
}

- (void)createUsernameLabel {
    self.usernameLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 24, 198, 21)];
    self.usernameLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14];
    [self addSubview:self.usernameLabel];
}

-(void)fillWithUserInfo:(DPUser *)user {
    self.usernameLabel.text = user.username;
    self.avatar.urlPath = user.avatarUrl;
    
}

@end