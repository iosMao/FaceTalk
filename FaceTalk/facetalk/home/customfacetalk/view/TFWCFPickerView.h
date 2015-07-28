//
//  TFWPickerView.h
//  test
//
//  Created by wen on 15/7/16.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TFWCFPickerView : UIView <UIPickerViewDataSource,UIPickerViewDelegate>

-(NSArray *)getCurrentSelected;

@end
