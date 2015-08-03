//
//  TFWSRResultView.h
//  demo
//
//  Created by wen on 15/7/26.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^animationDoneBlock)(void);

@interface TFWSRResultView : UIView

@property (nonatomic,copy) animationDoneBlock animationDoneblock;

+(id)createResultViewCenter:(CGPoint)center andTitle:(NSString *)title andText:(NSString *)text andRate:(CGFloat)rate roundTitle:(NSString *)roundtitle roundScore:(int)score;

@end
