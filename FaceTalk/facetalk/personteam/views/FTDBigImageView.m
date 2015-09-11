//
//  FTDBigImageView.m
//  FaceTalk
//
//  Created by Mao-MacPro on 15/8/6.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "FTDBigImageView.h"

@implementation FTDBigImageView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        self.imgBig=[[UIImageView alloc]init];
        //[self.imgBig.layer setMasksToBounds:YES];
        
        self.imgBig.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-60);
        
        [self addSubview:self.imgBig];
        
        self.lblDesc = [[UILabel alloc] initWithFrame:CGRectMake(0,self.imgBig.frame.origin.y+self.imgBig.frame.size.height, self.frame.size.width,60)];
        //lbl_price.text =@"QQ";
        
        
        self.lblDesc.font = [UIFont systemFontOfSize:26];
        self.lblDesc.textColor = [UIColor blackColor];
        self.lblDesc.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.lblDesc];
        
        self.btnCancel=[[UIButton alloc]initWithFrame:CGRectMake(0,0,self.frame.size.width, self.frame.size.height)];
        [self.btnCancel addTarget:self action:@selector(cancelclick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.btnCancel];
    }
    
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
}
-(void)cancelclick
{
    if ([self.delegate respondsToSelector:@selector(hiddenImageView)])
        [self.delegate hiddenImageView];
}

@end
