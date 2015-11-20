//
//  FTDTimeTableView.m
//  FaceTalk
//
//  Created by Mao-MacPro on 15/10/30.
//  Copyright © 2015年 wen. All rights reserved.
//

#import "FTDTimeTableView.h"
#import "FTDPoint.h"
@implementation FTDTimeTableView
+(FTDTimeTableView *)initCustomview
{
    NSArray* nibView = [[NSBundle mainBundle] loadNibNamed:@"FTDTimeTableView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
    
    
}


-(void)awakeFromNib
{
    NSLog(@"%f,,,,,%f",self.frame.size.width,self.frame.size.height);
    
    self.pointArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < 7; i ++) {
        for (int m = 0; m < 9; m ++) {
            FTDPoint *point = [[FTDPoint alloc] init];
            int x = 201 + i * 80;
            int y = 178 + m * 37;
            
            point.pointX = x;
            point.pointY = y;
            point.haveBtn = 0;
            [self.pointArray addObject:point];
        }
    }
    
    
    for (int i = 0; i < 7; i ++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(772, 85, 79, 36)];
        [btn setImage:[UIImage imageNamed:@"FTD_TimeTableButton1.png"] forState:UIControlStateNormal];
        btn.tag = 10000 + i;
        [btn  addTarget:self action:@selector(AdragMoving:withEvent: ) forControlEvents:UIControlEventTouchDragInside];
        [btn addTarget:self action:@selector(AdragEnded:withEvent: )forControlEvents: UIControlEventTouchUpInside |
         UIControlEventTouchUpOutside];
        [self addSubview:btn];
    }
    
    for (int i = 0; i < 7; i ++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(772, 135, 79, 36)];
        [btn setImage:[UIImage imageNamed:@"FTD_TimeTableButton2.png"] forState:UIControlStateNormal];
        btn.tag = 20000 + i;
        [btn  addTarget:self action:@selector(AdragMoving:withEvent: ) forControlEvents:UIControlEventTouchDragInside];
        [btn addTarget:self action:@selector(AdragEnded:withEvent: )forControlEvents: UIControlEventTouchUpInside |
         UIControlEventTouchUpOutside];
        [self addSubview:btn];
    }
    
    for (int i = 0; i < 7; i ++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(772, 185, 79, 36)];
        [btn setImage:[UIImage imageNamed:@"FTD_TimeTableButton3.png"] forState:UIControlStateNormal];
        btn.tag = 30000 + i;
        [btn  addTarget:self action:@selector(AdragMoving:withEvent: ) forControlEvents:UIControlEventTouchDragInside];
        [btn addTarget:self action:@selector(AdragEnded:withEvent: )forControlEvents: UIControlEventTouchUpInside |
         UIControlEventTouchUpOutside];
        [self addSubview:btn];
    }
    
    for (int i = 0; i < 7; i ++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(772, 235, 79, 36)];
        [btn setImage:[UIImage imageNamed:@"FTD_TimeTableButton4.png"] forState:UIControlStateNormal];
        btn.tag = 40000 + i;
        [btn  addTarget:self action:@selector(AdragMoving:withEvent: ) forControlEvents:UIControlEventTouchDragInside];
        [btn addTarget:self action:@selector(AdragEnded:withEvent: )forControlEvents: UIControlEventTouchUpInside |
         UIControlEventTouchUpOutside];
        [self addSubview:btn];
    }
    
    for (int i = 0; i < 7; i ++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(772, 285, 79, 36)];
        [btn setImage:[UIImage imageNamed:@"FTD_TimeTableButton5.png"] forState:UIControlStateNormal];
        btn.tag = 50000 + i;
        [btn  addTarget:self action:@selector(AdragMoving:withEvent: ) forControlEvents:UIControlEventTouchDragInside];
        [btn addTarget:self action:@selector(AdragEnded:withEvent: )forControlEvents: UIControlEventTouchUpInside |
         UIControlEventTouchUpOutside];
        [self addSubview:btn];
    }
    
    for (int i = 0; i < 7; i ++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(772, 335, 79, 36)];
        [btn setImage:[UIImage imageNamed:@"FTD_TimeTableButton6.png"] forState:UIControlStateNormal];
        btn.tag = 60000 + i;
        [btn  addTarget:self action:@selector(AdragMoving:withEvent: ) forControlEvents:UIControlEventTouchDragInside];
        [btn addTarget:self action:@selector(AdragEnded:withEvent: )forControlEvents: UIControlEventTouchUpInside |
         UIControlEventTouchUpOutside];
        [self addSubview:btn];
    }
    
    for (int i = 0; i < 7; i ++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(772, 385, 79, 36)];
        [btn setImage:[UIImage imageNamed:@"FTD_TimeTableButton7.png"] forState:UIControlStateNormal];
        btn.tag = 70000 + i;
        [btn  addTarget:self action:@selector(AdragMoving:withEvent: ) forControlEvents:UIControlEventTouchDragInside];
        [btn addTarget:self action:@selector(AdragEnded:withEvent: )forControlEvents: UIControlEventTouchUpInside |
         UIControlEventTouchUpOutside];
        [self addSubview:btn];
    }
    
     for (int i = 0; i < 7; i ++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(772, 435, 79, 36)];
        [btn setImage:[UIImage imageNamed:@"FTD_TimeTableButton8.png"] forState:UIControlStateNormal];
        btn.tag = 80000 ;
        [btn  addTarget:self action:@selector(AdragMoving:withEvent: ) forControlEvents:UIControlEventTouchDragInside];
        [btn addTarget:self action:@selector(AdragEnded:withEvent: )forControlEvents: UIControlEventTouchUpInside |
         UIControlEventTouchUpOutside];
        [self addSubview:btn];
     }

    
    
}

