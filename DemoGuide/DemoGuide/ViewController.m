//
//  ViewController.m
//  DemoGuide
//
//  Created by 燃烧吧少年 on 15/7/7.
//  Copyright (c) 2015年 mobi. All rights reserved.
//

// 关于头文件的引用采用如下的顺序
@import Foundation;
#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "UIColor+DescriptionTwo.h"

// 或者
#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "UIColor+DescriptionTwo.h"
@import Foundation;

// 关于宏的使用要注意下,不建议过多的使用

// 比如下面这种一定要注意加个括号
//#define kDOUBLE_SCREEN_WIDTH CGRectGetWidth([UIScreen mainScreen].bounds) * 2
#define kDOUBLE_SCREEN_WIDTH (CGRectGetWidth([UIScreen mainScreen].bounds) * 2)

// 这样其实可以使用内联函数替代,因为内联函数更容易检测到错误
static inline CGFloat doubleScreenWidth() {
    return CGRectGetWidth([UIScreen mainScreen].bounds) * 2;
}

// 对应extern的声明的变量进行定义
NSString *const kAnotherNotificationName = @"kAnotherNotificationName";

@interface UIColor (DescriptionOne)

- (void)colorDescription;

@end

@implementation UIColor (DescriptionOne)

- (void)colorDescription {
    NSLog(@"desc one");
}

@end

@interface ViewController ()

@end

@implementation ViewController {
    // 实例变量名之前Google的代码规范建议是带一个"_"以便于和属性区分开
    
    // 自定义的界面
    UIView *customView;
    
    // 自定义按钮
    UIButton *_customButton;
}

// 方法的调用注意空格的使用
// -/+ 和 (返回值) 之间应该有一个空格.


// 大括号可以换行
+ (void)initialize
{
    if (self == [ViewController class]) {
        //
    }
}

// 大括号也可以不换行, 不换行的需要和方法名之间有一个空格
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 变量名也要有意义
    UIColor *color = [UIColor whiteColor];
    // 减少没有意思的变量名
    // UIColor *c = [UIColor whiteColor];
    // 或者过于简短的缩写
    // UIColor *col = [UIColor whiteColor];
    
    // 使用美式英语为主, 避免使用英式英语, 比如colour是英式英语, 不建议使用如下变量名
    // UIColor *colour = [UIColor whiteColor];

    // 对于调用相同方法名的类别方法, 行为是不确认的
    // 这也是类别方法加一个前缀的原因, 和别的模块区分开
    [color colorDescription];
    
    
    // 有些返回值应该需要使用临时的中间变量存储一下,是的逻辑更加的清晰
    // 比如如下的使用,就能使得代码更加清晰
    BOOL viewIsAppearing = ([self isBeingPresented] || [self isMovingToParentViewController]);
    BOOL viewIsDisappearing = ([self isBeingDismissed] || [self isMovingFromParentViewController]);
    // 转场动画正在进行的时候, 不要做任何操作
    if (viewIsAppearing || viewIsDisappearing) {
        // ...
    }
    
    // CGFloat的变量统一使用CGFloat,
    CGFloat width = kDOUBLE_SCREEN_WIDTH;
    // 避免使用float
    // float fWidth = kDOUBLE_SCREEN_WIDTH;
    
    // 定义的变量要使用, 不然会有警告. 不要忽视这样警告.
    // 如果定义的变量已经不再使用, 那么注释掉或者删掉, 留着时间长了会照成误解
    NSLog(@"%f", width);
    
    // 关于大括号, 代码块的使用, 大括号内的对象是有生命周期的, 出了大括号的话, 里面的对象就被释放掉了
    // 巧妙的使用大括号, 可以使得代码更清晰整洁
    {
        // 这里的width的作用域仅限于大阔内, 不建议这么使用, 这里仅作例子
        CGFloat width = doubleScreenWidth();
    }
    
    
    // 三个叹号可以着重标记, 可以快速查找
    // !!!: 宏的使用
    NSLog(@"macro : double screen width : %f", kDOUBLE_SCREEN_WIDTH);
    NSLog(@"inline: double screen width : %f", doubleScreenWidth());
    
    // MARK也可以进行着重标记
    // MARK: block的使用
    // 如果代码较多, 就应该考虑抽象出一个方法出来
    [self showHowToUseBlocks];
    
    // 三个问号可以着重标记, 可以快速查找
    // ???: 方法的调用
    [self showHowToCallMethods];
    
    // 条件语句的使用
    [self showHowToUseControlFlow];
    
    // 快速枚举的使用
    [self showHowToFastEnumerator];
    
    // 运算也需要注意空格, 可以多添加一些括号帮助理解
    NSInteger sum = 1 + 2 + 3;
    sum = sum * 3;
    sum += 2;
    ++sum;
    
    sum = 1 + 2 + 3 * 4;
    sum = 1 + 2 + 3*4;
}

