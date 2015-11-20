//
//  FTDWaterFullHeadView.h
//  FaceTalk
//
//  Created by Mao-MacPro on 15/10/27.
//  Copyright © 2015年 wen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FTDWaterFullHeadView : UIView
@property (nonatomic, copy) void(^checkclickBlock)(UIButton *);
@property (nonatomic,strong) UIButton *btnHead;
+(id)createWaterFullHeadView;
@end
