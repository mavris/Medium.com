//
//  NSUserDefaults+MonitorWrites.m
//  SwizzlingTest
//
//  Created by Michalis Mavris on 05/07/2017.
//  Copyright © 2017 Miksoft. All rights reserved.
// https://github.com/mavris/Medium.com/tree/master/SwizzlingTest/SwizzlingTest

#import "NSUserDefaults+MonitorWrites.h"
#import <objc/runtime.h>

@implementation NSUserDefaults (MonitoringWrites)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL defaultSelector = @selector(setObject:forKey:);
        SEL swizzledSelector = @selector(swizzled_setObject:forKey:);
        
        Method defaultMethod = class_getInstanceMethod(class, defaultSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL isMethodExists = !class_addMethod(class, defaultSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        
        if (isMethodExists) {
            method_exchangeImplementations(defaultMethod, swizzledMethod);
        }
        else {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(defaultMethod), method_getTypeEncoding(defaultMethod));
        }
    });
}

#pragma mark - Method Swizzling
- (void)swizzled_setObject:(id)value forKey:(NSString *)defaultName {
    [self swizzled_setObject:value forKey:defaultName];
    NSLog(@"Set Object %@ for key %@",value,defaultName);
}

@end
