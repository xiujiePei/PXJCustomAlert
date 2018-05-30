//
//  PXJCAlertButton.h
//  PXJAlertView
//
//  Created by Jack2 on 2018/5/22.
//  Copyright © 2018年 JackP. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^PXJCAlertActionBlock) (void);
@interface PXJCAlertAction : UIButton

@property(nonatomic,copy)NSString *title;
@property(nonatomic,assign)CGFloat actionHeight;
@property(nonatomic,strong)UIFont *titleFont;
@property(nonatomic,strong)UIColor *titleColor;
@property(nonatomic,strong)UIColor *clickColor;//点击后按钮变成灰色
@property(nonatomic,copy)PXJCAlertActionBlock alertBlock;

+ (PXJCAlertAction *)alertActionWithTitle:(NSString *)title withBlock:(PXJCAlertActionBlock)block;
@end
