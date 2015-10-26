//
//  FTDSingleton.h
//  FaceTalk
//
//  Created by Mao-MacPro on 15/10/22.
//  Copyright © 2015年 wen. All rights reserved.
//

#define singleton_Interface(class)  + (class *)share##class;

#define singleton_implemetntion(class)\
static class * instance = nil;\
+ (class *)share##class\
{\
if (!instance) {\
instance = [[class alloc]init];\
}\
return instance;\
}\
+ (class *)allocWithZone:(struct _NSZone *)zone\
{\
static dispatch_once_t onece;\
dispatch_once(&onece, ^{\
instance = [super allocWithZone:zone];\
});\
return instance;\
}
