//
//  FTDPersonTController.h
//  FaceTalk
//
//  Created by Mao-MacPro on 15/8/5.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import <UIKit/UIKit.h>
 
@interface FTDPersonTController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate>
{
    int indexId;//记录是第几个的id
    NSMutableArray *arrayPhoto;
    NSMutableArray *arrayDesc;
    
}
@property (strong, nonatomic) IBOutlet UICollectionView *collectionPhoto;
@property(strong,nonatomic)UIPopoverController *imagePicker;
- (IBAction)backclick:(id)sender;
@end
