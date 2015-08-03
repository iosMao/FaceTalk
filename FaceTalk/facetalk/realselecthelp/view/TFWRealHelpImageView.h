//
//  TFWRealHelpImageView.h
//  demo
//
//  Created by wen on 15/8/2.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TapBlock)(NSInteger tag);

@interface TFWRealHelpImageView : UIView

@property(nonatomic,copy) TapBlock tapBlock;

+(id)createImagewithTitle:(NSString *)title andCenter:(CGPoint)center andImageName:(NSString *)name;

@end
