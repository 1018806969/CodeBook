//
//  NSString+HelpTools.m
//  CodeBook
//
//  Created by Merlin on 2018/3/26.
//  Copyright © 2018年 lq. All rights reserved.
//

#import "NSString+HelpTools.h"

@implementation NSString (HelpTools)

- (BOOL)isURL
{
    if (self == nil) return NO;
    
    NSString *url;
    if (self.length > 4 && [[self substringToIndex:4] isEqualToString:@"www."]) {
        url = [NSString stringWithFormat:@"http://%@",self];
    } else {
        url = self;
    }
    NSString *urlRegular = @"\\bhttps?://[a-zA-Z0-9\\-.]+(?::(\\d+))?(?:(?:/[a-zA-Z0-9\\-._?,'+\\&%$=~*!():@\\\\]*)+)?";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegular];
    return [predicate evaluateWithObject:url];
}

@end
