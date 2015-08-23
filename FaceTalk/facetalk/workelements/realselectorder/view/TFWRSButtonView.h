//
//  TFWRSButtonView.h
//  demo
//
//  Created by wen on 15/7/23.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TenElementType) {
    TenElementTypeBrand = 0,
    TenElementTypeFree,
    TenElementTypeHonour,
    TenElementTypeIncome,
    TenElementTypeLearn,
    TenElementTypeLife,
    TenElementTypeSocity,
    TenElementTypeSpace,
    TenElementTypeSuit,
    TenElementTypeWork,
};

typedef void(^TapBtBlock)(UIButton *);

@interface TFWRSButtonView : UIView

@property (nonatomic,copy) TapBtBlock tapBlock;
@property (nonatomic,copy) TapBtBlock addBlock;

+(id)createButtonWithTag:(TenElementType)tag andCenter:(CGPoint)center;

@end
