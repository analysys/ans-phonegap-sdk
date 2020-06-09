//
//  AnalysysPlugin.m
//  AnalysysPhoneGap
//
//  Created by SoDo on 2018/8/31.
//

#import "AnalysysPlugin.h"
#import <AnalysysAgent/AnalysysAgent.h>

static NSString *const ANALYSYS_LOG = @"[AnalysysPlugin]";

@implementation AnalysysPlugin

#pragma mark *** 事件跟踪 ***

- (void)track:(CDVInvokedUrlCommand*)command {
    NSArray *args = command.arguments;
    if (args.count == 0 || args.count > 2) {
        return;
    }
    @try {
        NSString *event = [args objectAtIndex:0];
        if (event == nil || [event isKindOfClass:[NSNull class]]) {
            NSLog(@"%@ track: 事件标识不能为空", ANALYSYS_LOG);
            return;
        }
        NSDictionary *properties = [NSDictionary dictionary];
        if (args.count == 2) {
            id property = [args objectAtIndex:1];
            if ([property isKindOfClass:[NSDictionary class]]) {
                properties = (NSDictionary *)property;
            }
        }
        [AnalysysAgent track:event properties:properties];
    } @catch (NSException *exception) {
        NSLog(@"%@ exception: %@", ANALYSYS_LOG, exception);
    }
}

- (void)pageView:(CDVInvokedUrlCommand*)command {
    NSArray *args = command.arguments;
    if (args.count == 0 || args.count > 2) {
        return;
    }
    @try {
        NSString *pageView = [args objectAtIndex:0];
        if (pageView == nil || [pageView isKindOfClass:[NSNull class]]) {
            NSLog(@"%@ pageView: 页面标识不能为空", ANALYSYS_LOG);
            return;
        }
        NSDictionary *properties = [NSDictionary dictionary];
        if (args.count == 2) {
            id property = [args objectAtIndex:1];
            if ([property isKindOfClass:[NSDictionary class]]) {
                properties = (NSDictionary *)property;
            }
        }
        [AnalysysAgent pageView:pageView properties:properties];
    } @catch (NSException *exception) {
        NSLog(@"%@ exception: %@", ANALYSYS_LOG, exception);
    }
}

#pragma mark *** 通用属性 ***

- (void)registerSuperProperty:(CDVInvokedUrlCommand*)command {
    NSArray *args = command.arguments;
    if (args.count != 2) {
        NSLog(@"%@ registerSuperProperty: 参数必须为两个",ANALYSYS_LOG);
        return;
    }
    @try {
        [self.commandDelegate runInBackground:^{
            NSString *superPropertyName = [args objectAtIndex:0];
            id superPropertyValue = [args objectAtIndex:1];
            [AnalysysAgent registerSuperProperty:superPropertyName value:superPropertyValue];
        }];
    } @catch (NSException *exception) {
        NSLog(@"%@ exception: %@", ANALYSYS_LOG, exception);
    }
}

- (void)registerSuperProperties:(CDVInvokedUrlCommand*)command {
    NSArray *args = command.arguments;
    if (args.count != 1) {
        NSLog(@"%@ registerSuperProperties: 参数必须为一个",ANALYSYS_LOG);
        return;
    }
    @try {
        id properties = [args objectAtIndex:0];
        if ([properties isKindOfClass:[NSDictionary class]]) {
            [self.commandDelegate runInBackground:^{
                [AnalysysAgent registerSuperProperties:properties];
            }];
        } else {
            NSLog(@"%@ registerSuperProperties: 参数必须为{key: value}}",ANALYSYS_LOG);
        }
    } @catch (NSException *exception) {
        NSLog(@"%@ exception: %@", ANALYSYS_LOG, exception);
    }
}

- (void)unRegisterSuperProperty:(CDVInvokedUrlCommand*)command {
    NSArray *args = command.arguments;
    if (args.count != 1) {
        NSLog(@"%@ unRegisterSuperProperty: 参数必须为一个",ANALYSYS_LOG);
        return;
    }
    @try {
        [self.commandDelegate runInBackground:^{
            [AnalysysAgent unRegisterSuperProperty:[args objectAtIndex:0]];
        }];
    } @catch (NSException *exception) {
        NSLog(@"%@ exception: %@", ANALYSYS_LOG, exception);
    }
}

