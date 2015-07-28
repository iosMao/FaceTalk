//
//  TFWSCPipeView.h
//  demo
//
//  Created by wen on 15/7/23.
//  Copyright © 2015年 wen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TFWSCPipeView;
typedef void(^valueChangeBlock)(TFWSCPipeView *);

@interface TFWSCPipeView : UIView

@property (nonatomic,assign) CGFloat pipevalue;
@property (nonatomic,copy) valueChangeBlock valueChangeblock;

+(id)createPipeWithCenter:(CGPoint)center Title:(NSString *)title isHope:(BOOL)is_hope;
-(void)setPipevalue:(CGFloat)pipevalue;

@end
