//
//  WaterFullView.h
//  瀑布流
//
//  Created by 赵文 on 15/10/26.
//  Copyright © 2015年 赵文. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WaterFullViewDataSource;

@interface WaterFullView : UIView

@property (nonatomic,strong) UIView *headView;
@property (nonatomic,strong) UIView *footView;
@property (nonatomic,strong) UIScrollView *scrollView;

+(WaterFullView *)createWaterFullWithFrame:(CGRect)frame headView:(UIView *)headView footView:(UIView *)footView;
-(void)setHeadView:(UIView *)headView;
-(void)setFootView:(UIView *)footView;
-(void)reloadData;

@property (nonatomic,assign) id <WaterFullViewDataSource> dataSource;

@end

@protocol WaterFullViewDataSource <NSObject>
@required

-(NSInteger)numberOfRowInWaterFullView:(WaterFullView *)waterFullView;
-(CGFloat)heightForRowInWaterFullView:(WaterFullView *)waterFullView inRow:(NSInteger)row;
-(UIView *)cellForRowInWaterFullView:(WaterFullView *)waterFullView inRow:(NSInteger)row;

@end
