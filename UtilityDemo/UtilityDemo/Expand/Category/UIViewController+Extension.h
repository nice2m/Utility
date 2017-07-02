//
//  UIViewController+Extension.h
//  UtilityDemo
//
//  Created by nice2meet on 2017/7/2.
//  Copyright © 2017年 nice2meet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD.h>


@interface UIViewController (Extension)

- (void)showHudText:(NSString *)text;

- (void)showToastText:(NSString *)text;

@end
