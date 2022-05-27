//
//  VerifyCodeView.h
//  VerifyCode
//
//  Created by chen on 2019/10/17.
//  Copyright © 2019年 chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry/Masonry.h"
NS_ASSUME_NONNULL_BEGIN
/**
 监听输入完成的通知
 */
extern NSString * const CodeDidInputCompeletNotification;

@interface VerifyCodeView : UIView

/**
 设置好属性后调用初始化密码框方法
 */
- (void)initCodeView;

/**
 清除输入密码
 */
- (void)clearCode;

/**
 默认yes
 */
@property (nonatomic,assign) BOOL isSecure;

/**
 输入完成后的回调
 */
@property (nonatomic,copy) void (^codeInputCompeletBlock) (NSString *codeString);

@end

NS_ASSUME_NONNULL_END
