
//
//  NSUserDefaults+MyUserDefaults.m
//  SwizzlingTest
//
//  Created by Michalis Mavris on 05/07/2017.
//  Copyright © 2017 Miksoft. All rights reserved.
// https://github.com/mavris/Medium.com/tree/master/SwizzlingTest/SwizzlingTest

#import "NSUserDefaults+MyUserDefaults.h"

@implementation NSUserDefaults (MyUserDefaults)
-(void)mySetObject:(id)value forKey:(NSString *)defaultName {
    [self setObject:value forKey:defaultName];
    NSLog(@"Set object %@ for key %@",value,defaultName);
}
@end
