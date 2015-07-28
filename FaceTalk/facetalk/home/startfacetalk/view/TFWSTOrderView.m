//
//  TFWSTOrderView.m
//  demo
//
//  Created by wen on 15/7/18.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "TFWSTOrderView.h"
#import "TFWSTOrderItem.h"

@interface TFWSTOrderView ()

@property (nonatomic,copy) NSArray *orderArray;

@end

@implementation TFWSTOrderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(id)createItemWithCenter:(CGPoint)center andIndex:(NSArray *)order
{
    TFWSTOrderView *orderView = [[TFWSTOrderView alloc] initWithFrame:CGRectZero];
    orderView.center = center;
    orderView.orderArray = order;
    [orderView buildView];
    
    return orderView;
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0, 0, 900, 380)];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

-(void)buildView
{
    if ([self.orderArray count] != 4) {
        return;
    }
    
    for (int i = 0; i < 4; i++) {
        NSInteger index = [[self.orderArray objectAtIndex:i] intValue];
        TFWSTOrderItem *item = [TFWSTOrderItem createItemWithCenter:CGPointMake(150 + 200 * i, 190) andIndex:index delay:0.5 * i];
        item.transform = CGAffineTransformScale(item.transform, 0.9, 0.9);
        [self addSubview:item];
        if (i < 3) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(240 + 202 * i, 175, 17, 29)];
            imageView.image = [UIImage imageNamed:@"tfw_sf_right"];
            [self addSubview:imageView];
        }

    }
}


@end
