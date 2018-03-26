//
//  PlatformCell.m
//  CodeBook
//
//  Created by Merlin on 2018/3/18.
//  Copyright © 2018年 lq. All rights reserved.
//

#import "PlatformCell.h"
#import "Platform.h"

@interface PlatformCell()

@property (nonatomic, strong) Platform *platform;
@property (nonatomic, copy) void(^link)(NSString *url);

@end

@implementation PlatformCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)loadPlatform:(Platform *)platfrom link:(void(^)(NSString *url))link;
{
    self.platform = platfrom;
    self.link = [link copy];
    
    self.userNamelabel.text = platfrom.userName;
    self.userPswLabel.text = platfrom.userPsw;
    self.otherPswLabel.text = platfrom.otherPsw;
    self.platformNameLabel.text = platfrom.platformName;
    self.platformDescriptionLabel.text = platfrom.platformDescription;
    
    if (!platfrom.platformAddress) return;
    
    self.platformAddressLabel.textColor = [UIColor blueColor];
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString:platfrom.platformAddress];
    [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSRangeFromString(platfrom.platformAddress)];
    self.platformAddressLabel.attributedText = content;
    self.platformAddressLabel.userInteractionEnabled = true;
    UITapGestureRecognizer* tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toWebAction)];
    [self.platformAddressLabel addGestureRecognizer:tapGes];
}

- (void)toWebAction
{
    if (self.link) {
        self.link(_platform.platformAddress);
    }
}
@end
