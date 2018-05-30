//
//  PXJCustomAlert.m
//  PXJAlertView
//
//  Created by Jack2 on 2018/5/22.
//  Copyright © 2018年 JackP. All rights reserved.
//

#import "PXJCustomAlert.h"

#define titleTop 20
#define titleSpace 10
#define messageSpace 26
#define default_With ([UIScreen mainScreen].bounds.size.width * 0.75)
//
#define UIColorFromHEX(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
@interface PXJCustomAlert ()
//model
@property(nonatomic,copy)NSString *alertTitle;
@property(nonatomic,copy)NSString *alertMessage;

@property(nonatomic,assign)CGFloat windowWidth;
@property(nonatomic,assign)CGFloat titleLabelHeight;
@property(nonatomic,assign)CGFloat messageViewHeight;

@property(nonatomic,strong)NSMutableArray<PXJCAlertAction *> *buttons;
//view
@property(nonatomic,strong)UIView *contentView;
@property(nonatomic,strong)UILabel *labelTitle;
@property(nonatomic,strong)UITextView *viewTextMessage;

@property(nonatomic,strong)UIWindow *alertWindow;
@property(nonatomic,assign)BOOL isNewAlertWindow;
@end

@implementation PXJCustomAlert
//在普通的控制器中弹出提示框
+ (PXJCustomAlert *)alertWithMessage:(NSString *)message{
    return [PXJCustomAlert alertWithTile:@"" withMessage:message];
}

+ (PXJCustomAlert *)alertWithTile:(NSString *)title withMessage:(NSString *)message{
    return [[PXJCustomAlert alloc] initWithTitle:title withMessage:message];
}

