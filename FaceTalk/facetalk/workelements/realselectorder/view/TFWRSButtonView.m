//
//  TFWRSButtonView.m
//  demo
//
//  Created by wen on 15/7/23.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "TFWRSButtonView.h"
#import "FTWElementItem.h"
#import "FTWDataManager.h"
#import "FTWElementItem.h"

@interface TFWRSButtonView ()

@property (nonatomic,strong) UIButton *centerBt;
@property (nonatomic,strong) UIButton *addBt;
@property (nonatomic,strong) UILabel *textLabel;
@property (nonatomic,strong) FTWElementItem *item;
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
    btView.item = [FTWDataManager shareManager].tenElementArray[tag];
    btView.backgroundColor = [UIColor clearColor];
    btView.center = center;
    [btView bulidViewwithItem:btView.item];
    btView.alpha = 0.0f;
    
    return btView;
}

-(void)bulidViewwithItem:(FTWElementItem *)item
{
    switch (item.type) {
        case TenElementTypeBrand:
            [self buildButtonwithSize:CGSizeMake(79, 78) andImageName:item.iconName];
            [self buildLabelwithText:item.title];
            break;
            
        case TenElementTypeFree:
            [self buildButtonwithSize:CGSizeMake(98, 99) andImageName:item.iconName];
            [self buildLabelwithText:item.title];
            break;
            
        case TenElementTypeHonour:
            [self buildButtonwithSize:CGSizeMake(79, 78) andImageName:item.iconName];
            [self buildLabelwithText:item.title];
            break;
            
        case TenElementTypeIncome:
            [self buildButtonwithSize:CGSizeMake(79, 79) andImageName:item.iconName];
            [self buildLabelwithText:item.title];
            break;
            
        case TenElementTypeLearn:
            [self buildButtonwithSize:CGSizeMake(89, 89) andImageName:item.iconName];
            [self buildLabelwithText:item.title];
            break;
            
        case TenElementTypeLife:
            [self buildButtonwithSize:CGSizeMake(79, 78) andImageName:item.iconName];
            [self buildLabelwithText:item.title];
            break;
            
        case TenElementTypeSocity:
            [self buildButtonwithSize:CGSizeMake(59, 59) andImageName:item.iconName];
            [self buildLabelwithText:item.title];
            break;
            
        case TenElementTypeSpace:
            [self buildButtonwithSize:CGSizeMake(79, 78) andImageName:item.iconName];
            [self buildLabelwithText:item.title];
            break;
            
        case TenElementTypeSuit:
            [self buildButtonwithSize:CGSizeMake(78, 79) andImageName:item.iconName];
            [self buildLabelwithText:item.title];
            break;
            
        case TenElementTypeWork:
            [self buildButtonwithSize:CGSizeMake(59, 59) andImageName:item.iconName];
            [self buildLabelwithText:item.title];
            break;
        
        default:
            break;
    }
    
    [self buildAdd];
}

-(void)buildButtonwithSize:(CGSize)size andImageName:(NSString *)name
{
    _centerBt = [UIButton new];
    _centerBt.layer.masksToBounds = YES;
    [_centerBt setBackgroundImage:[UIImage imageNamed:name] forState:UIControlStateSelected];
    [_centerBt setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_gray",name]] forState:UIControlStateNormal];
    [_centerBt setShowsTouchWhenHighlighted:NO];
    _centerBt.frame = CGRectMake(0, 0, size.width, size.height);
    _centerBt.layer.cornerRadius = size.width / 2.0;
    _centerBt.center = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0);
    [_centerBt addTarget:self action:@selector(elementAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_centerBt];
    _centerBt.tag = (NSInteger)_item.type;
}

-(void)buildAdd
{
    _addBt = [UIButton buttonWithType:UIButtonTypeCustom];
    _addBt.tag = _item.type;
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