- (void)clearSuperProperties:(CDVInvokedUrlCommand*)command {
    @try {
        [self.commandDelegate runInBackground:^{
            [AnalysysAgent clearSuperProperties];
        }];
    } @catch (NSException *exception) {
        NSLog(@"%@ exception: %@", ANALYSYS_LOG, exception);
    }
}


- (void)getSuperProperty:(CDVInvokedUrlCommand*)command {
    NSArray *args = command.arguments;
    if (args.count != 1) {
        NSLog(@"%@ getSuperProperty: 参数必须为一个",ANALYSYS_LOG);
        return;
    }
    NSString *propertyName = [args objectAtIndex:0];
    if (propertyName == nil || [propertyName isKindOfClass:[NSNull class]]) {
        NSLog(@"%@ getSuperProperty: 属性名称不能为空", ANALYSYS_LOG);
        return;
    }
    @try {
        [self.commandDelegate runInBackground:^{
            id propertyValue = [AnalysysAgent getSuperProperty:propertyName];
            if (propertyValue == nil) {
                propertyValue = @"";
            }
            CDVPluginResult *pluginResult;
            
            //  非NSNumber类型
            if ([propertyValue isKindOfClass:[NSString class]]) {
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:propertyValue];
            } else if ([propertyValue isKindOfClass:[NSArray class]]) {
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsArray:propertyValue];
            } else if ([propertyValue isKindOfClass:[NSDictionary class]]) {
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:propertyValue];
            } else {
                NSNumber *numberValue  = (NSNumber *)propertyValue;                
                //  NSNumber 类型
                if (strcmp([numberValue objCType], @encode(NSInteger)) == 0) {
                    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsNSInteger:[numberValue integerValue]];
                } else if (strcmp([numberValue objCType], @encode(BOOL)) == 0) {
                    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:[numberValue boolValue]];
                } else if (strcmp([numberValue objCType], @encode(int)) == 0) {
                    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsInt:[numberValue intValue]];
                } else if (strcmp([numberValue objCType], @encode(double)) == 0) {
                    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDouble:[numberValue doubleValue]];
                } else if (strcmp([numberValue objCType], @encode(char)) == 0) {
                    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:[numberValue boolValue]];
                } else {
                    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];;
                }
            }
            
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }];
    } @catch (NSException *exception) {
        NSLog(@"%@ exception: %@", ANALYSYS_LOG, exception);
    }
}

- (void)getSuperProperties:(CDVInvokedUrlCommand*)command {
    @try {
        [self.commandDelegate runInBackground:^{
            id propertyValue = [AnalysysAgent getSuperProperties];
            CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:propertyValue];
            if (propertyValue == nil) {
                propertyValue = @"";
            }
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }];
    } @catch (NSException *exception) {
        NSLog(@"%@ exception: %@", ANALYSYS_LOG, exception);
    }
}


#pragma mark *** 用户属性 ***

- (void)identify:(CDVInvokedUrlCommand*)command {
    NSArray *args = command.arguments;
    if (args.count != 1) {
        NSLog(@"%@ identify: 参数必须为一个",ANALYSYS_LOG);
        return;
    }
    @try {
        NSString *distinctID = [args objectAtIndex:0];
        if (distinctID == nil || [distinctID isKindOfClass:[NSNull class]]) {
            NSLog(@"%@ identify: 匿名标识不能为空", ANALYSYS_LOG);
            return;
        }
        [self.commandDelegate runInBackground:^{
            [AnalysysAgent identify:distinctID];
        }];
    } @catch (NSException *exception) {
        NSLog(@"%@ exception: %@", ANALYSYS_LOG, exception);
    }
}

- (void)alias:(CDVInvokedUrlCommand*)command {
    NSArray *args = command.arguments;
    if (args.count != 2) {
        NSLog(@"%@ alias: 参数必须为两个",ANALYSYS_LOG);
        return;
    }
    @try {
        NSString *aliasId = [args objectAtIndex:0];
        NSString *originalId = [args objectAtIndex:1];
        [AnalysysAgent alias:aliasId originalId:originalId];
    } @catch (NSException *exception) {
        NSLog(@"%@ exception: %@", ANALYSYS_LOG, exception);
    }
}