- (void)addAlertAction:(PXJCAlertAction *)alertAction{
    [alertAction addTarget:self action:@selector(actionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttons addObject:alertAction];
    
}

- (void)actionButtonClick:(PXJCAlertAction *)alertAction{
    //present失败时，要用remove
    if (![self.alertWindow.rootViewController.presentedViewController isEqual:self]) {
        [self.view removeFromSuperview];
    }
    [self dismissViewControllerAnimated:NO completion:NULL];
    //是否去除创建的window
    if (self.isNewAlertWindow) {
        [self.alertWindow setHidden:YES];
        self.alertWindow = nil;
    }
    if (alertAction.alertBlock) {
        alertAction.alertBlock();
    }
}

- (void)showAlert{
    [self.alertWindow.rootViewController presentViewController:self animated:NO completion:NULL];
    //present失败，直接add
    if (![self.alertWindow.rootViewController.presentedViewController  isEqual:self]) {
        [self.alertWindow.rootViewController.view addSubview:self.view];
    }
}

- (instancetype)initWithTitle:(NSString *)title withMessage:(NSString *)message{
    if (self = [super init]) {
        self.alertTitle = title;
        self.alertMessage = message;
        
        [self setUpDefault];
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.accessibilityViewIsModal = YES;//VoiceOver忽略
    self.view.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    [self.view addSubview:self.contentView];
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.contentView.layer.cornerRadius = self.cornerRadius;
    self.contentView.clipsToBounds = YES;
    [self.contentView addSubview:self.labelTitle];
    [self.contentView addSubview:self.viewTextMessage];
    
    //计算布局
    /*
     计算title的高度
     */
    CGFloat y = titleTop;
    if (![self.alertTitle isEqualToString:@""]&&self.alertTitle) {
        CGRect labelRect = [self.alertTitle boundingRectWithSize:CGSizeMake(self.windowWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.titleFont} context:nil];
        self.labelTitle.frame = CGRectMake(0, y, self.windowWidth, labelRect.size.height+titleSpace);
        self.labelTitle.font = self.titleFont;
        self.labelTitle.textColor = self.titleColor;
        self.labelTitle.text = self.alertTitle;
        /*
         计算message的高度
         */
        y = y + labelRect.size.height + titleSpace;
    }
    
    CGRect messageRect = [self.alertMessage boundingRectWithSize:CGSizeMake(self.windowWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.messageFont} context:nil];
    self.viewTextMessage.frame = CGRectMake(0, y,self.windowWidth, messageRect.size.height+ messageSpace);
    self.viewTextMessage.font = self.messageFont;
    self.viewTextMessage.textColor = self.messageColor;
    self.viewTextMessage.text = self.alertMessage;
    //添加横线
    CALayer *line = [self lineLayerWithFrame:CGRectMake(0, self.viewTextMessage.frame.size.height-self.lineThick, self.windowWidth, self.lineThick)];
    [self.viewTextMessage.layer addSublayer:line];
    /*
     计算button的排列
     */
    y = y + messageRect.size.height + messageSpace;
    
    if (self.buttons.count == 2) {
        PXJCAlertAction *btn1 = self.buttons[0];
        PXJCAlertAction *btn2 = self.buttons[1];
        CGFloat btn1Height = btn1.frame.size.height;
        CGFloat btn2Height = btn2.frame.size.height;
        CGFloat btnHeight = btn1Height>btn2Height?btn1Height:btn2Height;
        btn1.frame = CGRectMake(0, y, self.windowWidth/2, btnHeight);
        [self.contentView addSubview:btn1];
        btn2.frame = CGRectMake(self.windowWidth/2, y, self.windowWidth/2, btnHeight);
        [self.contentView addSubview:btn2];
        
        //添加竖线
        CALayer *line = [self lineLayerWithFrame:CGRectMake(self.windowWidth/2-self.lineThick/2, y, self.lineThick, btnHeight)];
        [self.contentView.layer addSublayer:line];
        
        y = y + btnHeight ;
    }else{
        for (int i = 0; i < self.buttons.count; i++) {
            PXJCAlertAction *btn = self.buttons[i];
            CGFloat btnHeight = btn.frame.size.height;
            btn.frame = CGRectMake(0, y, self.windowWidth, btnHeight);
            [self.contentView addSubview:btn];
            
            //添加横线
            if (i < self.buttons.count-1) {
                CALayer *line = [self lineLayerWithFrame:CGRectMake(0, btn.frame.size.height-self.lineThick, self.windowWidth, self.lineThick)];
                [btn.layer addSublayer:line];
            }
            y = y + btnHeight ;
        }
    }
    
    CGFloat contentViewHeight = y;
    self.contentView.frame = CGRectMake(0, 0, self.windowWidth, contentViewHeight);
    UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
    self.contentView.center = window.center;
}


#pragma mark -set默认值
- (void)setUpDefault{
    
    self.cornerRadius = 3.0f;
    self.windowWidth = default_With;
    
    self.titleFont = [UIFont fontWithName:@"PingFangSC-Medium" size:(16.0)];
    self.titleColor = UIColorFromHEX(0x000000);
    
    self.messageFont = [UIFont fontWithName:@"PingFangSC-Regular" size:(14.0)];
    self.messageColor = UIColorFromHEX(0x333333);
    
    self.lineColor = UIColorFromHEX(0xebebeb);
    self.lineThick = 0.5f;
    
    self.modalPresentationStyle = UIModalPresentationOverCurrentContext;//透明背景
}


#pragma mark - lazy
- (UILabel *)labelTitle{
    if (_labelTitle == nil) {
        _labelTitle = [[UILabel alloc] init];
        _labelTitle.lineBreakMode = NSLineBreakByWordWrapping;
        _labelTitle.textAlignment = NSTextAlignmentCenter;
        _labelTitle.font = [UIFont systemFontOfSize:16.0];
    }
    return _labelTitle;
}

- (UITextView *)viewTextMessage{
    if (_viewTextMessage == nil) {
        _viewTextMessage = [[UITextView alloc] init];
        _viewTextMessage.editable = NO;
        _viewTextMessage.allowsEditingTextAttributes = YES;
        _viewTextMessage.font = [UIFont systemFontOfSize:14.0f];
        _viewTextMessage.textAlignment = NSTextAlignmentCenter;
        _viewTextMessage.accessibilityTraits = UIAccessibilityTraitStaticText;
    }
    return _viewTextMessage;
}

- (UIView *)contentView{
    if (_contentView == nil) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.layer.cornerRadius = 3.0f;
        _contentView.clipsToBounds = YES;
    }
    return _contentView;
}

- (NSMutableArray *)buttons{
    if (_buttons == nil) {
        _buttons = [[NSMutableArray alloc] init];
    }
    return _buttons;
}

- (CALayer *)lineLayerWithFrame:(CGRect)frame{
    CALayer *layer = [CALayer layer];
    layer.frame = frame;
    layer.backgroundColor = self.lineColor.CGColor;
    return layer;
}

- (UIWindow *)alertWindow{
    if (_alertWindow == nil) {
        UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
        if (window&&window.rootViewController) {
            self.isNewAlertWindow = NO;
            _alertWindow = window;
        }else{
            self.isNewAlertWindow = YES;
            _alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
            _alertWindow.windowLevel = UIWindowLevelAlert;
            _alertWindow.backgroundColor = [UIColor clearColor];
            _alertWindow.rootViewController = [UIViewController new];
            _alertWindow.accessibilityViewIsModal = YES;
        }
    }
    return _alertWindow;
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}
@end
