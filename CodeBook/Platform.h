//
//  Platform.h
//  CodeBook
//
//  Created by Merlin on 2018/3/18.
//  Copyright © 2018年 lq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Platform : NSObject<NSCoding>

@property (nonatomic, copy) NSString *platformName;
@property (nonatomic, copy) NSString *platformAddress;
@property (nonatomic, copy) NSString *platformDescription;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *userPsw;
@property (nonatomic, copy) NSString *otherPsw;

@property (nonatomic, assign) CGFloat descriptionHeight;

- (instancetype)initWithPlatformName:(NSString *)platformName
                     platformAddress:(NSString *)platformAddress
                 platformDescription:(NSString *)platformDescription
                            userName:(NSString *)userName
                             userPsw:(NSString *)userPsw
                            otherPsw:(NSString *)otherPsw;

@end