- (void)profileSet:(CDVInvokedUrlCommand*)command {
    NSArray *args = command.arguments;
    if (args.count == 0) {
        NSLog(@"%@ profileSet: 参数不能为空",ANALYSYS_LOG);
        return;
    }
    @try {
        id property = args[0];
        if ([property isKindOfClass:[NSDictionary class]]) {
            //  携带多个属性
            [AnalysysAgent profileSet:property];
            return;
        } else if ([property isKindOfClass:[NSString class]]) {
            if (args.count == 2) {
                id propertyValue = args[1];
                [AnalysysAgent profileSet:property propertyValue:propertyValue];
                return;
            }
        }
        NSLog(@"%@ profileSet: 参数必须为{key, value}结构",ANALYSYS_LOG);
    } @catch (NSException *exception) {
        NSLog(@"%@ exception: %@", ANALYSYS_LOG, exception);
    }
}

- (void)profileSetOnce:(CDVInvokedUrlCommand*)command {
    NSArray *args = command.arguments;
    if (args.count == 0) {
        NSLog(@"%@ profileSetOnce: 参数不能为空",ANALYSYS_LOG);
        return;
    }
    @try {
        id property = args[0];
        if ([property isKindOfClass:[NSDictionary class]]) {
            //  携带多个属性
            [AnalysysAgent profileSetOnce:property];
            return;
        } else if ([property isKindOfClass:[NSString class]]) {
            if (args.count == 2) {
                id propertyValue = args[1];
                [AnalysysAgent profileSetOnce:property propertyValue:propertyValue];
                return;
            }
        }
        
        NSLog(@"%@ profileSetOnce: 参数必须为{key, value}结构",ANALYSYS_LOG);
    } @catch (NSException *exception) {
        NSLog(@"%@ exception: %@", ANALYSYS_LOG, exception);
    }
}

- (void)profileIncrement:(CDVInvokedUrlCommand*)command {
    NSArray *args = command.arguments;
    if (args.count == 0) {
        NSLog(@"%@ profileIncrement: 参数不能为空",ANALYSYS_LOG);
        return;
    }
    @try {
        id property = args[0];
        if ([property isKindOfClass:[NSDictionary class]]) {
            //  携带多个属性
            [AnalysysAgent profileIncrement:property];
            return;
        } else if ([property isKindOfClass:[NSString class]]) {
            if (args.count == 2) {
                id propertyValue = args[1];
                if ([propertyValue isKindOfClass:[NSNumber class]]) {
                    [AnalysysAgent profileIncrement:property propertyValue:propertyValue];
                    return;
                }
            }
        }
        
        NSLog(@"%@ profileIncrement: 参数必须为{key, value}结构",ANALYSYS_LOG);
    } @catch (NSException *exception) {
        NSLog(@"%@ exception: %@", ANALYSYS_LOG, exception);
    }
}

- (void)profileAppend:(CDVInvokedUrlCommand*)command {
    NSArray *args = command.arguments;
    if (args.count == 0) {
        NSLog(@"%@ profileAppend: 参数必须为一个",ANALYSYS_LOG);
        return;
    }
    @try {
        id property = args[0];
        if ([property isKindOfClass:[NSDictionary class]]) {
            //  携带多个属性
            [AnalysysAgent profileAppend:property];
            return;
        } else if ([property isKindOfClass:[NSString class]]) {
            if (args.count == 2) {
                id propertyValue = args[1];
                if ([propertyValue isKindOfClass:[NSArray class]]) {
                    [AnalysysAgent profileAppend:property propertyValue:propertyValue];
                } else {
                    [AnalysysAgent profileAppend:property value:propertyValue];
                }
                return;
            }
        }
        
        NSLog(@"%@ profileAppend: 参数必须为{key, value}结构",ANALYSYS_LOG);
    } @catch (NSException *exception) {
        NSLog(@"%@ exception: %@", ANALYSYS_LOG, exception);
    }
}

- (void)profileUnset:(CDVInvokedUrlCommand*)command {
    NSArray *args = command.arguments;
    if (args.count == 0) {
        NSLog(@"%@ profileUnset: 参数必须为一个",ANALYSYS_LOG);
        return;
    }
    @try {
        id propertyName = args[0];
        if ([propertyName isKindOfClass:[NSString class]]) {
            [AnalysysAgent profileUnset:propertyName];
        } else {
            NSLog(@"%@ profileUnset: 参数必须为 string 类型",ANALYSYS_LOG);
        }
    } @catch (NSException *exception) {
        NSLog(@"%@ exception: %@", ANALYSYS_LOG, exception);
    }
}

- (void)profileDelete:(CDVInvokedUrlCommand*)command {
    [AnalysysAgent profileDelete];
}

#pragma mark *** 清除本地设置 ***

- (void)reset:(CDVInvokedUrlCommand*)command {
    [AnalysysAgent reset];
}



@end





