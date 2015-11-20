//
//  WaterFullCell.m
//  FaceTalk
//
//  Created by Mao-MacPro on 15/10/26.
//  Copyright © 2015年 wen. All rights reserved.
//

#import "WaterFullCell.h"

@interface WaterFullCell ()

@property (nonatomic,strong) UILabel *headLabel;
@property (nonatomic,strong) UIImageView *imageView;

@end

@implementation WaterFullCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self initView];
    }
    
    return self;
}

-(void)initView{
    _headLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, CGRectGetWidth(self.frame)-40, 40)];
     _headLabel.backgroundColor = [UIColor colorWithRed:0.82 green:0.06 blue:0.27 alpha:1];
    //_headLabel.backgroundColor = [UIColor blueColor];
    _headLabel.textColor = [UIColor whiteColor];
    _headLabel.font = [UIFont boldSystemFontOfSize:17];
    [self addSubview:_headLabel];
    
    _headButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame) - 50, 5, 30, 30)];
    //[_headButton addTarget:self action:@selector(checkclick:) forControlEvents:UIControlEventTouchUpInside];
    [_headButton setImage:[UIImage imageNamed:@"ftd_reoprt_uncheck"] forState:UIControlStateNormal];
    [_headButton setImage:[UIImage imageNamed:@"ftd_reoprt_check"] forState:UIControlStateSelected];
    [self addSubview:_headButton];
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 40, CGRectGetWidth(self.frame) - 40, 30)];
    [self addSubview:_imageView];
}

-(CGFloat)setHead:(NSString *)head ImageName:(NSString *)imageName{
    _headLabel.text = head;
    
    if (imageName.length > 0) {
        _imageView.image = [UIImage imageNamed:imageName];
    }
    
    CGFloat width = CGRectGetWidth(self.frame) - 40;
    CGFloat height = _imageView.image.size.height / _imageView.image.size.width * width;
    _imageView.frame = CGRectMake(20, 40, width, height);
    
    return height + CGRectGetMaxY(_headLabel.frame);
}
-(void)checkclick:(UIButton *)btn
{
    if (_checkclickBlock) {
        _checkclickBlock(btn);
    }
}

@end
