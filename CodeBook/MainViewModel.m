//
//  MainViewModel.m
//  CodeBook
//
//  Created by Merlin on 2018/3/18.
//  Copyright © 2018年 lq. All rights reserved.
//

#import "MainViewModel.h"
#import "Platform.h"

@interface MainViewModel()

@property (nonatomic, strong) NSMutableArray<Platform *> *platforms;

@end

@implementation MainViewModel

- (void)loadPlatforms
{
    NSString *filePath = [self filePath];
    BOOL isExistFile = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
    if (isExistFile) {
        _platforms = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    } else {
        _platforms = [NSMutableArray arrayWithCapacity:0];
        [[NSFileManager defaultManager] createFileAtPath:filePath contents:nil attributes:nil];
    }
}

- (void)addPlatform:(Platform *)platform
{
    if (!platform) return;
    if (!_platforms) {
        _platforms = [NSMutableArray arrayWithCapacity:0];
    }
    
    if (![_platforms containsObject:platform]) {
        [_platforms insertObject:platform atIndex:0];
    }
    [NSKeyedArchiver archiveRootObject:_platforms toFile:[self filePath]];
}

- (void)deletePlatformAtIndex:(NSInteger)index
{
    if (_platforms.count <= index) return;
    [_platforms removeObjectAtIndex:index];
    [NSKeyedArchiver archiveRootObject:_platforms toFile:[self filePath]];
}

- (void)deletePlatform:(Platform *)platform
{
    if (!_platforms.count || ![_platforms containsObject:platform]) return;
    [_platforms removeObject:platform];
}
- (void)editPlatformAtIndex:(NSInteger)index
{
    if (_platforms.count <= index) return;
    [NSKeyedArchiver archiveRootObject:_platforms toFile:[self filePath]];
}

- (void)moveRowAtIndex:(NSInteger)index toIndex:(NSInteger)destinationIndex
{
    if (_platforms.count <= index || _platforms.count <= destinationIndex) return;
    [_platforms exchangeObjectAtIndex:index withObjectAtIndex:destinationIndex];
    [NSKeyedArchiver archiveRootObject:_platforms toFile:[self filePath]];
}

- (NSString *)filePath
{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"codebook.plist"];
    return filePath;
}

@end
