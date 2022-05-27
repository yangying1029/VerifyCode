//
//  VerifyCodeView.m
//  VerifyCode
//
//  Created by chen on 2019/10/17.
//  Copyright © 2019年 chen. All rights reserved.
//

#import "VerifyCodeView.h"
#import "UITextField+DeleteBackWord.h"

#define MARGIN 20

NSString *const CodeDidInputCompeletNotification = @"CodeDidInputCompeletNotification";

@interface VerifyCodeView ()
@property (nonatomic,strong) UIView *bgView;

@property (nonatomic,strong) UILabel *label1;
@property (nonatomic,strong) UILabel *label2;
@property (nonatomic,strong) UILabel *label3;
@property (nonatomic,strong) UILabel *label4;
@property (nonatomic,strong) UILabel *label5;
@property (nonatomic,strong) UILabel *label6;

@property (nonatomic,strong) UITextField *textField;
@property (nonatomic,strong) NSMutableArray <UILabel *>*labelArray;

@property (nonatomic,copy) NSString *codeString;
@end

@implementation VerifyCodeView
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.labelArray = [NSMutableArray array];
        self.isSecure = YES;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteBackward) name:TextFieldDidDeleteBackwardNotification object:nil];
        [self initUI];
    }
    return self;
}


- (void)initUI {
    _bgView = [[UIView alloc] init];
    _bgView.layer.borderColor = [[UIColor blackColor] colorWithAlphaComponent:0.3].CGColor;
    _bgView.layer.borderWidth = 1;
    _bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_bgView];
    
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.bottom.equalTo(self);
        make.left.equalTo(self).offset(MARGIN);
        make.right.equalTo(self).offset(-MARGIN);
        
    }];
    
    CGFloat width = ([UIScreen mainScreen].bounds.size.width - 2 * MARGIN) / 6;
    
    for (int i = 0; i < 6; i ++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:20];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = nil;
        [_bgView addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.equalTo(self).offset(i * width + MARGIN);
            make.width.mas_equalTo(@(width));
        }];
        label.tag = i;
        [self.labelArray addObject:label];
    }

    
    for (int i = 0; i < 5; i ++) {
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        [_bgView addSubview:line];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.equalTo(self).offset((i + 1) * width - 0.5 + MARGIN);
            make.width.mas_equalTo(@(1));
        }];
    }
    
    _textField = [[UITextField alloc] init];
    [self addSubview:_textField];
    
    [_textField becomeFirstResponder];
    _textField.keyboardType = UIKeyboardTypeNumberPad;
    [_textField addTarget:self action:@selector(textDidChanged:) forControlEvents:(UIControlEventEditingChanged)];
}

- (void)textDidChanged:(UITextField *)textField {
    
    if (textField.text.length >= 6) {
        
        for (int i = 0; i < self.labelArray.count; i ++) {
            UILabel *label = self.labelArray[i];
            label.text = [textField.text substringFromIndex:i + 1];
            if (_isSecure) {
                label.text = @"●";
            }
        }
        if (textField.text.length == 6) {
            _codeString = textField.text;
        }else {
            _codeString = [textField.text substringToIndex:6];
        }
        
    }else {
        for (int i = 0; i < self.labelArray.count; i ++) {
            UILabel *label = self.labelArray[i];
            
            if (label.text == nil) {
                label.text = textField.text;
                if (_isSecure) {
                    label.text = @"●";
                }
                break;
            }
        }
    }

    
    if (_codeString.length < 6) {
        if (_codeString == nil) {
            _codeString = textField.text;
        }else {
            _codeString = [_codeString stringByAppendingString:textField.text];
        }
    }

    textField.text = nil;
    
    if (_codeString.length == 6 && _codeString != nil) {
        if (_codeInputCompeletBlock) {
            _codeInputCompeletBlock (_codeString);
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:CodeDidInputCompeletNotification object:_codeString];
    }
    
    NSLog(@"%@",_codeString);
}


- (void)deleteBackward {
    
    for (int i = (int)self.labelArray.count - 1; i >= 0; i --) {
        UILabel *label = self.labelArray[i];
        
        if (label.text != nil) {
            label.text = nil;
            if (_codeString != nil) {
                _codeString = [_codeString substringToIndex:i];
                if (i == 0) {
                    _codeString = nil;
                }
            }
            break;
        }
    }
    NSLog(@"%@",_codeString);
}

- (void)clearCode {
    for (UILabel *label in self.labelArray) {
        label.text = nil;
    }
    _codeString = nil;
    _textField.text = nil;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
