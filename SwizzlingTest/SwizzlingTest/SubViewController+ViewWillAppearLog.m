//
//  SubViewController+ViewWillAppearLog.m
//  SwizzlingTest
//
//  Created by Michalis Mavris on 05/07/2017.
//  Copyright © 2017 Miksoft. All rights reserved.
// https://github.com/mavris/Medium.com/tree/master/SwizzlingTest/SwizzlingTest


#import "SubViewController+ViewWillAppearLog.h"
#import <objc/runtime.h>

@implementation SubViewController (ViewWillAppearLog)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL defaultSelector = @selector(viewWillAppear:);
        SEL swizzledSelector = @selector(swizzled_viewWillAppear:);
        
        // 1) The  IMP of default method will point on UIViewController's viewWillAppear implementation
        Method defaultMethod = class_getInstanceMethod(class, defaultSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        // 2) Here we add the method defaultSelector with the IMP to point on swizzledMethod's implementation.
        BOOL isMethodExists = !class_addMethod(class, defaultSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        
        if (isMethodExists) {
            method_exchangeImplementations(defaultMethod, swizzledMethod);
        }
        else {
            // 3) We replace swizzledSelector method with the method that defaultMethod was pointing (The initial value which points on UIViewController's viewWillAppear IMP). Note that if we run class_getInstanceMethod(class, swizzledSelector); will get the method that we add point 2 instead of the initial.
            class_replaceMethod(class, swizzledSelector, method_getImplementation(defaultMethod), method_getTypeEncoding(defaultMethod));
        }
    });
}

#pragma mark - Method Swizzling
- (void)swizzled_viewWillAppear:(BOOL)animated {
    [self swizzled_viewWillAppear:animated];
    NSLog(@"View appeared and logged");
}

@end
