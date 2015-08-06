//
//  FTDBigImageView.h
//  FaceTalk
//
//  Created by Mao-MacPro on 15/8/6.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FTDBigImageViewDeledate <NSObject>

- (void)hiddenImageView;

@end
@interface FTDBigImageView : UIView
@property(nonatomic,strong)UIImageView *imgBig;
@property(nonatomic,strong)UILabel *lblDesc;
@property(nonatomic,strong)UIButton *btnCancel;
@property(nonatomic, weak)id<FTDBigImageViewDeledate> delegate;
@end
