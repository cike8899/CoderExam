//
//  ConstantsUtil.m
//  blindDateIP
//
//  Created by 刘少明 on 15/12/3.
//  Copyright © 2015年 刘少明. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FJConstantsUtil.h"

@interface FJConstantsUtil()
@end

@implementation FJConstantsUtil

+ (NSMutableDictionary *)rootDictionary {
    
    NSString *file = [[NSBundle mainBundle] pathForResource:@"constants" ofType:@"plist"];
    return [NSMutableDictionary dictionaryWithContentsOfFile:file];
}

+ (NSString *)hostUrl {
    return [self rootDictionary][@"url"][@"hostUrl"];
}

+ (NSString *)loginPath {
    return [self rootDictionary][@"url"][@"loginPath"];
}

+ (NSString *)registerPath {
    return [self rootDictionary][@"url"][@"registerPath"];
}

+ (NSString *)remoteServerUrl {
    return [self rootDictionary][@"url"][@"remoteServerUrl"];
}

+ (NSString *)commodityListPath {
    return [self rootDictionary][@"url"][@"commodityListPath"];
}

+ (NSString *)commodityDetailPath {
    return [self rootDictionary][@"url"][@"commodityDetailPath"];
}

+ (NSString *)cartAddPath {
    return [self rootDictionary][@"url"][@"cartAddPath"];
}

+ (NSString *)cartListPath {
    return [self rootDictionary][@"url"][@"cartListPath"];
}

@end
