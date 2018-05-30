//
//  PXJCAlertButton.m
//  PXJAlertView
//
//  Created by Jack2 on 2018/5/22.
//  Copyright © 2018年 JackP. All rights reserved.
//

#import "PXJCAlertAction.h"
#define defaultActionHeight 45.0
#define defaultClickColor ([UIColor colorWithRed:(229.0/255.0) green:(229.0/255.0) blue:(229.0/255.0) alpha:1.0]);

@interface PXJCAlertAction()

@end
@implementation PXJCAlertAction

+ (PXJCAlertAction *)alertActionWithTitle:(NSString *)title withBlock:(PXJCAlertActionBlock)block{
    PXJCAlertAction *action = [[PXJCAlertAction alloc] initWithTitle:title withBlock:block];
    [action setTitle:title forState:UIControlStateNormal];
    return action;
}

- (instancetype)initWithTitle:(NSString *)title withBlock:(PXJCAlertActionBlock)block{
    if (self = [super init]) {
        [self setDefault];
        self.alertBlock = block;
    }
    return self;
}

- (void)setDefault{
    self.backgroundColor = [UIColor clearColor];
    
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleColor = [UIColor colorWithRed:24.0/255.0 green:184.0/255.0 blue:126.0/255.0 alpha:1.0];
    self.titleFont = [UIFont fontWithName:@"PingFangSC-Regular" size:(14.0)];
    self.actionHeight = defaultActionHeight;
    self.clickColor = defaultClickColor;
}

#pragma mark - set方法
- (void)setTitle:(NSString *)title{
    _title = title;
    [self setTitle:_title forState:UIControlStateNormal];
}

- (void)setActionHeight:(CGFloat)actionHeight{
    _actionHeight = actionHeight;
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, _actionHeight);
}

- (void)setClickColor:(UIColor *)clickColor{
    _clickColor = clickColor;
    [self setBackgroundImage:[self colorToImage:_clickColor] forState:UIControlStateHighlighted];
}

- (void)setTitleFont:(UIFont *)titleFont{
    _titleFont = titleFont;
    self.titleLabel.font = _titleFont;
}

- (void)setTitleColor:(UIColor *)titleColor{
    _titleColor = titleColor;
    [self setTitleColor:_titleColor forState:UIControlStateNormal];
}

//将颜色转换为图片
- (UIImage *)colorToImage:(UIColor *)color{
    CGRect rect = CGRectMake(0, 0, 1.0, 1.0);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


@end
