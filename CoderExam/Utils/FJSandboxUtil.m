//
//  FJSandboxUtil.m
//  YimallsIos
//
//  Created by 刘少明 on 16/1/16.
//  Copyright © 2016年 FJ. All rights reserved.
//

#import "FJSandboxUtil.h"

@implementation FJSandboxUtil

+ (NSString *)buildSandboxPath {
    NSString *home = NSHomeDirectory();
    NSString *docPath = [home stringByAppendingPathComponent:@"Documents"];
    
    // 3.文件路径
    NSString *filePath = [docPath stringByAppendingPathComponent:@"user.plist"];
    return filePath;
}

+ (void)writeToSandbox:(NSMutableDictionary *)user {
    NSString *filePath = [self buildSandboxPath];
    NSMutableDictionary *rootDict = [NSMutableDictionary dictionaryWithObject:user forKey:@"user"];
    //    NSDictionary *rootDict = @{
    //                               @"user":user
    //                               };
    [rootDict writeToFile:filePath atomically:YES];
}

+ (NSMutableDictionary *)readFromSandbox {
    NSString *filePath = [self buildSandboxPath];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:filePath];
    return dict[@"user"];
}

+ (void)deleteSandbox {
    NSString *filePath = [self buildSandboxPath];
    
    NSFileManager* fileManager = [NSFileManager defaultManager];
    //    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    
    BOOL exists = [fileManager fileExistsAtPath:filePath];
    if (!exists) {
        NSLog(@"Not exists.");
        return ;
    }else {
        NSLog(@"Do exists.");
        BOOL deleteSuccessfully = [fileManager removeItemAtPath:filePath error:nil];
        if (deleteSuccessfully) {
            NSLog(@"Delete uccessfully.");
        }else {
            NSLog(@"Delete failed.");
        }
        
    }
}

@end
