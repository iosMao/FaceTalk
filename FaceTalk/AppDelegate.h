//
//  AppDelegate.h
//  FaceTalk
//
//  Created by wen on 15/7/8.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FTDDataProvider.h"
#import "FTDLoginLockController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,strong) FTDDataProvider *dataProvider;
@property (nonatomic,strong) UIView *backgroundView;
@property (nonatomic,strong) NSDate *beginDate;
@property (nonatomic,strong) NSDate *endDate;
@property (nonatomic,strong) FTDLoginLockController *LoginLockView;

@end

