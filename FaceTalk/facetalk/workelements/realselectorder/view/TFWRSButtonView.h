//
//  TFWRSButtonView.h
//  demo
//
//  Created by wen on 15/7/23.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TenElementType) {
    TenElementTypeBrand = 0,//品牌
    TenElementTypeFree,//自由
    TenElementTypeHonour,//荣誉
    TenElementTypeIncome,//收入
    TenElementTypeLearn,//学习
    TenElementTypeLife,//生活
    TenElementTypeSocity,//社会
    TenElementTypeSpace,//空间
    TenElementTypeSuit,//适合
    TenElementTypeWork,//工作
};

typedef void(^TapBtBlock)(UIButton *);

@interface TFWRSButtonView : UIView

@property (nonatomic,copy) TapBtBlock tapBlock;
@property (nonatomic,copy) TapBtBlock addBlock;

+(id)createButtonWithTag:(TenElementType)tag andCenter:(CGPoint)center;

@end
