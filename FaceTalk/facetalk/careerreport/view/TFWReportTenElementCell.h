//
//  TFWReportCell.h
//  demo
//
//  Created by wen on 15/8/8.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TFWReportTenElementCell : UITableViewCell

@property (nonatomic,copy) void(^checkBlock)(UIButton *bt);

-(void)configImageName:(NSString *)imageName Title:(NSString *)title SubTitle:(NSString *)subTitle andCheck:(BOOL)check;
-(void)configImageName:(NSString *)imageName Title:(NSString *)title SubTitle:(NSString *)subTitle andCheck:(BOOL)check andTag:(NSInteger)tag;
-(void)configImageName:(NSString *)imageName Title:(NSString *)title SubTitle:(NSString *)subTitle andCheck:(BOOL)check andHideCheck:(BOOL)isHide;

@end
