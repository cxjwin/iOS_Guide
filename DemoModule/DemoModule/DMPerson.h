//
//  DMPerson.h
//  DemoModule
//
//  Created by cxjwin on 7/7/15.
//  Copyright (c) 2015 mobi. All rights reserved.
//

#import <Foundation/Foundation.h>

// 模块中自定义的类,建议加一个前缀,以示区分

/**
 这个是关于类的描述注释, 可以简单描述下这个类是做什么
 */
@interface DMPerson : NSObject

// 名字
@property (copy) NSString *name;

// 尽量使用Foundation中的系统变量类型
// 年龄
@property (assign) NSInteger age;

// 避免使用如下不兼容32位和64的类型
//@property (assign) int age;

// 关于方法的注释
/**
 测试方法
 */
- (void)test;

/**
 带一个参数的测试方法
 
 @param argument 测试参数
 */
- (void)testWithArgument:(id)argument;

/**
 两个参数的测试方法,参数尽量要有意义
 测试名字和年龄
 
 @param name 名字
 @param age  年龄
 */
- (void)testWithName:(NSString *)name age:(NSInteger)age;

/**
 根据名字和年龄生成描述信息
 
 @param name 名字
 @param age  年龄
 
 @return 描述信息
 */
- (NSString *)descriptionForName:(NSString *)name age:(NSInteger)age;
// 一般的方法声明中不要带"_", 还是采用小驼峰的命名方法
// - (NSString *)description_for_name:(NSString *)name age:(NSInteger)age;

@end
