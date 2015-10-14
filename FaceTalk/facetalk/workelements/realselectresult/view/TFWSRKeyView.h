//
//  TFWSRKeyView.h
//  demo
//
//  Created by wen on 15/7/28.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TFWSRKeyView : UIView

+(id)createKeyViewwithCenter:(CGPoint)center andRate:(CGFloat)rate;
-(void)setRate:(CGFloat)rate;

@end
