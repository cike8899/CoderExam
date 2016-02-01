//
//  FJSandboxUtil.h
//  YimallsIos
//
//  Created by 刘少明 on 16/1/16.
//  Copyright © 2016年 FJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FJSandboxUtil : NSObject

+ (NSString *)buildSandboxPath;

+ (void)writeToSandbox:(NSMutableDictionary *)user;

+ (NSMutableDictionary *)readFromSandbox;

+ (void)deleteSandbox;

@end
