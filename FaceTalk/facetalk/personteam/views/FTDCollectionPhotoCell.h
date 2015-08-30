//
//  FTDCollectionPhotoCell.h
//  FaceTalk
//
//  Created by Mao-MacPro on 15/8/5.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FTDCollectionPhotoCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIButton *btnG;
@property (strong, nonatomic) IBOutlet UIImageView *imgPhoto;
@property (strong, nonatomic) IBOutlet UIView *viewEdit;
@property (strong, nonatomic) IBOutlet UIButton *btnEditDesc;
@property (strong, nonatomic) IBOutlet UIButton *btnEditPhoto;
@property (strong, nonatomic) IBOutlet UIButton *btnDelPhoto;
@property (strong, nonatomic) IBOutlet UITextField *textDesc;

@end
