//
//  FJImageUtil.m
//  YimallsIos
//
//  Created by 刘少明 on 16/1/1.
//  Copyright © 2016年 FJ. All rights reserved.
//

#import "FJImageUtil.h"

@implementation FJImageUtil

+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size {
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

@end
