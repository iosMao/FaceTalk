//
//  FTDRightMenuView.m
//  FaceTalk
//
//  Created by Mao-MacPro on 15/10/23.
//  Copyright © 2015年 wen. All rights reserved.
//

#import "FTDRightMenuView.h"
#import "FTDRightButton.h"

@interface FTDRightMenuView ()

@property (nonatomic,strong) NSArray *menuArray;
@property (nonatomic,strong) FTDRightButton *lastButton;

@end
@implementation FTDRightMenuView
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
}

+(id)createMenuwithArray:(NSArray *)itemArray andBottom:(CGPoint)bottom andHightBtnIndex:(int)index
{
    FTDRightMenuView *resultView = [[FTDRightMenuView alloc] initWithFrame:CGRectMake(0, 0, 35, (90 + 12) * [itemArray count])];
    resultView.backgroundColor = [UIColor clearColor];
    resultView.layer.anchorPoint = CGPointMake(0.5, 1);
    resultView.center = bottom;
    resultView.menuArray = itemArray;
    [resultView buildView:index];
    
    return resultView;
}

-(void)buildView:(int)index
{
    for (int i = 0; i < [self.menuArray count]; i++) {
        FTDRightButton *button = [[FTDRightButton alloc] initWithFrame:CGRectMake(0, (90 + 12) * i, 32, 90)];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.numberOfLines = 0;
        [button setBackgroundColor:[UIColor clearColor]];
        //        [button setAttributedTitle:[[NSAttributedString alloc] initWithString:[self.menuArray objectAtIndex:i] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor whiteColor]}] forState:UIControlStateNormal];
        [button setText:[self.menuArray objectAtIndex:i]];
        button.tag = 5000 + i;
        [self addSubview:button];
        
        if (i == index) {
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

-(void)buttonAction:(FTDRightButton *)button
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
    
    if (self.rightMenuTapBlock) {
        self.rightMenuTapBlock(button.tag - 5000);
    }
}
@end
