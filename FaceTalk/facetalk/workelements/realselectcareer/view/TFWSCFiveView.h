//
//  TFWSCFiveView.h
//  demo
//
//  Created by wen on 15/7/23.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TFWSCFiveView : UIView

@property (nonatomic,assign) CGFloat rate0;
@property (nonatomic,assign) CGFloat rate1;
@property (nonatomic,assign) CGFloat rate2;
@property (nonatomic,assign) CGFloat rate3;
@property (nonatomic,assign) CGFloat rate4;

+(id)createFiveWithCenter:(CGPoint)center is_Hope:(BOOL)is_hope;
-(void)setShadowwithRate1:(CGFloat)rate1 withRate2:(CGFloat)rate2 withRate3:(CGFloat)rate3 withRate4:(CGFloat)rate4 withRate5:(CGFloat)rate5;
-(void)setSubTitle1:(NSString *)title1 Title2:(NSString *)title2 Title3:(NSString *)title3 Title4:(NSString *)title4 Title:(NSString *)title5;

@end
