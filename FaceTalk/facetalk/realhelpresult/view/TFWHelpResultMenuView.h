//
//  TFWResultItemView.h
//  demo
//
//  Created by wen on 15/8/2.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ResultMenuTapBlock)(NSInteger index);

@interface TFWHelpResultMenuView : UIView

@property (nonatomic,copy) ResultMenuTapBlock resultMenuTapBlock;

+(id)createMenuwithArray:(NSArray *)itemArray andBottom:(CGPoint)bottom;

@end
