//
//  TFWResultItemView.m
//  demo
//
//  Created by wen on 15/8/2.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "TFWHelpResultMenuView.h"
#import "TFWHelpResultButton.h"

@interface TFWHelpResultMenuView ()

@property (nonatomic,strong) NSArray *menuArray;
@property (nonatomic,strong) TFWHelpResultButton *lastButton;

@end

@implementation TFWHelpResultMenuView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
}

+(id)createMenuwithArray:(NSArray *)itemArray andBottom:(CGPoint)bottom
{
    TFWHelpResultMenuView *resultView = [[TFWHelpResultMenuView alloc] initWithFrame:CGRectMake(0, 0, 35, (90 + 12) * [itemArray count])];
    resultView.backgroundColor = [UIColor clearColor];
    resultView.layer.anchorPoint = CGPointMake(0.5, 1);
    resultView.center = bottom;
    resultView.menuArray = itemArray;
    [resultView buildView];
    
    return resultView;
}

-(void)buildView
{
    for (int i = 0; i < [self.menuArray count]; i++) {
        TFWHelpResultButton *button = [[TFWHelpResultButton alloc] initWithFrame:CGRectMake(0, (90 + 12) * i, 32, 90)];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.numberOfLines = 0;
        [button setBackgroundColor:[UIColor clearColor]];
//        [button setAttributedTitle:[[NSAttributedString alloc] initWithString:[self.menuArray objectAtIndex:i] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor whiteColor]}] forState:UIControlStateNormal];
        [button setText:[self.menuArray objectAtIndex:i]];
        button.tag = 1000 + i;
        [self addSubview:button];
        
        if (i == 0) {
            self.lastButton = button;
            button.selected = YES;
            [button setColor:[UIColor colorWithRed:211 / 255.0 green:17 / 255.0 blue:69 / 255.0 alpha:1.0]];
        }
        else
        {
            [button setColor:[UIColor colorWithRed:131 / 255.0 green:131 / 255.0 blue:131 / 255.0 alpha:1.0]];
        }
        button = nil;
    }
}

-(void)buttonAction:(TFWHelpResultButton *)button
{
    if (button.selected) {
        return;
    }
    if (self.lastButton) {
        self.lastButton.selected = NO;
        [self.lastButton setColor:[UIColor colorWithRed:131 / 255.0 green:131 / 255.0 blue:131 / 255.0 alpha:1.0]];
    }
    button.selected = YES;
    self.lastButton = button;
    [self.lastButton setColor:[UIColor colorWithRed:211 / 255.0 green:17 / 255.0 blue:69 / 255.0 alpha:1.0]];
    
    if (self.resultMenuTapBlock) {
        self.resultMenuTapBlock(button.tag - 1000);
    }
}


@end
