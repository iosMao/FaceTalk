//
//  TFWRSCenterView.h
//  demo
//
//  Created by wen on 15/7/22.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TFWRSCenterView : UIView

@property (nonatomic,assign) int number;

+(id)createWithCenter:(CGPoint)point;
-(void)setAttributeString:(int)number;

@end
