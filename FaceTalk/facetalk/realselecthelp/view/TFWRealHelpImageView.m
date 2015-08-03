//
//  TFWRealHelpImageView.m
//  demo
//
//  Created by wen on 15/8/2.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "TFWRealHelpImageView.h"

@interface TFWRealHelpImageView ()

@property (nonatomic,strong) UIImageView *imageview;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) NSString *imageName;
@property (nonatomic,strong) NSString *imageTitle;
@property (nonatomic,assign) CGPoint centerPoint;

@end

@implementation TFWRealHelpImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(id)createImagewithTitle:(NSString *)title andCenter:(CGPoint)center andImageName:(NSString *)name
{
    TFWRealHelpImageView *helpimageview = [[TFWRealHelpImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    helpimageview.centerPoint = center;
    helpimageview.imageName = name;
    helpimageview.imageTitle = title;
    
    [helpimageview buildView];
    
    helpimageview.center = center;
    
    return helpimageview;
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    
    return self;
}

-(void)buildView
{
    _imageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.imageName]];
    self.frame = CGRectMake(0, 0, _imageview.image.size.width > 80 ? _imageview.image.size.width : 80, _imageview.image.size.height + 25);
    _imageview.frame = CGRectMake(_imageview.image.size.width > 80 ? 0 : (80 - _imageview.image.size.width) / 2.0, 0, _imageview.image.size.width, _imageview.image.size.height);
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _imageview.image.size.height + 10, self.frame.size.width, 20)];
    _titleLabel.font = [UIFont  systemFontOfSize:18];
    _titleLabel.textColor = [UIColor colorWithRed:186 / 255.0 green:12 / 255.0 blue:58 / 255.0 alpha:1.0];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.text = self.imageTitle;
    
    [self addSubview:_imageview];
    [self addSubview:_titleLabel];
    
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self addGestureRecognizer:gesture];
}

-(void)tap:(UIGestureRecognizer *)ges
{
    if (self.tapBlock) {
        self.tapBlock(self.tag);
    }
}

@end
