//
//  TFWRSCenterView.m
//  demo
//
//  Created by wen on 15/7/22.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "TFWRSCenterView.h"

@interface TFWRSCenterView ()

@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) UIImageView *roundImage;

@end

@implementation TFWRSCenterView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
//    UIBezierPath *path = [UIBezierPath bezierPath];
//    [path moveToPoint:CGPointMake(self.bounds.size.width / 2.0, 3)];
//    CGFloat angle = M_PI ;
//    [path addArcWithCenter:CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.width / 2.0) radius:self.bounds.size.width / 2.0 - 3 startAngle:0 endAngle:angle clockwise:NO];
    
}


+(id)createWithCenter:(CGPoint)point
{
    TFWRSCenterView *centerView = [[TFWRSCenterView alloc] initWithFrame:CGRectMake(0, 0, 212, 212)];
    centerView.center = point;
    
    return centerView;
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self buildView];
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

-(void)buildView
{
    UILabel *lblCom = [[UILabel alloc] initWithFrame:CGRectMake(10, 23, 192, 20)];
     lblCom.text =@"完成度";
    lblCom.numberOfLines = 0;
    lblCom.textAlignment=NSTextAlignmentCenter;
    lblCom.font = [UIFont boldSystemFontOfSize:17];
    lblCom.textColor = [UIColor colorWithRed:211 / 255.0 green:17 / 255.0 blue:69 / 255.0 alpha:1];
    lblCom.backgroundColor = [UIColor clearColor];
    [self addSubview:lblCom];
    
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 192, 182)];
    self.label.numberOfLines = 0;
    self.label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.label];
    
    [self.layer setMasksToBounds:YES];
    self.layer.cornerRadius = self.bounds.size.width / 2.0;
    
    [self setBackRound];
    
    self.roundImage = [UIImageView new];
    self.roundImage.frame = self.bounds;
    [self addSubview:self.roundImage];
}

-(void)setAttributeString:(int)number
{
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] init];
    
    NSAttributedString *completestr = [[NSAttributedString alloc] initWithString:@"完成度\n" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16], NSForegroundColorAttributeName : [UIColor colorWithRed:211 / 255.0 green:17 / 255.0 blue:69 / 255.0 alpha:1]}];
    
    NSAttributedString *numberstr = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%3d",number] attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:89], NSForegroundColorAttributeName : [UIColor colorWithRed:211 / 255.0 green:17 / 255.0 blue:69 / 255.0 alpha:1]}];
    NSAttributedString *percentstr = [[NSAttributedString alloc] initWithString:@"\%\n" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:26], NSForegroundColorAttributeName : [UIColor colorWithRed:211 / 255.0 green:17 / 255.0 blue:69 / 255.0 alpha:1]}];
    
    NSAttributedString *pleasetstr = [[NSAttributedString alloc] initWithString:@"请" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13], NSForegroundColorAttributeName : [UIColor colorWithRed:9 / 255.0 green:9 / 255.0 blue:9 / 255.0 alpha:1]}];
    NSAttributedString *lightstr = [[NSAttributedString alloc] initWithString:@"点亮\n" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13], NSForegroundColorAttributeName : [UIColor colorWithRed:211 / 255.0 green:17 / 255.0 blue:69 / 255.0 alpha:1]}];
    
    NSAttributedString *last1str = [[NSAttributedString alloc] initWithString:@"最重要的" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13], NSForegroundColorAttributeName : [UIColor colorWithRed:9 / 255.0 green:9 / 255.0 blue:9 / 255.0 alpha:1]}];
    NSAttributedString *last2str = [[NSAttributedString alloc] initWithString:@"5" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20], NSForegroundColorAttributeName : [UIColor colorWithRed:211 / 255.0 green:17 / 255.0 blue:69 / 255.0 alpha:1]}];
    NSAttributedString *last3str = [[NSAttributedString alloc] initWithString:@"个求职要素\n开启璀璨星空锁" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13], NSForegroundColorAttributeName : [UIColor colorWithRed:9 / 255.0 green:9 / 255.0 blue:9 / 255.0 alpha:1]}];
    
    //[attribute appendAttributedString:completestr];
    [attribute appendAttributedString:numberstr];
    [attribute appendAttributedString:percentstr];
    [attribute appendAttributedString:pleasetstr];
    [attribute appendAttributedString:lightstr];
    [attribute appendAttributedString:last1str];
    [attribute appendAttributedString:last2str];
    [attribute appendAttributedString:last3str];
    
    
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
//    [paragraphStyle setLineSpacing:5];
//    [attribute addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, completestr.length)];
    
    self.label.attributedText = attribute;
    
    [self setImage:number];
}

-(void)setBackRound
{
    UIImageView *back = [UIImageView new];
    back.frame = self.bounds;
    [self addSubview:back];
    
    UIGraphicsBeginImageContext(self.bounds.size);
    CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), [UIColor colorWithRed:162 / 255.0 green:162 / 255.0 blue:162 / 255.0 alpha:1].CGColor);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 6);
    //    [path stroke];
    
    CGContextAddArc(UIGraphicsGetCurrentContext(), self.bounds.size.width / 2.0, self.bounds.size.width / 2.0, self.bounds.size.width / 2.0 - 3, 0, M_PI * 2, 0);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    back.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

}

-(void)setImage:(int)number
{
    UIGraphicsBeginImageContext(self.bounds.size);
    CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), [UIColor colorWithRed:211 / 255.0 green:17 / 255.0 blue:69 / 255.0 alpha:1].CGColor);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 6);
    //    [path stroke];
    
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), self.bounds.size.width / 2.0, 3);
    CGFloat angle = number / 100.0 * M_PI * 2;
    CGContextAddArc(UIGraphicsGetCurrentContext(), self.bounds.size.width / 2.0, self.bounds.size.width / 2.0, self.bounds.size.width / 2.0 - 3, -M_PI / 2, angle - M_PI / 2, 0);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.roundImage.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.number = number;
}

@end
