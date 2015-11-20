//
//  WaterFullView.m
//  瀑布流
//
//  Created by 赵文 on 15/10/26.
//  Copyright © 2015年 赵文. All rights reserved.
//

#import "WaterFullView.h"
#import "Masonry.h"

@interface WaterFullView ()

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIView *headView;
@property (nonatomic,strong) UIView *footView;
@property (nonatomic,strong) UIView *leftView;
@property (nonatomic,strong) UIView *rightView;

@end

@implementation WaterFullView

+(WaterFullView *)createWaterFullWithFrame:(CGRect)frame headView:(UIView *)headView footView:(UIView *)footView{
    WaterFullView *waterFullView = [[WaterFullView alloc] initWithFrame:frame];
    waterFullView.headView = headView;
    waterFullView.footView = footView;
    if (waterFullView) {
        [waterFullView initView];
    }
    
    return waterFullView;
}

-(void)initView{
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    [self addSubview:_scrollView];
    
    if (_headView) {
        [_scrollView addSubview:_headView];
    }
    
    if (_footView) {
        [_scrollView addSubview:_footView];
    }
}

-(void)reloadData{
    
    if (_leftView) {
        [_leftView removeFromSuperview];
    }
    if (_rightView) {
        [_rightView removeFromSuperview];
    }
    
    _leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame) / 2.0, CGRectGetHeight(self.frame))];
    [self.scrollView addSubview:_leftView];
    
    _rightView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame) / 2.0, 0, CGRectGetWidth(self.frame) / 2.0, CGRectGetHeight(self.frame))];
    [self.scrollView addSubview:_rightView];
    
    NSInteger rowNumber = [self.dataSource numberOfRowInWaterFullView:self];
    for (int i = 0; i < rowNumber; i++) {
        UIView *view = [self.dataSource cellForRowInWaterFullView:self inRow:i];
        CGFloat height = [self.dataSource heightForRowInWaterFullView:self inRow:i];
        [self addView:view withHeight:height];
    }
    
    UIView *leftLastView = [_leftView.subviews lastObject];
    UIView *rightLastView = [_rightView.subviews lastObject];
    CGFloat leftHeight = CGRectGetMaxY(leftLastView.frame);
    CGFloat rightHeight = CGRectGetMaxY(rightLastView.frame);
    CGFloat height = 0;
    if (leftHeight <= rightHeight) {
        height = rightHeight;
    }else{
        height = leftHeight;
    }
    
    CGFloat top = 0;
    if (_headView) {
        _headView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(_headView.frame));
        top = CGRectGetMaxY(_headView.frame);
    }
    _leftView.frame = CGRectMake(0, top, CGRectGetWidth(self.frame) / 2.0, height);
    _rightView.frame = CGRectMake(CGRectGetWidth(self.frame) / 2.0, top, CGRectGetWidth(self.frame) / 2.0, height);
    if (_footView) {
        _footView.frame = CGRectMake(0, top + height, CGRectGetWidth(self.frame), CGRectGetHeight(_footView.frame));
        height = top + height + CGRectGetHeight(_footView.frame);
    }else{
        height = top + height;
    }
    _scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.frame), height);
}

-(void)addView:(UIView *)view withHeight:(CGFloat)height{
    if (_leftView.subviews.count == 0) {
        view.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame) / 2.0, height);
        [_leftView addSubview:view];
        return;
    }
    
    if (_rightView.subviews.count == 0) {
        view.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame) / 2.0, height);
        [_rightView addSubview:view];
        return;
    }
    
    UIView *leftLastView = [_leftView.subviews lastObject];
    UIView *rightLastView = [_rightView.subviews lastObject];
    CGFloat leftHeight = CGRectGetMaxY(leftLastView.frame);
    CGFloat rightHeight = CGRectGetMaxY(rightLastView.frame);
    
    if (leftHeight <= rightHeight) {
        view.frame = CGRectMake(0, leftHeight, CGRectGetWidth(self.frame) / 2.0, height);
        [_leftView addSubview:view];
        return;
    }else{
        view.frame = CGRectMake(0, rightHeight, CGRectGetWidth(self.frame) / 2.0, height);
        [_rightView addSubview:view];
        return;
    }
}

@end
