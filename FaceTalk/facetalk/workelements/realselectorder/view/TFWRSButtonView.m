//
//  TFWRSButtonView.m
//  demo
//
//  Created by wen on 15/7/23.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "TFWRSButtonView.h"

@interface TFWRSButtonView ()

@property (nonatomic,strong) UIButton *centerBt;
@property (nonatomic,strong) UIButton *addBt;
@property (nonatomic,strong) UILabel *textLabel;

@end

@implementation TFWRSButtonView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(id)createButtonWithTag:(TenElementType)tag andCenter:(CGPoint)center
{
    TFWRSButtonView *btView = [[TFWRSButtonView alloc] initWithFrame:CGRectMake(0, 0, 120, 120)];
    btView.backgroundColor = [UIColor clearColor];
    btView.center = center;
    [btView bulidViewwithTag:tag];
    btView.alpha = 0.0f;
    
    return btView;
}

-(void)bulidViewwithTag:(TenElementType)tag
{
    switch (tag) {
        case TenElementTypeBrand:
            [self buildButtonwithSize:CGSizeMake(79, 78) andImageName:@"tfw_rs_brand"];
            [self buildLabelwithText:@"品牌实力"];
            break;
            
        case TenElementTypeFree:
            [self buildButtonwithSize:CGSizeMake(98, 99) andImageName:@"tfw_rs_free"];
            [self buildLabelwithText:@"自由晋级"];
            break;
            
        case TenElementTypeHonour:
            [self buildButtonwithSize:CGSizeMake(79, 78) andImageName:@"tfw_rs_honour"];
            [self buildLabelwithText:@"荣誉奖励"];
            break;
            
        case TenElementTypeIncome:
            [self buildButtonwithSize:CGSizeMake(79, 79) andImageName:@"tfw_rs_income"];
            [self buildLabelwithText:@"收入丰厚"];
            break;
            
        case TenElementTypeLearn:
            [self buildButtonwithSize:CGSizeMake(89, 89) andImageName:@"tfw_rs_learn"];
            [self buildLabelwithText:@"学习成长"];
            break;
            
        case TenElementTypeLife:
            [self buildButtonwithSize:CGSizeMake(79, 78) andImageName:@"tfw_rs_life"];
            [self buildLabelwithText:@"生活平衡"];
            break;
            
        case TenElementTypeSocity:
            [self buildButtonwithSize:CGSizeMake(59, 59) andImageName:@"tfw_rs_socity"];
            [self buildLabelwithText:@"社会贡献"];
            break;
            
        case TenElementTypeSpace:
            [self buildButtonwithSize:CGSizeMake(79, 78) andImageName:@"tfw_rs_space"];
            [self buildLabelwithText:@"发展空间"];
            break;
            
        case TenElementTypeSuit:
            [self buildButtonwithSize:CGSizeMake(78, 79) andImageName:@"tfw_rs_suit"];
            [self buildLabelwithText:@"适合度"];
            break;
            
        case TenElementTypeWork:
            [self buildButtonwithSize:CGSizeMake(59, 59) andImageName:@"tfw_rs_work"];
            [self buildLabelwithText:@"工作自主"];
            break;
        
        default:
            break;
    }
    
    [self buildAdd];
}

-(void)buildButtonwithSize:(CGSize)size andImageName:(NSString *)name
{
    _centerBt = [UIButton buttonWithType:UIButtonTypeCustom];
    _centerBt.tag = TenElementTypeBrand;
    [_centerBt setBackgroundImage:[UIImage imageNamed:name] forState:UIControlStateSelected];
    [_centerBt setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_gray",name]] forState:UIControlStateNormal];
    [_centerBt setShowsTouchWhenHighlighted:NO];
    _centerBt.frame = CGRectMake(0, 0, size.width, size.height);
    _centerBt.center = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0);
    [_centerBt addTarget:self action:@selector(elementAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_centerBt];
}

-(void)buildAdd
{
    _addBt = [UIButton buttonWithType:UIButtonTypeCustom];
    _addBt.tag = TenElementTypeBrand;
    [_addBt setBackgroundImage:[UIImage imageNamed:@"tfw_rs_add"] forState:UIControlStateNormal];
    _addBt.frame = CGRectMake(0, 0, _centerBt.bounds.size.width / 10 * 3, _centerBt.bounds.size.width / 10 * 3);
    _addBt.center = CGPointMake(_centerBt.frame.origin.x + _centerBt.frame.size.width, _centerBt.frame.origin.y);
    [_addBt addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_addBt];
}

-(void)buildLabelwithText:(NSString *)text
{
    _textLabel = [UILabel new];
    _textLabel.frame = CGRectMake(0, self.bounds.size.height / 2.0 + self.centerBt.bounds.size.height / 2.0 + 5, 120, 20);
    _textLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_textLabel];
    
    _textLabel.font = [UIFont systemFontOfSize:16];
    _textLabel.textColor = [UIColor blackColor];
    
    _textLabel.text = text;
}

-(void)elementAction:(UIButton *)bt
{
    if (_tapBlock) {
        self.tapBlock(bt);
    }
}

-(void)addAction:(UIButton *)bt
{
    if (_addBlock) {
        self.addBlock(bt);
    }
}



@end
