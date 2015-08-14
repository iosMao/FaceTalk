//
//  FTDbackgroundView.h
//  FaceTalk
//
//  Created by Mao-MacPro on 15/7/21.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FTDbackgroundView <NSObject>

- (void)downkeyboard;
 
@end
@interface FTDbackgroundView : UIView
@property(nonatomic, weak)id<FTDbackgroundView> delegate;
@end
