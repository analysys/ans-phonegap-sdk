//
//  AnalysysPlugin.h
//  AnalysysPhoneGap
//
//  Created by SoDo on 2018/8/31.
//

#import <Foundation/Foundation.h>
#import <Cordova/CDV.h>

@interface AnalysysPlugin : CDVPlugin

#pragma mark *** 事件跟踪 ***

/**
 事件跟踪
 
 - 第一个参数为事件名称
 - 第二个参数为事件属性
 
 @param command PhoneGap传入参数列表
 */
- (void)track:(CDVInvokedUrlCommand*)command;

/**
 页面跟踪
 
 - 第一个参数为页面名称
 - 第二个参数为页面属性

 @param command PhoneGap传入参数列表
 */
- (void)pageView:(CDVInvokedUrlCommand*)command;


#pragma mark *** 通用属性 ***

/**
 注册单个通用属性
 
 - 第一个参数为通用属性key，key必须为字符串类型
 - 第二个参数为通用属性value， value必须为字符串/数组/map结构

 @param command PhoneGap传入参数列表
 */
- (void)registerSuperProperty:(CDVInvokedUrlCommand*)command;

/**
 注册多个通用属性
 
 - 参数必须为map类型
 - map中key必须为字符串类型，value必须为字符串/数组/map结构
 
 @param command PhoneGap传入参数列表
 */
- (void)registerSuperProperties:(CDVInvokedUrlCommand*)command;

/**
 删除单个通用属性

 @param command PhoneGap传入参数列表，已注册通用属性key
 */
- (void)unRegisterSuperProperty:(CDVInvokedUrlCommand*)command;

/**
 清除所有通用属性
 */
- (void)clearSuperProperties:(CDVInvokedUrlCommand*)command;

/**
 获取某个通用属性
 
 - 通过回调方式返回属性值

 @param command PhoneGap传入参数列表，已注册通用属性key
 */
- (void)getSuperProperty:(CDVInvokedUrlCommand*)command;

/**
 获取已注册通用属性
 
 - 通过回调方式返回所有属性列表

 @param command PhoneGap传入参数列表
 */
- (void)getSuperProperties:(CDVInvokedUrlCommand*)command;


#pragma mark *** 用户属性 ***

/**
 用户ID设置，长度大于0且小于255字符
 
 - 用户表示必须为字符串类型

 @param command PhoneGap传入参数列表
 */
- (void)identify:(CDVInvokedUrlCommand*)command;

/**
 用户关联，长度大于0且小于255字符
 
 - 第一个参数为将要使用的用户标识
 - 第二个参数为原有用户标识

 @param command PhoneGap传入参数列表，必须都为字符串
 */
- (void)alias:(CDVInvokedUrlCommand*)command;

/**
 设置用户属性
 
 @param property PhoneGap传入参数列表，必须都为map结构
  */
- (void)profileSet:(CDVInvokedUrlCommand*)command;

/**
 设置用户固有属性

 @param command PhoneGap传入参数列表，必须都为map结构
 */
- (void)profileSetOnce:(CDVInvokedUrlCommand*)command;

/**
 设置用户属性相对变化值

 @param command PhoneGap传入参数列表，必须都为map结构
 */
- (void)profileIncrement:(CDVInvokedUrlCommand*)command;

/**
 增加列表类型的属性

 @param command PhoneGap传入参数列表，必须都为map结构
 */
- (void)profileAppend:(CDVInvokedUrlCommand*)command;

/**
 删除某个用户属性

 @param command PhoneGap传入参数列表，必须为字符串
 */
- (void)profileUnset:(CDVInvokedUrlCommand*)command;

/**
 删除当前用户的所有属性
 */
- (void)profileDelete:(CDVInvokedUrlCommand*)command;


#pragma mark *** 清除本地设置 ***

/**
 清除本地设置（distinctID、aliasID、superProperties）
 */
- (void)reset:(CDVInvokedUrlCommand*)command;



@end





