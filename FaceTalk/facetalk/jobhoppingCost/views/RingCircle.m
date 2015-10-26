//
//  RingCircle.m
//  瀑布流
//
//  Created by 赵文 on 15/10/21.
//  Copyright © 2015年 赵文. All rights reserved.
//

#import "RingCircle.h"

@interface RingCircle ()

@property (nonatomic,assign) CGFloat radius;
@property (nonatomic,assign) CGFloat width;

@end

@implementation RingCircle


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
//    UIBezierPath *bezier = [UIBezierPath bezierPath];
//    [bezier addArcWithCenter:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)) radius:_radius + _width / 2.0 startAngle:0 endAngle:M_PI clockwise:YES];
//    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), _width);
//    CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), [UIColor redColor].CGColor);
//    [bezier stroke];
}

+(instancetype)createRingWithCenter:(CGPoint)center radius:(CGFloat)radius width:(CGFloat)width{
    RingCircle *ring = [[RingCircle alloc] init];
    ring.contentMode = UIViewContentModeScaleToFill;
    ring.backgroundColor = [UIColor clearColor];
    ring.frame = CGRectMake(0, 0, (radius + width + 50) * 2, (radius + width + 50) * 2);
    ring.center = center;
    ring.radius = radius;
    ring.width = width;
    
    [ring initView];
    
    return ring;
}

-(void)initView{
    self.backgroundColor = [UIColor lightGrayColor];
}

-(void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    self.image = [self getImage];
}

-(UIImage *)getImage{
    
    CGFloat allScore = 0;
    for (RingModel *model in _dataArray) {
        allScore += model.score;
    }
    
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, 0.0, 0.0);
    CGFloat curAngle = M_PI / 2.0;
    for (RingModel *model in _dataArray) {
        CGFloat angle = M_PI * 2 * (model.score / allScore);
        CGContextAddArc(UIGraphicsGetCurrentContext(), CGRectGetWidth(self.frame) / 2.0, CGRectGetHeight(self.frame) / 2.0, _radius, curAngle, curAngle + angle, 0);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), _width);
        CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), model.color.CGColor);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        
        CGFloat midAngle = curAngle + angle / 2.0;
        CGFloat word_x = (_radius + _width + 10) * cos(midAngle) + CGRectGetWidth(self.frame) / 2.0 - 10;
        CGFloat word_y = (_radius + _width + 10) * sin(midAngle) + CGRectGetHeight(self.frame) / 2.0;
        [model.title drawAtPoint:CGPointMake(word_x, word_y) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor blackColor]}];
        
        curAngle += angle;
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
