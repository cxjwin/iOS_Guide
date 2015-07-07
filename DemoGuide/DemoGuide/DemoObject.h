//
//  DemoObject.h
//  DemoGuide
//
//  Created by 燃烧吧少年 on 15/7/7.
//  Copyright (c) 2015年 mobi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DemoObject : NSObject
// Xcode4.3 以后不需要手写实例变量来实现Set/Get方法了
// 一般的不需要在给属性添加对应的实例变量，Xcode会为我们自动生成
/*
{
    NSString *_objectName;
}
*/

// 对象的名称
// 注意空格的使用
// 具体空格处如下:
@property (nonatomic, copy) NSString *objectName;

// 尽量不要随便覆盖系统的方法，这里的description是只读的
//@property (readonly, copy) NSString *description;
//@property (nonatomic, copy) NSString *description;

// 采用小驼峰命名规则，一般情况下首字母小写
//@property (nonatomic, copy) NSString *ObjectName;

// 一些通用的大写（或是缩写）开头的除外，可以用大写字母开头，比如URL
// 比如NSURLComponents类中的@property (readonly, copy) NSURL *URL;
// 当让也可以小写，比如NSURL类中的 _urlString 实例变量

// 尽量不要使用“_”来命名属性
//@property(nonatomic, copy) NSString *object_name;

// 尽量使用全拼,减少使用自己定义的而非通用的缩写,照成其他人不明白属性的意思
// 不建议,但可接受
//@property (nonatomic, copy) NSString *cusDes;
// 建议
@property (nonatomic, copy) NSString *customDescription;

// 以下是建议使用copy的属性
// 因为当赋值的时候使用mutable类型的值的时候会做一次copy,将其转变为immutable类型的,更加的安全
// NSString
@property (nonatomic, copy) NSString *stringValue;
// NSArray
@property (nonatomic, copy) NSArray *immutableArray;
// NSDictionary
@property (nonatomic, copy) NSDictionary *immutableDictionary;



@end
