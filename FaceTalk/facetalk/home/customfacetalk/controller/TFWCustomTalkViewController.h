//
//  TFWCustomTalkViewController.h
//  demo
//
//  Created by wen on 15/7/16.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFDNavViewController.h"
//个性化排序

@interface TFWCustomTalkViewController : UIViewController
@property (nonatomic,strong) NSString *strType;//判断是从侧边栏进来还是从第一次创建的时候进来，这个参数决定了，点击完成设置按钮,第一次进来的话，是进菜单页，不是的话，点击完成，回到原来的界面
@end