// 展示block的规范
- (void)showHowToUseBlocks
{
    // 简单同步block
    void (^syncBlock)() = ^{
        NSLog(@"sync block");
    };
    syncBlock();
    
    // 简单异步block, 这种下一个runloop就调用的block就不需要weak下self了
    void (^asyncBlock)() = ^{
        NSLog(@"async block");
    };
    dispatch_async(dispatch_get_main_queue(), asyncBlock);
    
    // 较长延时的block, 主要是网络的异步, 需要weak下self
    // 主要避免循环引用
    __weak typeof(self) weakSelf = self;
    void (^delayAsyncBlock)() = ^{
        // 将weakSelf强引用一下, 这样保证了在这个block块执行期间,strongSelf一直有效,不会被释放掉
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf == nil) return;
        
        NSLog(@"strong self : %@", strongSelf);
    };
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), delayAsyncBlock);
    
    // 直接当参数使用的block
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"%s", __func__);
    });
    
    // 代码行数较多的block块
    // 建议将block单独定义成变量
    void (^largeBlock)() = ^{
        // balabala....
        NSLog(@"step 1");
        // 此处省略N行代码
        
        // balabala....
        NSLog(@"step 2");
        // 此处省略N行代码
        
        // balabala....
        NSLog(@"step 3");
        // 此处省略N行代码
        
        // balabala....
        NSLog(@"step 4");
        // 此处省略N行代码
    };
    // 调用largeBlock变量
    dispatch_async(dispatch_get_main_queue(), largeBlock);
    
    
    // 多个block参数的使用
    // 第一种
    [UIView animateWithDuration:0.3 animations:^{
        // ...
    } completion:^(BOOL finished) {
        // ...
    }];
    
    // 第二种
    [UIView animateWithDuration:0.3
                     animations:^{
                         // ...
                     } completion:^(BOOL finished) {
                         // ...
                     }];
    
    
}

- (void)showHowToCallMethods {
    // 一行显示
    [self performSelector:@selector(description) withObject:nil afterDelay:1.0];
    
    // 换行显示
    [self performSelector:@selector(description)
               withObject:nil
               afterDelay:1.0];
    
    
}

- (void)showHowToUseControlFlow {
    BOOL flag = YES;
    if (flag) {
        // ...
    } else {
        // ...
    }
    
    // 注释1
    if (flag) {
        
    }
    // 注释2
    else {
        
    }
    
    // 不建议如下使用if/else
    if (flag)
        NSLog(@"if 没有大括号...");
    else
        NSLog(@"else 没有大括号...");
    
    
    NSInteger num = 2;
    switch (num) {
        case 1: {
            // switch里面代码较多的话需要加上大括号
        }
            break;
            
            // 关于条件的注释
        case 2: {
            // 大括号也可以加在break后面
            break;
        }
            
        case 3:
            // 简单的几行代码, 可以不适用大括号
            break;
            
        default:
            break;
    }
}

- (void)showHowToFastEnumerator {
    // 建议使用Modern Objective-C 语法
    NSArray *nums = @[@1, @2, @3, @4, @5, @6];
    
    // 推荐使用
    [nums enumerateObjectsUsingBlock:^(NSNumber *num, NSUInteger idx, BOOL *stop) {
        //
    }];
    
    // 一般使用
    for (NSNumber *num in nums) {
        NSLog(@"%@", num);
    }
    
    // 不建议使用, 不够现代化
    NSUInteger count = nums.count;
    // for循环的使用注意空格
    for (NSUInteger index = 0; index < count; ++index) {
        // 建议使用Modern Objective-C 语法
        NSNumber *num = nums[index];
        NSLog(@"%@", num);
    }
    
    // 也不建议这么使用, 不够现代化
    NSNumber *num = nil;
    NSEnumerator *enumerator = [nums objectEnumerator];
    while ((num = enumerator.nextObject) != nil) {
        NSLog(@"%@", num);
    }
    
    // 字典的使用
    NSDictionary *dictionary = @{@1 : @"1",
                                 @2 : @"2",
                                 @3 : @"3",
                                 @4 : @"4"};
    
    [dictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        //
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
