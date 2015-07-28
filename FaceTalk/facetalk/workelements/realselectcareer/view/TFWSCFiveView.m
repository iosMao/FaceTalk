//
//  TFWSCFiveView.m
//  demo
//
//  Created by wen on 15/7/23.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "TFWSCFiveView.h"

#define LINEWIDTH 5
#define LINECOLOR [UIColor redColor].CGColor
#define SHADOWCOLOR [UIColor colorWithRed:240 / 255.0 green:201 / 255.0 blue:211 / 255.0 alpha:1].CGColor
#define BIGWIDTH 250
#define SMAWIDTH 160

@interface TFWSCFiveView ()

@property (nonatomic,strong) UIImageView * shadowImageView;
@property (nonatomic,assign) BOOL is_hope;
@property (nonatomic,strong) UILabel *subLabel1;
@property (nonatomic,strong) UILabel *subLabel2;
@property (nonatomic,strong) UILabel *subLabel3;
@property (nonatomic,strong) UILabel *subLabel4;
@property (nonatomic,strong) UILabel *subLabel5;

@end

@implementation TFWSCFiveView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(id)createFiveWithCenter:(CGPoint)center is_Hope:(BOOL)is_hope
{
    TFWSCFiveView *sc = [[TFWSCFiveView alloc] initWithFrame:CGRectZero];
    sc.center = center;
    sc.is_hope = is_hope;
    [sc buildView];
    
    return sc;
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0, 0, 400, 300)];
    if (self) {
        
    }
    
    return self;
}

-(void)setShadowwithRate1:(CGFloat)rate1 withRate2:(CGFloat)rate2 withRate3:(CGFloat)rate3 withRate4:(CGFloat)rate4 withRate5:(CGFloat)rate5
{
    self.rate0 = rate1;
    self.rate1 = rate2;
    self.rate2 = rate3;
    self.rate3 = rate4;
    self.rate4 = rate5;
    _shadowImageView.image = [self createFiveShadowwithSize:CGSizeMake(BIGWIDTH, BIGWIDTH) withRate1:rate1 withRate2:rate2 withRate3:rate3 withRate4:rate4 withRate5:rate5];
}

-(void)setSubTitle1:(NSString *)title1 Title2:(NSString *)title2 Title3:(NSString *)title3 Title4:(NSString *)title4 Title:(NSString *)title5
{
    _subLabel1.text = title1;
    _subLabel2.text = title2;
    _subLabel3.text = title3;
    _subLabel4.text = title4;
    _subLabel5.text = title5;
}






-(void)buildView
{
    [self createShadow];
    [self createBackImage];
    [self createTitleLabel];
}

-(void)createBackImage
{
    UIImageView *imageView_out = [[UIImageView alloc] initWithImage:[self createFiveViewBackwithSize:CGSizeMake(BIGWIDTH, BIGWIDTH)]];
    imageView_out.center = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0);
    [self addSubview:imageView_out];
    
    UIImageView *imageView_in = [[UIImageView alloc] initWithImage:[self createFiveViewBackwithSize:CGSizeMake(SMAWIDTH, SMAWIDTH)]];
    imageView_in.center = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0);
    [self addSubview:imageView_in];
    
    UIImageView *lineImage = [[UIImageView alloc] initWithImage:[self createLineImagewithSize:CGSizeMake(BIGWIDTH, BIGWIDTH)]];imageView_in.center = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0);
    lineImage.center = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0);
    [self addSubview:lineImage];

}

-(void)createShadow
{
    _shadowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, BIGWIDTH, BIGWIDTH)];
    _shadowImageView.center = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0);
    _shadowImageView.alpha = 0.7;
    [self addSubview:_shadowImageView];
}

-(void)createTitleLabel
{
    CGSize size = CGSizeMake(BIGWIDTH, BIGWIDTH);
    CGFloat radio = size.width / 2.0;
    CGFloat width_dif = self.bounds.size.width / 2 - radio;
    CGFloat height_dif = self.bounds.size.height / 2 - radio;
    
    CGPoint p1 = CGPointMake(size.width / 2 + width_dif, 0 + height_dif);
    CGPoint p2 = CGPointMake(radio * (1 + cos(0.1 * M_PI)) + width_dif, height_dif + radio * (1 - sin(0.1 * M_PI)));
    CGPoint p3 = CGPointMake(radio * (1 + sin(0.2 * M_PI)) + width_dif, height_dif + radio * (1 + cos(0.2 * M_PI)));
    CGPoint p4 = CGPointMake(radio * (1 - sin(0.2 * M_PI)) + width_dif, height_dif + radio * (1 + cos(0.2 * M_PI)));
    CGPoint p5 = CGPointMake(radio * (1 - cos(0.1 * M_PI)) + width_dif, height_dif + radio * (1 - sin(0.1 * M_PI)));
    
    
    
    _subLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(p1.x - 40, p1.y - 40, 80, 30)];
    _subLabel1.textAlignment = NSTextAlignmentCenter;
    _subLabel1.textColor = self.is_hope ? [UIColor whiteColor] : [UIColor blackColor];
    [self addSubview:_subLabel1];
    
    _subLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(p2.x + 10, p2.y - 15, 80, 30)];
    _subLabel2.textAlignment = NSTextAlignmentCenter;
    _subLabel2.textColor = self.is_hope ? [UIColor whiteColor] : [UIColor blackColor];
    [self addSubview:_subLabel2];

    
    _subLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(p3.x + 10, p3.y - 20, 80, 30)];
    _subLabel3.textAlignment = NSTextAlignmentCenter;
    _subLabel3.textColor = self.is_hope ? [UIColor whiteColor] : [UIColor blackColor];
    [self addSubview:_subLabel3];

    
    _subLabel4 = [[UILabel alloc] initWithFrame:CGRectMake(p4.x - 90, p4.y - 20, 80, 30)];
    _subLabel4.textAlignment = NSTextAlignmentCenter;
    _subLabel4.textColor = self.is_hope ? [UIColor whiteColor] : [UIColor blackColor];
    [self addSubview:_subLabel4];

    
    _subLabel5 = [[UILabel alloc] initWithFrame:CGRectMake(p5.x - 90, p5.y - 15, 80, 30)];
    _subLabel5.textAlignment = NSTextAlignmentCenter;
    _subLabel5.textColor = self.is_hope ? [UIColor whiteColor] : [UIColor blackColor];
    [self addSubview:_subLabel5];

}

