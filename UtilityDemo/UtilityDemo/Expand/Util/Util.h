//
//  Util.h
//  UtilityDemo
//
//  Created by nice2meet on 2017/7/1.
//  Copyright © 2017年 nice2meet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Util : NSObject
#pragma mark - Foundation
/**
 *  根据传入的identifier 获取Main.Storyboard 中的视图控制器
 *
 *  @param name <#name description#>
 *
 *  @return <#return value description#>
 */
+ (UIViewController *)getViewController:(NSString *)name;

/**
 *  应用发布版本号
 *
 *  @return <#return value description#>
 */
+ (NSString *)appVersion;
/**
 *  应用内部版本号
 *
 *  @return <#return value description#>
 */
+ (NSString *)appBuild;

/**
 获取应用名称
 
 @return 返回应用名
 */
+ (NSString *)appName;

#pragma mark -

/**
 *  存储指定key 到standardUserDefault
 *
 *  @param key   键值
 *  @param value 值
 */
+ (void)saveUserDefaultsKey:(NSString *)key value:(id)value;
/**
 *  获取userdefaults 中的key 对应的值
 */
+ (id)getUserDefaultsValueForKey:(NSString *)key;

/**
 根据 key 删除userdefault 中的对应的值
 
 @param key 待删除的userDefaults
 */
+ (void)deleteUserDefaultsKey:(NSString *)key;
#pragma mark -
/**
 *  通过传入Unix 时间戳,返回一个NSString 类型的时间
 *
 *  @param timeStamp Unix 时间戳
 *  @param format    返回的NSString 类型的时间的格式,若为空,默认格式为 "yyyy-MM-dd HH:mm:ss"
 *
 *  @return 指定 format 格式的 字符串
 */
+ (NSString *)dateStringFromTimeStamp:(NSTimeInterval)timeStamp format:(NSString *)format;

/**
 *  传入一个字符型时间串,返回该字符串的,NSDate 类型
 *
 *  @param dateString 待转换的时间字符串
 *  @param format     该时间字符串的格式
 *
 *  @return 指定字符串的NSDate 类型
 */
+ (NSDate *)dateFromDateString:(NSString *)dateString dateStringformat:(NSString *)format;

/**
 返回当前系统指定格式字符串
 
 @param dateFormat 时间字符串格式  默认为 "yyyy-MM-dd HH:mm:ss"
 @return 返回指定格式的日期字符串
 */
+ (NSString *)currentDateStringFormat:(NSString *)dateFormat;

#pragma mark - UI
/**
 *  是否iPhone4
 *
 *  @return <#return value description#>
 */
+ (BOOL)iPhone4;
/**
 *  是否iPhone5
 *
 *  @return <#return value description#>
 */
+ (BOOL)iPhone5;
/**
 *  是否iPhone 6
 *
 *  @return <#return value description#>
 */
+ (BOOL)iPhone6;
/**
 *  是否iPhone6P
 *
 *  @return <#return value description#>
 */
+ (BOOL)iPhone6P;

/**
 是否iOS 8.0 及以后
 
 @return 返回iOS 8 或者以后 YES  ,否则返回NO
 */
+ (BOOL)iOS8OrLatter;
/**
 是否iOS 9.0 及以后
 
 @return 返回iOS 8 或者以后 YES  ,否则返回NO
 */
+ (BOOL)iOS9OrLatter;

/**
 是否iOS 9.0 及以后
 
 @return 返回iOS 8 或者以后 YES  ,否则返回NO
 */
+ (BOOL)iOSXOrLatter;

+ (UIColor *)colorFromRGB:(NSString *)colorString;
/**
 *  根据出入的RGB,alpha 生成color
 *
 *  @param colorString @"#00ff00" 形式
 *  @param alpha       <#alpha description#>
 *
 *  @return <#return value description#>
 */
+ (UIColor *)colorFromRGB:(NSString *)colorString andAlpha:(CGFloat)alpha;


/**
 根据传入的颜色,尺寸 生成纯色的UIImage对象
 
 @param color UIColor 颜色
 @param rect 待生成的尺寸起始绘制 frame
 @return UIImage对象
 */
+ (UIImage *)imageWithColor:(UIColor *)color imageRect:(CGRect)rect;


/**
 自适应裁剪为目标尺寸
 
 @param sourceImg  源图片对象
 @param size    目标尺寸
 @return 剪裁后的目标图像
 */
+ (UIImage *)clipImage:(UIImage *)sourceImg toSize:(CGSize)size;

#pragma mark  Toast
/**
 *  HUD 提示
 *
 *  @param text dd
 */
+ (void)showHudText:(NSString *)text;
/**
 *  直接显示提示
 *
 *  @param text 提示语句
 */
+ (void)showToastText:(NSString *)text;

/**
 隐藏HUD 提示
 */
+ (void)hideHUD;


/**
 展示一个alertViw
 
 @param msg alert view 内容
 @param title alert view 标题
 @param cancelTitle 取消按钮标题
 */
+ (void)showAlertMessage:(NSString *)msg title:(NSString *)title cancelTitle:(NSString *)cancelTitle;


#pragma mark  PrivacyAccess

/*
 info.plist
 
 key	value
 NSPhotoLibraryUsageDescription	是否允许访问相册？
 Privacy - Camera Usage Description	是否允许需要访问相机？
 Privacy - Location Usage Description	是否允许需要访问位置？
 Privacy - Location When In Use Usage Description	是否允许使用期间访问位置？
 Privacy - Location Always Usage Description	是否允许始终访问位置？
 Privacy - Bluetooth Peripheral Usage Description	是否允许访问蓝牙？
 Privacy - Reminders Usage Description	是否允许访问提醒事项？
 Privacy - Motion Usage Description	是否允许访问运动与健康？
 Privacy - Media Library Usage Description	是否允许访问媒体资料库？
 Privacy - Microphone Usage Description	是否允许访问麦克风？
 Privacy - Calendars Usage Description	是否允许访问日历？
 */


#pragma mark - BaseCommon


/**
 判断是否手机号码正则
 
 @param mobileNum 待判断的手机号码字符串
 @return 是否手机号码
 */
+ (BOOL)isMobileNumber:(NSString *)mobileNum;
/**
 *  是否是字母,数字
 *
 *  @param aString 待检测的字符串
 *  @param allowed 是否允许删除键
 *
 *  @return <#return value description#>
 */
+ (BOOL) isAlphaNumberic:(NSString *)aString backSpaceAllowed:(BOOL)allowed;
/**
 *  是否 中文
 *
 *  @param aString <#aString description#>
 *  @param allowed <#allowed description#>
 *
 *  @return <#return value description#>
 */
+ (BOOL) isSimpleChinese:(NSString *) aString backSpaceAllowed:(BOOL)allowed;
/**
 *  是否全是字母
 *
 *  @param aString <#aString description#>
 *  @param allowed <#allowed description#>
 *
 *  @return <#return value description#>
 */
+ (BOOL) isAlpha:(NSString *)aString backSpaceAllowed:(BOOL)allowed;
/**
 *  是否全是数字
 *
 *  @param aString <#aString description#>
 *  @param allowed <#allowed description#>
 *
 *  @return <#return value description#>
 */
+ (BOOL) isNumberic:(NSString *)aString backSpaceAllowed:(BOOL)allowed;

@end
