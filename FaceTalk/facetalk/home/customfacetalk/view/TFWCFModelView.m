//
//  TFWCFModelView.m
//  demo
//
//  Created by wen on 15/7/17.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "TFWCFModelView.h"

@interface TFWCFModelView ()

@property (nonatomic,strong) UILabel     *titleLabel;
@property (nonatomic,strong) UILabel     *subTitleLabel;
@property (nonatomic,strong) UIImageView *numberImageView;


@property (nonatomic,strong) NSString     *title;
@property (nonatomic,strong) NSString  *subTitle;
@property (nonatomic,assign) NSInteger index;

@end

@implementation TFWCFModelView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(id)createModelViewwithX:(float)x Y:(float)y title:(NSString *)title subTitle:(NSString *)subtitle index:(NSInteger)index
{
    TFWCFModelView *view = [[TFWCFModelView alloc] initWithFrame:CGRectMake(x, y, 0, 0)];
    view.title = title;
    view.subTitle = subtitle;
    view.index = index;
    [view buildView];
    
    return view;
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, 191 / 2.0, 230 / 2.0)];
    if (self) {
    }

    return self;
}

-(void)buildView
{
    [self buildBorder];
    
    [self buildNumber];
    
    [self buildText];
}

-(void)buildBorder
{
    UIImageView *back    = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 191 / 2.0, 191 / 2.0, 230 / 2.0)];
    back.image           = [UIImage imageNamed:@"tfw_tf_realborder"];
    back.alpha = 1.0;
    [self addSubview:back];
    
//    [UIView animateWithDuration:1.3 animations:^{
//        back.alpha = 1.0;
//    }];
}

-(void)buildNumber
{
    NSString *imageName = [NSString stringWithFormat:@"tfw_cf_realnumber%ld",(long)self.index];
    self.numberImageView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageName ofType:@"png"]]];
    [self.numberImageView sizeToFit];
    self.numberImageView.center = CGPointMake(50, 15);
    [self addSubview:self.numberImageView];
    self.numberImageView.alpha = 1.0;
//    [UIView animateWithDuration:1.3 animations:^{
//        self.numberImageView.alpha = 1.0;
//    }];

}

-(void)buildText
{
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, 191 / 2.0, 50)];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:27];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.text = self.title;
    self.titleLabel.textColor = [UIColor colorWithRed:188 / 255.0 green:0 / 255.0 blue:52 / 255.0 alpha:1];
    [self addSubview:self.titleLabel];
    
    self.subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, 191 / 2.0, 50)];
    self.subTitleLabel.font = [UIFont systemFontOfSize:22];
    self.subTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.subTitleLabel.text = self.subTitle;
    self.subTitleLabel.textColor = [UIColor colorWithRed:188 / 255.0 green:0 / 255.0 blue:52 / 255.0 alpha:1];
    [self addSubview:self.subTitleLabel];
    
//    CGAffineTransform title_trans = self.titleLabel.transform;
//    CGAffineTransform subtitle_trans = self.subTitleLabel.transform;
//    self.titleLabel.transform = CGAffineTransformScale(title_trans, 0, 0);
//    self.subTitleLabel.transform = CGAffineTransformScale(subtitle_trans, 0, 0);
//    [UIView animateWithDuration:0.8 animations:^{
//        self.titleLabel.transform = CGAffineTransformScale(title_trans, 1.3, 1.3);
//        self.subTitleLabel.transform = CGAffineTransformScale(subtitle_trans, 1.3, 1.3);
//    } completion:^(BOOL finished) {
//        [UIView animateWithDuration:0.5 animations:^{
//            self.titleLabel.transform = CGAffineTransformScale(title_trans, 1.0, 1.0);
//            self.subTitleLabel.transform = CGAffineTransformScale(subtitle_trans, 1.0, 1.0);
//        }];
//    }];
}

@end
