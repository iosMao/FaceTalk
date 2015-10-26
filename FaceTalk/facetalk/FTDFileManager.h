//
//  FTDFileManager.h
//  FaceTalk
//
//  Created by Mao-MacPro on 15/10/22.
//  Copyright © 2015年 wen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FTDSingleton.h"
@interface FTDFileManager : NSObject
singleton_Interface(FTDFileManager)
@property (nonatomic,assign) int netState;
@end
