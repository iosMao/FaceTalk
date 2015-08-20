//
//  TFWSCItemView.m
//  demo
//
//  Created by wen on 15/7/26.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "TFWSCItemView.h"
#import "TFWSCFiveView.h"
#import "TFWSCPipeView.h"
#import "FTWElementItem.h"

@interface TFWSCItemView ()

@property (nonatomic,strong) NSArray *listArray;
@property (nonatomic,assign) BOOL is_hope;

@property (nonatomic,strong) TFWSCFiveView *fiveView;

@end

@implementation TFWSCItemView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(id)createItemWithCenter:(CGPoint)center andItemArray:(NSArray *)listArray isHope:(BOOL)is_hope
{
    TFWSCItemView *item = [[TFWSCItemView alloc] initWithFrame:CGRectZero];
    item.center = center;
    item.listArray = listArray;
    item.is_hope = is_hope;
    
    [item buildView];
    
    return item;
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0, 0, 440, 500)];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

-(void)buildView
{
    [self createTitle];
    [self createFiveView];
    [self createPipeView];
}

-(void)createTitle
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 0, 100, 40)];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = [UIFont boldSystemFontOfSize:28];
    titleLabel.textColor = self.is_hope ? [UIColor whiteColor] : [UIColor blackColor];
    titleLabel.text = self.is_hope ? @"期望" : @"现状";
    [self addSubview:titleLabel];
}

-(void)createFiveView
{
    self.fiveView = [TFWSCFiveView createFiveWithCenter:CGPointMake(220, 170) is_Hope:self.is_hope];
    [self.fiveView setSubTitle1:((FTWElementItem *)[self.listArray objectAtIndex:0]).title Title2:((FTWElementItem *)[self.listArray objectAtIndex:1]).title Title3:((FTWElementItem *)[self.listArray objectAtIndex:2]).title Title4:((FTWElementItem *)[self.listArray objectAtIndex:3]).title Title:((FTWElementItem *)[self.listArray objectAtIndex:4]).title];
    FTWElementItem * item0 = ((FTWElementItem *)[_listArray objectAtIndex:0]);
    FTWElementItem * item1 = ((FTWElementItem *)[_listArray objectAtIndex:1]);
    FTWElementItem * item2 = ((FTWElementItem *)[_listArray objectAtIndex:2]);
    FTWElementItem * item3 = ((FTWElementItem *)[_listArray objectAtIndex:3]);
    FTWElementItem * item4 = ((FTWElementItem *)[_listArray objectAtIndex:4]);
    if (_is_hope) {
        [self.fiveView setShadowwithRate1:item0.hopeScore / 10.0 withRate2:item1.hopeScore / 10.0 withRate3:item2.hopeScore / 10.0 withRate4:item3.hopeScore / 10.0 withRate5:item4.hopeScore / 10.0];
    }else{
        [self.fiveView setShadowwithRate1:item0.currentScore / 10.0 withRate2:item1.currentScore / 10.0 withRate3:item2.currentScore / 10.0 withRate4:item3.currentScore / 10.0 withRate5:item4.currentScore / 10.0];
    }
    
    [self addSubview:self.fiveView];
}

-(void)createPipeView
{
    for (int i = 0; i < 5; i++) {
        TFWSCPipeView *pipe = [TFWSCPipeView createPipeWithCenter:CGPointMake(82 + 64 * i, 390) Title:((FTWElementItem *)[self.listArray objectAtIndex:i]).title isHope:self.is_hope];
        FTWElementItem *item = ((FTWElementItem *)[_listArray objectAtIndex:i]);
        float value = _is_hope ? item.hopeScore : item.currentScore;
        [pipe setPipevalue:value];
        pipe.pipevalue = 0.5;
        pipe.tag = 11111 + i;
        __weak TFWSCItemView *weakself = self;
        [pipe setValueChangeblock:^(TFWSCPipeView *pipeView)
        {
            int index = pipeView.tag - 11111;
            FTWElementItem *item = [_listArray objectAtIndex:index];
            switch (index) {
                case 0:
                    if (_is_hope) {
                        item.hopeScore = weakself.fiveView.rate0 * 10;
                    }else{
                        item.currentScore = weakself.fiveView.rate0 * 10;
                    }
                    [weakself.fiveView setShadowwithRate1:pipeView.pipevalue withRate2:weakself.fiveView.rate1 withRate3:weakself.fiveView.rate2 withRate4:weakself.fiveView.rate3 withRate5:weakself.fiveView.rate4];
                    break;
                    
                case 1:
                    if (_is_hope) {
                        item.hopeScore = weakself.fiveView.rate1 * 10;
                    }else{
                        item.currentScore = weakself.fiveView.rate1 * 10;
                    }
                    [weakself.fiveView setShadowwithRate1:weakself.fiveView.rate0 withRate2:pipeView.pipevalue withRate3:weakself.fiveView.rate2 withRate4:weakself.fiveView.rate3 withRate5:weakself.fiveView.rate4];
                    break;
                    
                case 2:
                    if (_is_hope) {
                        item.hopeScore = weakself.fiveView.rate2 * 10;
                    }else{
                        item.currentScore = weakself.fiveView.rate2 * 10;
                    }
                    [weakself.fiveView setShadowwithRate1:weakself.fiveView.rate0 withRate2:weakself.fiveView.rate1 withRate3:pipeView.pipevalue withRate4:weakself.fiveView.rate3 withRate5:weakself.fiveView.rate4];
                    break;
                    
                case 3:
                    if (_is_hope) {
                        item.hopeScore = weakself.fiveView.rate3 * 10;
                    }else{
                        item.currentScore = weakself.fiveView.rate3 * 10;
                    }
                    [weakself.fiveView setShadowwithRate1:weakself.fiveView.rate0 withRate2:weakself.fiveView.rate1 withRate3:weakself.fiveView.rate2 withRate4:pipeView.pipevalue withRate5:weakself.fiveView.rate4];
                    break;
                    
                case 4:
                    if (_is_hope) {
                        item.hopeScore = weakself.fiveView.rate4 * 10;
                    }else{
                        item.currentScore = weakself.fiveView.rate4 * 10;
                    }
                    [weakself.fiveView setShadowwithRate1:weakself.fiveView.rate0 withRate2:weakself.fiveView.rate1 withRate3:weakself.fiveView.rate2 withRate4:weakself.fiveView.rate3 withRate5:pipeView.pipevalue];
                    break;
                    
                default:
                    break;
            }
        }];
        [self addSubview:pipe];
    }
}

@end
