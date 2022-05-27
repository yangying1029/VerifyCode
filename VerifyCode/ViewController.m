//
//  ViewController.m
//  VerifyCode
//
//  Created by chen on 2019/10/17.
//  Copyright © 2019年 chen. All rights reserved.
//

#import "ViewController.h"
#import "VerifyCodeView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    VerifyCodeView *view = [[VerifyCodeView alloc] init];
    
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(200);
        make.width.equalTo(self.view);
        make.height.equalTo(@60);
    }];
    
    view.isSecure = NO;
    __weak VerifyCodeView *weakView = view;
    view.codeInputCompeletBlock = ^(NSString * _Nonnull codeString) {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"输入信息" message:codeString preferredStyle:(UIAlertControllerStyleAlert)];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            [weakView clearCode];
        }];
        
        [alertVC addAction:action];
        
        [self presentViewController:alertVC animated:YES completion:nil];
        
        
    };
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

@end
