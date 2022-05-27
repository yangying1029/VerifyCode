# VerifyCode
iOS验证码和密码输入框

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
