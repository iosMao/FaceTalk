//
//  RingCircle.h
//  瀑布流
//
//  Created by 赵文 on 15/10/21.
//  Copyright © 2015年 赵文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RingModel.h"

@interface RingCircle : UIImageView
@property (nonatomic,strong)UILabel *lblTitle;
@property (nonatomic,strong)UILabel *lblCost;
@property (nonatomic,strong) NSArray *dataArray;

+(instancetype)createRingWithCenter:(CGPoint)center radius:(CGFloat)radius width:(CGFloat)width;

@end
