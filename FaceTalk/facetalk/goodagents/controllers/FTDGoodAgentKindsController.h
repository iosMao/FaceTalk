//
//  FTDGoodAgentKindsController.h
//  FaceTalk
//
//  Created by Mao-MacPro on 15/7/22.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
@interface FTDGoodAgentKindsController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    MPMoviePlayerController *MoviePlayer;
}
@property (strong, nonatomic) IBOutlet UITableView *tableKind;
@property (strong, nonatomic) IBOutlet UIImageView *imgTitle1;
@property (strong, nonatomic) IBOutlet UIImageView *imgTitle2;
@property (strong, nonatomic) IBOutlet UIImageView *imgTitle3;

@end