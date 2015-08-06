//
//  FTDPersonTController.m
//  FaceTalk
//
//  Created by Mao-MacPro on 15/8/5.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "FTDPersonTController.h"
#import "FTDCollectionPhotoCell.h"
#define KCellID @"CollectionCell"

@interface FTDPersonTController ()
{
    
}
@end

@implementation FTDPersonTController
@synthesize collectionPhoto;
- (void)viewDidLoad {
    [super viewDidLoad];
    indexId=10000;
    
    [collectionPhoto registerClass:[FTDCollectionPhotoCell class] forCellWithReuseIdentifier:KCellID];
    
    
    arrayPhoto=[[NSMutableArray alloc]init];
    // Do any additional setup after loading the view from its nib.
}


#pragma collectionViewdelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section

{
    
    // 每个Section的item个数
    
    return arrayPhoto.count+1;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath

{
    
    
    
    FTDCollectionPhotoCell *cell = (FTDCollectionPhotoCell *)[collectionView dequeueReusableCellWithReuseIdentifier:KCellID forIndexPath:indexPath];
    
    [cell.btnDelPhoto addTarget:self action:@selector(delPhotoclick:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.btnEditDesc addTarget:self action:@selector(editDescclick:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.btnEditPhoto addTarget:self action:@selector(editPhotoclick:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.btnG addTarget:self action:@selector(editclick:) forControlEvents:UIControlEventTouchUpInside];
    // 图片的名称
    if (indexId==indexPath.row) {
        cell.viewEdit.hidden=NO;
    }
    else{
        cell.viewEdit.hidden=YES;
    }
    if (indexPath.row==arrayPhoto.count) {
        cell.btnG.hidden=YES;
        cell.imgPhoto.image=[UIImage imageNamed:@"FTD_personalteam_add.png"];
        
    }else{
        cell.btnG.hidden=NO;
        cell.imgPhoto.image=[arrayPhoto objectAtIndex:indexPath.row];
    }
    
     
    
    
    
    
    return cell;
    
    
    
}
 
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIImagePickerController * imagePickerController = [[UIImagePickerController alloc] init];
//    imagePickerController.delegate = self;
//    imagePickerController.allowsEditing = YES;
//    [imagePickerController shouldAutorotate];
//    [imagePickerController supportedInterfaceOrientations];
    imagePickerController.delegate = self;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    // 编辑模式
    imagePickerController.allowsEditing=YES;
    UIPopoverController *pop=[[UIPopoverController alloc]initWithContentViewController:imagePickerController];
    //    [self presentViewController:imagePicker animated:YES completion:NULL];
    [pop presentPopoverFromRect:CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height-100, 300,300) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
//    UIActionSheet *actionSheet = [[UIActionSheet alloc]
//                                  initWithTitle:nil
//                                  delegate:self
//                                  cancelButtonTitle:@"取消"
//                                  destructiveButtonTitle:nil
//                                  otherButtonTitles:@"打开图库", @"拍照",nil];
//    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
//    [ actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSInteger sourceType;
    
    
    if (buttonIndex == 2)
        return ;
    
    switch (buttonIndex) {
        case 0:
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
        case 1:
            sourceType = UIImagePickerControllerSourceTypeCamera;
        default:
            break;
    }
    
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *photoImage = [info objectForKey:UIImagePickerControllerEditedImage];
    //NSData *imageData = UIImageJPEGRepresentation(photoImage,0.05);
    
    [arrayPhoto addObject:photoImage];
    [collectionPhoto reloadData];
    // 如果是相机拍照的，保存在本地
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera)
    {
        UIImageWriteToSavedPhotosAlbum(photoImage, nil, nil, nil);
    }
}

-(void)editclick:(UIButton *)sender
{
    FTDCollectionPhotoCell *cell= (FTDCollectionPhotoCell *)[[sender superview] superview];
    NSIndexPath *indexPath=[collectionPhoto indexPathForCell:cell];
    NSLog(@"%ld",(long)indexPath.row);
    indexId=indexPath.row;
    [collectionPhoto reloadData];
}

-(void)delPhotoclick:(UIButton *)sender
{
    
}

-(void)editDescclick:(UIButton *)sender
{
    
}
-(void)editPhotoclick:(UIButton *)sender
{
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
