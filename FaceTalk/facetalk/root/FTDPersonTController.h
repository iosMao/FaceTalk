//
//  FTDPersonTController.h
//  FaceTalk
//
//  Created by Mao-MacPro on 15/8/5.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FTDPersonTController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    int indexId;
    NSMutableArray *arrayPhoto;
     
}
@property (strong, nonatomic) IBOutlet UICollectionView *collectionPhoto;
@property(strong,nonatomic)UIPopoverController *imagePicker;
@end
