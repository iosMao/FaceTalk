//
//  TFWSRRoundView.h
//  demo
//
//  Created by wen on 15/7/26.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TFWSRRoundView : UIView

+(id)createRoundWithCenter:(CGPoint)center Title:(NSString *)title Score:(int)score;
-(void)setTitle:(NSString *)title;
-(void)setScore:(int)score;

@end
