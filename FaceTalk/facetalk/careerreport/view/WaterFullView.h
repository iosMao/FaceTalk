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

+(WaterFullView *)createWaterFullWithFrame:(CGRect)frame headView:(UIView *)headView footView:(UIView *)footView;
-(void)reloadData;

@property (nonatomic,assign) id <WaterFullViewDataSource> dataSource;

@end

@protocol WaterFullViewDataSource <NSObject>
@required

-(NSInteger)numberOfRowInWaterFullView:(WaterFullView *)waterFullView;
-(CGFloat)heightForRowInWaterFullView:(WaterFullView *)waterFullView inRow:(NSInteger)row;
-(UIView *)cellForRowInWaterFullView:(WaterFullView *)waterFullView inRow:(NSInteger)row;

@end
