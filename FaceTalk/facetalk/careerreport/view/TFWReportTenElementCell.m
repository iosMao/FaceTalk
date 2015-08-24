//
//  TFWReportCell.m
//  demo
//
//  Created by wen on 15/8/8.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "TFWReportTenElementCell.h"

@interface TFWReportTenElementCell ()

@property (nonatomic,strong) UIImageView *leftImageView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UITextView *subLabel;
@property (nonatomic,strong) UIButton *checkButton;

@end

@implementation TFWReportTenElementCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self initView];
    }
    
    return self;
}

-(void)initView
{
    _leftImageView = [[UIImageView alloc] init];
    _leftImageView.contentMode = UIViewContentModeCenter;
    [self.contentView addSubview:_leftImageView];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.backgroundColor = [UIColor redColor];
    _titleLabel.backgroundColor = [UIColor colorWithRed:211 / 255.0 green:17 / 255.0 blue:69 / 255.0 alpha:1.0];
    _titleLabel.font = [UIFont boldSystemFontOfSize:18];
    _titleLabel.textColor = [UIColor whiteColor];
    [self.contentView addSubview:_titleLabel];
    
    _subLabel = [[UITextView alloc] init];
    _subLabel.userInteractionEnabled = NO;
    _subLabel.textColor = [UIColor blackColor];
    _subLabel.font = [UIFont systemFontOfSize:17];
    [self.contentView addSubview:_subLabel];
    
    _checkButton = [[UIButton alloc] init];
    [_checkButton setImage:[UIImage imageNamed:@"ftw_share_check_null"] forState:UIControlStateNormal];
    [_checkButton setImage:[UIImage imageNamed:@"ftw_share_check_ok"] forState:UIControlStateSelected];
    [_checkButton addTarget:self action:@selector(checkAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_checkButton];
}

-(void)layoutSubviews
{
    _leftImageView.frame = CGRectMake(0, 0, CGRectGetHeight(self.frame), CGRectGetHeight(self.frame));
    _titleLabel.frame = CGRectMake(CGRectGetHeight(self.frame), 10, CGRectGetWidth(self.frame) - CGRectGetHeight(self.frame) - 100, 25);
    [_titleLabel drawTextInRect:CGRectMake(CGRectGetHeight(self.frame) + 15, 10, CGRectGetWidth(self.frame) - CGRectGetHeight(self.frame) - 100 - 15, 25)];
    _subLabel.frame = CGRectMake(CGRectGetMinX(_titleLabel.frame), CGRectGetMaxY(_titleLabel.frame), CGRectGetWidth(_titleLabel.frame), CGRectGetHeight(self.frame) - CGRectGetMaxY(_titleLabel.frame));
    _checkButton.frame = CGRectMake(CGRectGetWidth(self.frame) - 50, CGRectGetMinY(_titleLabel.frame), 29, 29);
}

-(void)configImageName:(NSString *)imageName Title:(NSString *)title SubTitle:(NSString *)subTitle andCheck:(BOOL)check andHideCheck:(BOOL)isHide
{
    [self configImageName:imageName Title:title SubTitle:subTitle andCheck:check];
    _checkButton.hidden = isHide;
}

-(void)configImageName:(NSString *)imageName Title:(NSString *)title SubTitle:(NSString *)subTitle andCheck:(BOOL)check andTag:(NSInteger)tag
{
    [self configImageName:imageName Title:title SubTitle:subTitle andCheck:check];
    _checkButton.tag = tag;
}

-(void)configImageName:(NSString *)imageName Title:(NSString *)title SubTitle:(NSString *)subTitle andCheck:(BOOL)check
{
    _leftImageView.image = [UIImage imageNamed:imageName];
    _titleLabel.text = title;
    _subLabel.text = subTitle;
    _checkButton.selected = check;
}

-(void)checkAction:(UIButton *)button
{
    button.selected = !button.selected;
    if (self.checkBlock) {
        self.checkBlock(button);
    }
}

@end
