//
//  PXJCustomAlert.h
//  PXJAlertView
//
//  Created by Jack2 on 2018/5/22.
//  Copyright © 2018年 JackP. All rights reserved.
//
//PS
/*
 whose view is not in the window hierarchy!
 1. 在 一个 ViewController 里面调用另外一个 ViewController 是出现这个错误：
 该错误一般是由于在 viewDidLoad 里面调用引起的，解决办法是转移到 viewDidAppear 方法里面
 2.
 */
#import <UIKit/UIKit.h>
#import "PXJCAlertAction.h"

@interface PXJCustomAlert : UIViewController
@property(nonatomic,strong)UIColor *titleColor;
@property(nonatomic,strong)UIFont *titleFont;

@property(nonatomic,strong)UIColor *messageColor;
@property(nonatomic,strong)UIFont *messageFont;

@property(nonatomic,strong)UIColor *lineColor;
@property(nonatomic,assign)CGFloat lineThick;

@property(nonatomic,assign)CGFloat cornerRadius;

+ (PXJCustomAlert *)alertWithMessage:(NSString *)message;
+ (PXJCustomAlert *)alertWithTile:(NSString *)title withMessage:(NSString *)message;

- (void)addAlertAction:(PXJCAlertAction *)alertAction;

- (void)showAlert;
@end
