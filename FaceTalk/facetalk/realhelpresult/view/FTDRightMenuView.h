//
//  FTDRightMenuView.h
//  FaceTalk
//
//  Created by Mao-MacPro on 15/10/23.
//  Copyright © 2015年 wen. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^RightMenuTapBlock)(NSInteger index);




@interface FTDRightMenuView : UIView
@property (nonatomic,copy) RightMenuTapBlock rightMenuTapBlock;

+(id)createMenuwithArray:(NSArray *)itemArray andBottom:(CGPoint)bottom andHightBtnIndex:(int)index;
@end
