//
//  Util.m
//  UtilityDemo
//
//  Created by nice2meet on 2017/7/1.
//  Copyright © 2017年 nice2meet. All rights reserved.
//
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import <MBProgressHUD.h>

#import "Util.h"

@implementation Util

static NSDateFormatter * _dateFormatter = nil;
static MBProgressHUD * _toastHud = nil;
static MBProgressHUD * _loadingHUD = nil;
static NSObject * _anObj = nil;



+(void)load{
    [self initLocalVariables];
}

#pragma mark - Foundation


+ (UIViewController *)getViewController:(NSString *)name{
    
    UIViewController * aVC = [self getViewController:name sotryBoardName:@"Main"];
    return aVC;
}

+ (UIViewController *)getViewController:(NSString *)vcName sotryBoardName:(NSString *)sbName{
    UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:sbName bundle:nil];
    UIViewController * aVC = [storyBoard instantiateViewControllerWithIdentifier:vcName];
    return aVC;
}

+ (NSString *)appName{
    return [NSString stringWithFormat:@"%@",[[NSBundle mainBundle] infoDictionary][@"CFBundleDisplayName"]];
}
+ (NSString *)appBuild{
    return  [NSString stringWithFormat:@"%@",[[NSBundle mainBundle] infoDictionary][(NSString *)kCFBundleVersionKey]];
}
+ (NSString *)appVersion{
    return [NSString stringWithFormat:@"%@",[[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"]];
}

+ (BOOL)iOS8OrLatter{
    return [self iOSSystemVersion] >= 8.0;
}
+ (BOOL)iOS9OrLatter{
    return [self iOSSystemVersion] >= 9.0;
}

+ (BOOL)iOSXOrLatter{
    return [self iOSSystemVersion] >= 10.0;
}

+ (void)saveUserDefaultsKey:(NSString *)key value:(id)value{
    
    NSAssert(key, @"key should not be nil");
    if (!key || key.length <= 0 || !value) {
        return;
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

+ (id)getUserDefaultsValueForKey:(NSString *)key{
     NSAssert(key, @"key should not be nil");
    if (!key || key.length <= 0) {
       return nil;
    }
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

+ (void)deleteUserDefaultsKey:(NSString *)key{
     NSAssert(key, @"key should not be nil");
    if (!key || key.length <= 0) {
        return;
    }
    return[[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
}

#pragma mark -

+ (NSString *)dateStringFromTimeStamp:(NSTimeInterval)timeStamp format:(NSString *)format{
    //NSDateFormatter * formater = [NSDateFormatter new];
    NSString * rsFormat = @"yyyy-MM-dd HH:mm:ss";
    if (format){
        rsFormat = format;
    }
    [_dateFormatter setDateFormat:rsFormat];
    //拿到时间
    NSDate * dateTmp = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    
    return [_dateFormatter stringFromDate:dateTmp];
}

+ (NSDate *)dateFromDateString:(NSString *)dateString dateStringformat:(NSString *)format{
    //NSDateFormatter * dateFormater = [NSDateFormatter new];
    NSString * rsFormat = @"yyyy-MM-dd HH:mm:ss";
    if (format){
        rsFormat = format;
    }
    [_dateFormatter setDateFormat:rsFormat];
    
    NSDate * dateTmp = [_dateFormatter dateFromString:dateString];
    return dateTmp;
}

+ (NSString *)currentDateStringFormat:(NSString *)dateFormat{
    NSString * rsFormat = @"yyyy-MM-dd HH:mm:ss";
    if (dateFormat){
        rsFormat = rsFormat;
    }
    NSDate * currentDate = [NSDate date];
    [_dateFormatter setDateFormat:rsFormat];
    return [_dateFormatter stringFromDate:currentDate];
}

#pragma mark - UI

+ (BOOL)iPhone4{
    return kScreenWidth == 480.0;
}
+ (BOOL)iPhone5{
    return kScreenWidth == 568.0;
}
+ (BOOL)iPhone6{
    return kScreenWidth == 667.0;
}
+ (BOOL)iPhone6P{
    return kScreenWidth == 736.0;
}

+ (UIColor *)colorFromRGB:(NSString *)colorString{
    return [self colorFromRGB:colorString andAlpha:1.0];
}

+ (UIColor *)colorFromRGB:(NSString *)colorString andAlpha:(CGFloat)alpha{
    colorString = [colorString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    unsigned int unsignHex = 0;
    NSScanner * scanner = [NSScanner scannerWithString:colorString];
    [scanner scanHexInt:&unsignHex];
    
    CGFloat r = ((unsignHex & 0xff0000) >> 16) / 255.f;
    CGFloat g = ((unsignHex & 0xff00) >> 8) / 255.f;
    CGFloat b = (unsignHex & 0xff) / 255.f;
    
    return [UIColor colorWithRed:r green:g blue:b alpha:alpha];
}

+ (UIImage *)imageWithColor:(UIColor *)color imageRect:(CGRect)rect{
    if (CGRectIsEmpty(rect))
        return nil;
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (UIImage *)clipImage:(UIImage *)sourceImg toSize:(CGSize)size{
    //被切图片宽比例比高比例小 或者相等，以图片宽进行放大
    if (sourceImg.size.width*size.height <= sourceImg.size.height*size.width) {
        //以被剪裁图片的宽度为基准，得到剪切范围的大小
        CGFloat width  = sourceImg.size.width;
        CGFloat height = sourceImg.size.width * size.height / size.width;
        
        // 调用剪切方法
        // 这里是以中心位置剪切，也可以通过改变rect的x、y值调整剪切位置
        return [self imageFromImage:sourceImg inRect:CGRectMake(0, (sourceImg.size.height -height)/2, width, height)];
        
    }else{ //被切图片宽比例比高比例大，以图片高进行剪裁
        
        // 以被剪切图片的高度为基准，得到剪切范围的大小
        CGFloat width  = sourceImg.size.height * size.width / size.height;
        CGFloat height = sourceImg.size.height;
        
        // 调用剪切方法
        // 这里是以中心位置剪切，也可以通过改变rect的x、y值调整剪切位置
        return [self imageFromImage:sourceImg inRect:CGRectMake((sourceImg.size.width -width)/2, 0, width, height)];
    }
    return nil;
    
}

#pragma mark Toast

/**
 *  HUD 提示
 *
 *  @param text dd
 */
+ (void)showHudText:(NSString *)text{
    
    MBProgressHUD * hud = [self loadingHUD];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text = text;
    hud.backgroundView.style = MBProgressHUDBackgroundStyleBlur;
    //hud.backgroundView.color = [UIColor colorWithWhite:0.f alpha:0.33f];
    [[self rootWindow] addSubview:hud];
    [hud showAnimated:YES];
}
/**
 *  直接显示提示
 *
 *  @param text 提示语句
 */
+ (void)showToastText:(NSString *)text{
    
    MBProgressHUD * hud = [self toastHUD];
    hud.label.text = text;
    
    hud.mode = MBProgressHUDModeText;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [hud hideAnimated:YES];
    });
    [[self rootWindow] addSubview:hud];
    [hud showAnimated:YES];
}

/**
 隐藏HUD 提示
 */
+ (void)hideHUD{
    MBProgressHUD * hud = [self loadingHUD];
    dispatch_async(dispatch_get_main_queue(), ^{
        [hud hideAnimated:YES];
    });
}

+ (void)showAlertMessage:(NSString *)msg title:(NSString *)title cancelTitle:(NSString *)cancelTitle{
    
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:title message:msg delegate:nil cancelButtonTitle:cancelTitle otherButtonTitles:nil];
    [alert show];
}

#pragma mark  PrivacyAccess


#pragma mark - BaseCommon


+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    if (mobileNum.length != 11)
    {
        return NO;
    }
    NSString * MOBILE = @"^1\\d{10}$";
    
    if ([[NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE] evaluateWithObject:mobileNum] == YES){
        return YES;
    }
    else{
        return NO;
    }
    
    
    //    /**
    //     * 手机号码:
    //     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[0, 1, 6, 7, 8], 18[0-9]
    //     * 移动号段: 134,135,136,137,138,139,147,150,151,152,157,158,159,170,178,182,183,184,187,188
    //     * 联通号段: 130,131,132,145,155,156,170,171,175,176,185,186
    //     * 电信号段: 133,149,153,170,173,177,180,181,189
    //     */
    //    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|7[0135678]|8[0-9])\\d{8}$";
    //    /**
    //     * 中国移动：China Mobile
    //     * 134,135,136,137,138,139,147,150,151,152,157,158,159,170,178,182,183,184,187,188
    //     */
    //    NSString *CM = @"^1(3[4-9]|4[7]|5[0-27-9]|7[08]|8[2-478])\\d{8}$";
    //    /**
    //     * 中国联通：China Unicom
    //     * 130,131,132,145,155,156,170,171,175,176,185,186
    //     */
    //    NSString *CU = @"^1(3[0-2]|4[5]|5[56]|7[0156]|8[56])\\d{8}$";
    //    /**
    //     * 中国电信：China Telecom
    //     * 133,149,153,170,173,177,180,181,189
    //     */
    //    NSString *CT = @"^1(3[3]|4[9]|53|7[037]|8[019])\\d{8}$";
    //
    //
    //    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    //    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    //    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    //    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    //
    //    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
    //        || ([regextestcm evaluateWithObject:mobileNum] == YES)
    //        || ([regextestct evaluateWithObject:mobileNum] == YES)
    //        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    //    {
    //        return YES;
    //    }
    //    else
    //    {
    //        return NO;
    //    }
}

+ (BOOL) isAlphaNumberic:(NSString *)aString backSpaceAllowed:(BOOL)allowed{
    NSString * regix = nil;
    if (allowed){
        regix = @"^[0-9a-zA-Z]*$";
    }else{
        regix = @"^[0-9a-zA-Z]+$";;
    }
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regix];
    return [predicate evaluateWithObject:aString];
}
+ (BOOL) isSimpleChinese:(NSString *) aString backSpaceAllowed:(BOOL)allowed{
    NSString * regix = nil;
    if (allowed){
        regix = @"^[\\u4e00-\\u9fa5]*$";
    }else{
        regix = @"^[\\u4e00-\\u9fa5]+$";
    }
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regix];
    return [predicate evaluateWithObject:aString];
}
+ (BOOL) isAlpha:(NSString *)aString backSpaceAllowed:(BOOL)allowed{
    NSString * regix = nil;
    if (allowed){
        regix = @"^[a-zA-Z]*$";
    }else{
        regix = @"^[a-zA-Z]+$";
    }
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regix];
    return [predicate evaluateWithObject:aString];
}
+ (BOOL) isNumberic:(NSString *)aString backSpaceAllowed:(BOOL)allowed{
    NSString * regix = nil;
    if (allowed){
        regix = @"^[0-9]*$";
    }else{
        regix = @"^[0-9]+$";
    }
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regix];
    return [predicate evaluateWithObject:aString];
}
#pragma mark - private

+ (void)scanHexString:(NSString *)colorStirng{
    colorStirng = [colorStirng stringByReplacingOccurrencesOfString:@"#" withString:@""];
    unsigned int unsignHex = 0;
    NSScanner * scanner = [NSScanner scannerWithString:colorStirng];
    [scanner scanHexInt:&unsignHex];
}

+ (float)iOSSystemVersion{
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}

+ (void)initLocalVariables{
    _dateFormatter = [NSDateFormatter new];
    [_dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
}

/**
 *从图片中按指定的位置大小截取图片的一部分
 * UIImage image 原始的图片
 * CGRect rect 要截取的区域
 */
+(UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect{
    
    //将UIImage转换成CGImageRef
    CGImageRef sourceImageRef = [image CGImage];
    
    //按照给定的矩形区域进行剪裁
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    
    //将CGImageRef转换成UIImage
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    //返回剪裁后的图片
    return newImage;
}


/**
 弹窗专用的HUD

 @return 弹窗专用的HUD
 */
+ (MBProgressHUD *)toastHUD{
//    MBProgressHUD * _toastHud;
    
    if (!_toastHud){
        UIWindow * window = [self rootWindow];
        _toastHud = [[MBProgressHUD alloc] initWithView:window];
    }
    return _toastHud;
}

/**
 返回 加载中专用HUD

 @return 返回 加载中专用HUD
 */
+ (MBProgressHUD *)loadingHUD{
//    MBProgressHUD * _loadingHUD;
    if (!_loadingHUD){
        UIWindow * window = [self rootWindow];
        _loadingHUD = [[MBProgressHUD alloc] initWithView:window];
    }
    return _loadingHUD;
}

+ (UIWindow *)rootWindow{
    
    UIWindow * rootWindow = [UIApplication sharedApplication].windows.lastObject;
    return rootWindow;
}

@end
