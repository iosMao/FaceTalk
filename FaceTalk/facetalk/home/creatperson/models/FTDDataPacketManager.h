//
//  FTDDataPacketManager.h
//  FaceTalk
//
//  Created by Mao-MacPro on 15/8/14.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FTDDataPacketManager : NSObject

@property (nonatomic,assign) int firstID;

+ (FTDDataPacketManager *)sharedInstance;
-(void)downloadFile;
-(void)removeAllSourceFile;
-(NSString *)unzipDestinationPath;
-(NSString *)basePath;
-(void)upDateJsonFile;
@end
