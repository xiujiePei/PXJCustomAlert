//
//  ViewController.m
//  PXJCustomAlert
//
//  Created by 裴秀杰 on 2018/5/25.
//  Copyright © 2018年 JackP. All rights reserved.
//

#import "ViewController.h"

#import "PXJCustomAlert.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //2.0
    PXJCustomAlert *alert = [PXJCustomAlert alertWithTile:@"" withMessage:@"您的登录身份已过期，请重新登录"];
    PXJCAlertAction *btn = [PXJCAlertAction alertActionWithTitle:@"取消" withBlock:^{
        NSLog(@"取消");
    }];
    [alert addAlertAction:btn];
    [alert showAlert];
}

- (IBAction)click:(id)sender {
    //3.0
    PXJCustomAlert *alert = [PXJCustomAlert alertWithTile:@"" withMessage:@"您的登录身份已过期，请重新登录"];
    PXJCAlertAction *btn = [PXJCAlertAction alertActionWithTitle:@"取消" withBlock:^{
        NSLog(@"取消");
    }];
    [alert addAlertAction:btn];
    [alert showAlert];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
