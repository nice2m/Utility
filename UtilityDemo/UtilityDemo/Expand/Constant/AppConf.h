//
//  AppConf.h
//  UtilityDemo
//
//  Created by nice2meet on 2017/7/1.
//  Copyright © 2017年 nice2meet. All rights reserved.
//

#ifndef AppConf_h
#define AppConf_h


#define NSLog(FORMAT, ...) fprintf(stderr,"\nfunc: %s \nline: %d \ncontent: %s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

#endif /* AppConf_h */
