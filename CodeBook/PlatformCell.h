//
//  PlatformCell.h
//  CodeBook
//
//  Created by Merlin on 2018/3/18.
//  Copyright © 2018年 lq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Platform;
@interface PlatformCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *userNamelabel;
@property (weak, nonatomic) IBOutlet UILabel *userPswLabel;
@property (weak, nonatomic) IBOutlet UILabel *platformNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *otherPswLabel;
@property (weak, nonatomic) IBOutlet UILabel *platformAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *platformDescriptionLabel;

- (void)loadPlatform:(Platform *)platfrom link:(void(^)(NSString *url))link;

@end
