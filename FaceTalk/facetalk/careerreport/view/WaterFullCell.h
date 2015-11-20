//
//  WaterFullCell.h
//  FaceTalk
//
//  Created by Mao-MacPro on 15/10/26.
//  Copyright © 2015年 wen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaterFullCell : UIView

@property (nonatomic,strong) UIButton *headButton;
@property (nonatomic, copy) void(^checkclickBlock)(UIButton *);
-(CGFloat)setHead:(NSString *)head ImageName:(NSString *)imageName;

@end
