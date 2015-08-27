//
//  TFDNavViewController.h
//  FaceTalk
//
//  Created by Mao-MacPro on 15/7/27.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TFDNavViewController : UINavigationController<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate>
{
    int indexID;//记录左边侧滑栏点击的哪一个
}
@property(nonatomic,strong)UITableView *tableMenu;
@property(nonatomic,strong)UIButton *btnSlider;
@property(nonatomic,strong)UIButton *btnScreen;

@property(nonatomic,strong)UIButton *btnRightMenu;
@property(nonatomic,strong)UIView *viewRightMenu;
@end