-(UIImage *)createFiveViewBackwithSize:(CGSize)size
{
    CGFloat radio = size.width / 2.0;
    CGPoint p1 = CGPointMake(size.width / 2, 0);
    CGPoint p2 = CGPointMake(radio * (1 + cos(0.1 * M_PI)), radio * (1 - sin(0.1 * M_PI)));
    CGPoint p3 = CGPointMake(radio * (1 + sin(0.2 * M_PI)), radio * (1 + cos(0.2 * M_PI)));
    CGPoint p4 = CGPointMake(radio * (1 - sin(0.2 * M_PI)), radio * (1 + cos(0.2 * M_PI)));
    CGPoint p5 = CGPointMake(radio * (1 - cos(0.1 * M_PI)), radio * (1 - sin(0.1 * M_PI)));
    
    UIGraphicsBeginImageContext(size);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:p1];
    [path addLineToPoint:p2];
    [path addLineToPoint:p3];
    [path addLineToPoint:p4];
    [path addLineToPoint:p5];
    [path addLineToPoint:p1];
    
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), LINEWIDTH);
    CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), self.is_hope ? [UIColor whiteColor].CGColor : [UIColor colorWithRed:197 / 255.0 green:0 / 255.0 blue:54 / 255.0 alpha:1].CGColor);
    
    [path stroke];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

-(UIImage *)createLineImagewithSize:(CGSize)size
{
    CGFloat radio = size.width / 2.0;
    CGPoint p1 = CGPointMake(size.width / 2, 0);
    CGPoint p2 = CGPointMake(radio * (1 + cos(0.1 * M_PI)), radio * (1 - sin(0.1 * M_PI)));
    CGPoint p3 = CGPointMake(radio * (1 + sin(0.2 * M_PI)), radio * (1 + cos(0.2 * M_PI)));
    CGPoint p4 = CGPointMake(radio * (1 - sin(0.2 * M_PI)), radio * (1 + cos(0.2 * M_PI)));
    CGPoint p5 = CGPointMake(radio * (1 - cos(0.1 * M_PI)), radio * (1 - sin(0.1 * M_PI)));
    CGPoint center = CGPointMake(size.width / 2.0, size.height / 2.0);

    
    UIGraphicsBeginImageContext(size);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:p1];
    [path addLineToPoint:center];
    [path moveToPoint:p2];
    [path addLineToPoint:center];
    [path moveToPoint:p3];
    [path addLineToPoint:center];
    [path moveToPoint:p4];
    [path addLineToPoint:center];
    [path moveToPoint:p5];
    [path addLineToPoint:center];

    
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), LINEWIDTH);
    CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), self.is_hope ? [UIColor whiteColor].CGColor : [UIColor colorWithRed:197 / 255.0 green:0 / 255.0 blue:54 / 255.0 alpha:1].CGColor);
    
    [path stroke];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

-(UIImage *)createFiveShadowwithSize:(CGSize)size withRate1:(CGFloat)rate1 withRate2:(CGFloat)rate2 withRate3:(CGFloat)rate3 withRate4:(CGFloat)rate4 withRate5:(CGFloat)rate5
{
    CGFloat radio = size.width / 2.0;
    CGPoint p1 = CGPointMake(size.width / 2, 0);
    CGPoint p2 = CGPointMake(radio * (1 + cos(0.1 * M_PI)), radio * (1 - sin(0.1 * M_PI)));
    CGPoint p3 = CGPointMake(radio * (1 + sin(0.2 * M_PI)), radio * (1 + cos(0.2 * M_PI)));
    CGPoint p4 = CGPointMake(radio * (1 - sin(0.2 * M_PI)), radio * (1 + cos(0.2 * M_PI)));
    CGPoint p5 = CGPointMake(radio * (1 - cos(0.1 * M_PI)), radio * (1 - sin(0.1 * M_PI)));
    CGPoint center = CGPointMake(size.width / 2.0, size.height / 2.0);
    
    p1 = CGPointMake(center.x + rate1 * (p1.x - center.x), center.y + rate1 * (p1.y - center.y));
    p2 = CGPointMake(center.x + rate2 * (p2.x - center.x), center.y + rate2 * (p2.y - center.y));
    p3 = CGPointMake(center.x + rate3 * (p3.x - center.x), center.y + rate3 * (p3.y - center.y));
    p4 = CGPointMake(center.x + rate4 * (p4.x - center.x), center.y + rate4 * (p4.y - center.y));
    p5 = CGPointMake(center.x + rate5 * (p5.x - center.x), center.y + rate5 * (p5.y - center.y));
    
    
    UIGraphicsBeginImageContext(size);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:p1];
    [path addLineToPoint:p2];
    [path addLineToPoint:p3];
    [path addLineToPoint:p4];
    [path addLineToPoint:p5];
    [path addLineToPoint:p1];
    
    CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext(), SHADOWCOLOR);
    
    [path fill];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


@end
