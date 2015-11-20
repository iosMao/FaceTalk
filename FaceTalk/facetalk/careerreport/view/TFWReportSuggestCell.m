//
//  TFWReportSuggestCell.m
//  demo
//
//  Created by wen on 15/8/9.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "TFWReportSuggestCell.h"

@implementation TFWReportSuggestCell

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
    _textView = [[UITextView alloc] init];
    _textView.layer.masksToBounds = YES;
    _textView.layer.borderColor = [UIColor grayColor].CGColor;
    _textView.layer.borderWidth = 1.0f;
    [self.contentView addSubview:_textView];
    
}

-(void)layoutSubviews
{
    _textView.frame = CGRectMake(10, 12, CGRectGetWidth(self.frame) - 20, CGRectGetHeight(self.frame) - 24);
}

@end
