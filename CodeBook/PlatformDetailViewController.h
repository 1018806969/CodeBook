//
//  PlatformDetailViewController.h
//  CodeBook
//
//  Created by Merlin on 2018/3/18.
//  Copyright © 2018年 lq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Platform;
@interface PlatformDetailViewController : UIViewController

- (instancetype)initWithPlatform:(Platform *)platform editScc:(void(^)(Platform *platform))scc;

@end
