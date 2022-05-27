//
//  UITextField+DeleteBack.m
//  VerifyCode
//
//  Created by chen on 2019/10/17.
//  Copyright © 2019年 chen. All rights reserved.
//

#import "UITextField+DeleteBackWord.h"
#import <objc/runtime.h>

NSString * const TextFieldDidDeleteBackwardNotification = @"TextFieldDidDeleteBackwardNotification";

@implementation UITextField (DeleteBackWord)
+ (void)load {
    Method method1 = class_getInstanceMethod([self class], NSSelectorFromString(@"deleteBackward"));
    Method method2 = class_getInstanceMethod([self class], @selector(textField_deleteBackward));
    method_exchangeImplementations(method1, method2);
}

- (void)textField_deleteBackward {
    [[NSNotificationCenter defaultCenter] postNotificationName:TextFieldDidDeleteBackwardNotification object:nil];
}

@end
