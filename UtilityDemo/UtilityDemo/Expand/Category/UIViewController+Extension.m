//
//  UIViewController+Extension.m
//  UtilityDemo
//
//  Created by nice2meet on 2017/7/2.
//  Copyright © 2017年 nice2meet. All rights reserved.
//
#import <objc/runtime.h>

#import "UIViewController+Extension.h"



static NSString * const _kHudText = @"_kHudText";
static NSString * const _kHudActityIndicator = @"_kHudActityIndicator";


@implementation UIViewController (Extension)

- (void)showHudText:(NSString *)text{
    
}

- (void)showToastText:(NSString *)text{
    
}

- (MBProgressHUD *)textHUD{
    return objc_getAssociatedObject(self, [_kHudText UTF8String]);
}

- (void)setTextHUD:(MBProgressHUD *)textHUD{
    
    if (![self textHUD]){
        MBProgressHUD * hud = [[MBProgressHUD alloc] initWithView:self.view];
        hud.backgroundView.style = MBProgressHUDBackgroundStyleBlur;
        hud.mode = MBProgressHUDModeText;
    }
    objc_setAssociatedObject(self, [_kHudText UTF8String], textHUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end
