//
//  ViewController.m
//  UtilityDemo
//
//  Created by nice2meet on 2017/7/1.
//  Copyright © 2017年 nice2meet. All rights reserved.
//
#import <MBProgressHUD.h>

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

#pragma mark - lifeCycle


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
//    [self hudTest];
//    [self toastTest];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear: animated];
    [self toastTest];
    
//    UIWindow * window = [UIApplication sharedApplication].windows.lastObject;
//    
//    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
//    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
//    hud.label.text = @"测试";
//    [Util showHudText:@"测试"];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

- (void)dealloc{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    //[Util showToastText:@"Test?"];
    
    //[self hudTest];
    
//    [self complexTest];
//    [Util testToast:@"弹窗测试,I can play? Sure ,of course \n弹窗测试,I can play? Sure ,of course"];
}


#pragma mark - interface

#pragma mark - event

#pragma mark - delegate

#pragma mark - private

- (void)hudTest{
    [Util showHudText:@""];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [Util hideHUD];
    });
}

- (void)toastTest{
    
    [Util showToastText:@"弹窗测试,I can play? Sure ,of course 弹窗测试,I can play? Sure ,of course"];
}

- (void)complexTest{
    [self hudTest];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self toastTest];
    });
    
}

#pragma mark - setter & getter



@end