- (void) AdragMoving: (UIControl *) c withEvent:ev
{
    
    CGPoint point = [[[ev allTouches] anyObject] locationInView:self];
    
    c.center = point;
    
    
    
    //view.center=CGPointMake(point.x, 400-140);
    
}

- (void) AdragEnded: (UIButton *) c withEvent:ev
{
    CGPoint point = [[[ev allTouches] anyObject] locationInView:self];
    
    //c.center = point;
    
    if (point.x>154&&point.x<717&&point.y>151&&point.y<494) {
        for ( int i = 0; i < self.pointArray.count; i ++) {
            FTDPoint *localPoint = [self.pointArray objectAtIndex:i];
            int distance = pow(point.x-localPoint.pointX, 2) + pow(point.y-localPoint.pointY, 2);
            int lastdistance = sqrt(distance);
            
            if (lastdistance <= 20 ) {
                if (localPoint.haveBtn == 0) {
                    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
                        c.center = CGPointMake(localPoint.pointX, localPoint.pointY);
//                        localPoint.haveBtn = 1;
//                       [self.pointArray replaceObjectAtIndex:i withObject:localPoint];
                        
                        
                    } completion:^(BOOL finished) {
                    }];
                    //c.center = CGPointMake(localPoint.pointX, localPoint.pointY);
    //
                    break;
                }
                else//回到原始点
                {
                    if (c.tag >= 10000 && c.tag < 20000) {
                        
                        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
                            c.center = CGPointMake(772 + 79 / 2, 85 + 36 / 2);
                            
                            
                            
                        } completion:^(BOOL finished) {
                        }];
                        
                        
                    }
                    else if (c.tag >= 20000 && c.tag <30000)
                    {
                        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
                            c.center = CGPointMake(772 + 79 / 2, 135 + 36 / 2);
                            
                            
                        } completion:^(BOOL finished) {
                        }];
                        
                    }
                    else if (c.tag >= 30000 && c.tag <40000)
                    {
                        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
                            c.center = CGPointMake(772 + 79 / 2, 185 + 36 / 2);
                            
                            
                            
                        } completion:^(BOOL finished) {
                        }];
                        
                    }
                    else if (c.tag >= 40000 && c.tag <50000)
                    {
                        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
                            c.center = CGPointMake(772 + 79 / 2, 235 + 36 / 2);
                            
                            
                            
                        } completion:^(BOOL finished) {
                        }];
                        
                    }
                    else if (c.tag >= 50000 && c.tag <60000)
                    {
                        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
                           c.center = CGPointMake(772 + 79 / 2, 285 + 36 / 2);
                            
                            
                            
                        } completion:^(BOOL finished) {
                        }];
                        
                    }
                    else if (c.tag >= 60000 && c.tag <70000)
                    {
                        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
                             c.center = CGPointMake(772 + 79 / 2, 335 + 36 / 2);
                            
                            
                            
                        } completion:^(BOOL finished) {
                        }];
                       
                    }
                    else if (c.tag >= 70000 && c.tag <80000)
                    {
                        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
                            c.center = CGPointMake(772 + 79 / 2, 385 + 36 / 2);
                            
                            
                            
                        } completion:^(BOOL finished) {
                        }];
                        
                    }
                    else if (c.tag >= 80000 && c.tag <90000)
                    {
                        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
                            c.center = CGPointMake(772 + 79 / 2, 435 + 36 / 2);
                            
                            
                            
                        } completion:^(BOOL finished) {
                        }];
                        
                    }
                    
                    
                    break;
                    
                }
                
            }
            else//回到原始点
            {
    
                
            }
            
            
        }
    }
    else{
        {
            if (c.tag >= 10000 && c.tag < 20000) {
                
                [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
                    c.center = CGPointMake(772 + 79 / 2, 85 + 36 / 2);
                    
                    
                    
                } completion:^(BOOL finished) {
                }];
                
                
            }
            else if (c.tag >= 20000 && c.tag <30000)
            {
                [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
                    c.center = CGPointMake(772 + 79 / 2, 135 + 36 / 2);
                    
                    
                } completion:^(BOOL finished) {
                }];
                
            }
            else if (c.tag >= 30000 && c.tag <40000)
            {
                [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
                    c.center = CGPointMake(772 + 79 / 2, 185 + 36 / 2);
                    
                    
                    
                } completion:^(BOOL finished) {
                }];
                
            }
            else if (c.tag >= 40000 && c.tag <50000)
            {
                [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
                    c.center = CGPointMake(772 + 79 / 2, 235 + 36 / 2);
                    
                    
                    
                } completion:^(BOOL finished) {
                }];
                
            }
            else if (c.tag >= 50000 && c.tag <60000)
            {
                [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
                    c.center = CGPointMake(772 + 79 / 2, 285 + 36 / 2);
                    
                    
                    
                } completion:^(BOOL finished) {
                }];
                
            }
            else if (c.tag >= 60000 && c.tag <70000)
            {
                [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
                    c.center = CGPointMake(772 + 79 / 2, 335 + 36 / 2);
                    
                    
                    
                } completion:^(BOOL finished) {
                }];
                
            }
            else if (c.tag >= 70000 && c.tag <80000)
            {
                [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
                    c.center = CGPointMake(772 + 79 / 2, 385 + 36 / 2);
                    
                    
                    
                } completion:^(BOOL finished) {
                }];
                
            }
            else if (c.tag >= 80000 && c.tag <90000)
            {
                [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
                    c.center = CGPointMake(772 + 79 / 2, 435 + 36 / 2);
                    
                    
                    
                } completion:^(BOOL finished) {
                }];
                
            }
            
            
            
            
        }
    }
    
    
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
