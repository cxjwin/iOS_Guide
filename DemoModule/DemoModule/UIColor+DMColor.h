//
//  UIColor+DMColor.h
//  DemoModule
//
//  Created by cxjwin on 7/7/15.
//  Copyright (c) 2015 mobi. All rights reserved.
//

#import <UIKit/UIKit.h>

// 模块中可以给自己的类别加一个前缀, 以示区别其他的模块
@interface UIColor (DMColor)

// 包括方法也是,可以适当加一个前缀,前缀的首字母大小写没有好的建议
// Google的代码规范里面用的是小写,个人觉得大写也没什么不妥
- (UIColor *)dm_whiteColor;

@end
