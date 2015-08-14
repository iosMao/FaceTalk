//
//  FTDDataPacketManager.h
//  FaceTalk
//
//  Created by Mao-MacPro on 15/8/14.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FTDDataPacketManager : NSObject
+ (FTDDataPacketManager *)sharedInstance;
-(void)downloadFile;
@end
