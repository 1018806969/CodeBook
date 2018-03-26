//
//  Platform.m
//  CodeBook
//
//  Created by Merlin on 2018/3/18.
//  Copyright © 2018年 lq. All rights reserved.
//

#import "Platform.h"

@implementation Platform

- (instancetype)initWithPlatformName:(NSString *)platformName
                     platformAddress:(NSString *)platformAddress
                 platformDescription:(NSString *)platformDescription
                            userName:(NSString *)userName
                             userPsw:(NSString *)userPsw
                            otherPsw:(NSString *)otherPsw;
{
    self = [super init];
    if (self) {
        self.userName = userName;
        self.userPsw = userPsw;
        self.otherPsw = otherPsw;
        self.platformName = platformName;
        self.platformAddress = platformAddress;
        self.platformDescription = platformDescription;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.userName forKey:@"userName"];
    [aCoder encodeObject:self.userPsw forKey:@"userPsw"];
    [aCoder encodeObject:self.otherPsw forKey:@"otherPsw"];
    [aCoder encodeObject:self.platformName forKey:@"platformName"];
    [aCoder encodeObject:self.platformAddress forKey:@"platformAddress"];
    [aCoder encodeObject:self.platformDescription forKey:@"platformDescription"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.userName = [aDecoder decodeObjectForKey:@"userName"];
        self.otherPsw = [aDecoder decodeObjectForKey:@"otherPsw"];
        self.userPsw = [aDecoder decodeObjectForKey:@"userPsw"];
        self.platformName = [aDecoder decodeObjectForKey:@"platformName"];
        self.platformAddress = [aDecoder decodeObjectForKey:@"platformAddress"];
        self.platformDescription = [aDecoder decodeObjectForKey:@"platformDescription"];
    }
    return self;
}

- (CGFloat)descriptionHeight
{
    CGRect rect = [self.platformDescription boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
    if (rect.size.height <= 20 ) return 0;
    return rect.size.height - 20;
}

@end
