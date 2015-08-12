//
//  FTDImageManage.h
//  FaceTalk
//
//  Created by Mao-MacPro on 15/8/7.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface FTDImageManage : NSObject
+(NSString *)getImageLocalUrl;
+(NSArray *)getImageArray;
+(BOOL)saveImageToDocument:(UIImage *)image imageName:(NSString *)imagename;
+(BOOL)removeImage:(NSString *)imagename;
@end
