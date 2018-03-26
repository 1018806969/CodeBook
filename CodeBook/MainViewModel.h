//
//  MainViewModel.h
//  CodeBook
//
//  Created by Merlin on 2018/3/18.
//  Copyright © 2018年 lq. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Platform;
@interface MainViewModel : NSObject

@property (nonatomic, readonly, strong) NSMutableArray<Platform *> *platforms;

- (void)loadPlatforms;

- (void)addPlatform:(Platform *)platform;

- (void)deletePlatformAtIndex:(NSInteger)index;

- (void)moveRowAtIndex:(NSInteger)index toIndex:(NSInteger)destinationIndex;

@end
