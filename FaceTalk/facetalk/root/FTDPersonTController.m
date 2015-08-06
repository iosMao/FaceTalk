//
//  FTDPersonTController.m
//  FaceTalk
//
//  Created by Mao-MacPro on 15/8/5.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "FTDPersonTController.h"
#import "FTDCollectionPhotoCell.h"
#import "FTDbackgroundView.h"
#import "FTDBigImageView.h"
#define KCellID @"CollectionCell"

#define remove_sp(a) [[NSUserDefaults standardUserDefaults] removeObjectForKey:a]
#define get_sp(a) [[NSUserDefaults standardUserDefaults] objectForKey:a]
#define get_Dsp(a) [[NSUserDefaults standardUserDefaults]dictionaryForKey:a]
#define set_sp(a,b) [[NSUserDefaults standardUserDefaults] setObject:b forKey:a]
@interface FTDPersonTController ()<UIActionSheetDelegate,FTDBigImageViewDeledate>
{
    UIActionSheet  *_actionSheet;
    FTDBigImageView *bigImageView;
    FTDbackgroundView *backgroundView;
}
@end

@implementation FTDPersonTController
@synthesize collectionPhoto;
- (void)viewDidLoad {
    [super viewDidLoad];
    indexId=10000;
    
    [collectionPhoto registerClass:[FTDCollectionPhotoCell class] forCellWithReuseIdentifier:KCellID];
    
    backgroundView= [[FTDbackgroundView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:backgroundView];
    bigImageView=[[FTDBigImageView alloc]initWithFrame:CGRectMake(100, 100, self.view.frame.size.width-200, self.view.frame.size.height-200)];
    bigImageView.delegate=self;
    
    [self.view addSubview:bigImageView];
    backgroundView.hidden=YES;
    bigImageView.hidden=YES;
    arrayPhoto=[[NSMutableArray alloc]init];
    arrayDesc=[[NSMutableArray alloc]init];
    
    for (int i; i<100; i++) {
        [arrayDesc addObject:@""];
    }
    if (get_sp(@"FTDPhoto")!=nil) {
        arrayPhoto=[NSMutableArray arrayWithArray:get_sp(@"FTDPhoto")];
    }
    if (get_sp(@"FTDDesc")!=nil) {
        arrayDesc=[NSMutableArray arrayWithArray:get_sp(@"FTDDesc")];
    }
    // Do any additional setup after loading the view from its nib.
}
-(void)hiddenImageView
{

    [UIView animateWithDuration:0.6 animations:^{
        bigImageView.hidden=YES;
        backgroundView.hidden=YES;
    }];
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
    
    [cell.textDesc addTarget:self action:@selector(textchange:) forControlEvents:UIControlEventEditingChanged];
    cell.textDesc.enabled=NO;
    
    // 图片的名称
    if (indexId==indexPath.row) {
        cell.viewEdit.hidden=NO;
    }
    else{
        cell.viewEdit.hidden=YES;
    }
    cell.imgPhoto.contentMode=UIViewContentModeScaleAspectFill;
    cell.imgPhoto.clipsToBounds=YES;//设置为UIViewContentModeScaleAspectFill图片溢出，设为yes就好了
    
    if (indexPath.row==arrayPhoto.count) {
        cell.btnG.hidden=YES;
        cell.textDesc.hidden=YES;
        cell.imgPhoto.image=[UIImage imageNamed:@"FTD_personalteam_add.png"];
        
    }else{
        cell.btnG.hidden=NO;
        cell.textDesc.hidden=NO;
        cell.imgPhoto.image=[UIImage imageWithData: [arrayPhoto objectAtIndex:indexPath.row]];
        if (arrayDesc.count>0) {
            cell.textDesc.text=[arrayDesc objectAtIndex:indexPath.row];
        }
        
    }
    
     
    
    
    
    
    return cell;
    
    
    
}
 
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexId==indexPath.row) {
        indexId=10000;
        [collectionPhoto reloadData];
    }
     else if (indexPath.row==arrayPhoto.count) {
 
        _actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"打开图库",@"拍照",nil];
        [_actionSheet showInView:self.view];
    }
    else{
        UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
        
        backgroundView.hidden=NO;
        bigImageView.imgBig.image=[UIImage imageWithData:[arrayPhoto objectAtIndex:indexPath.row]];
        bigImageView.lblDesc.text=[arrayDesc objectAtIndex:indexPath.row];
        bigImageView.hidden=NO;
        bigImageView.center = cell.center;
        CGAffineTransform transform = bigImageView.transform;
        bigImageView.transform = CGAffineTransformScale(transform, 0.2, 0.2);
        [UIView animateWithDuration:0.8 animations:^{
            bigImageView.transform = CGAffineTransformScale(transform, 1.0, 1.0);
            bigImageView.center = self.view.center;
        }];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    
    [_actionSheet removeFromSuperview];
    _actionSheet = nil;
    
    if (buttonIndex==0||buttonIndex==1) {
        UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        
        if (buttonIndex==0) {
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            imagePicker.allowsEditing=NO;
            
            
            
            
            UIPopoverController *pop=[[UIPopoverController alloc]initWithContentViewController:imagePicker];
            [pop presentPopoverFromRect:CGRectMake(self.view.frame.size.width/2-100, self.view.frame.size.height-100, 300,300) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
        }
        else{
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePicker.allowsEditing=NO;
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
//        switch (buttonIndex) {
//            case 0:
//                imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//                break;
//            case 1:
//                
//            default:
//                break;
//        }
        
        

    }
    
    
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *photoImage = [info objectForKey:UIImagePickerControllerOriginalImage];
     NSData *imageData = UIImagePNGRepresentation(photoImage);
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
//    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"imagecache"]];
//    
//    imageData writeToFile:<#(NSString *)#> atomically:<#(BOOL)#>
    if (indexId!=10000) {
        [arrayPhoto replaceObjectAtIndex:indexId withObject:imageData];
    }
    else{
        [arrayPhoto addObject:imageData];
    }
    set_sp(@"FTDPhoto",arrayPhoto);
    indexId=10000;
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
-(void)editPhotoclick:(UIButton *)sender
{
    FTDCollectionPhotoCell *cell= (FTDCollectionPhotoCell *)[[[sender superview] superview]superview];
    NSIndexPath *indexPath=[collectionPhoto indexPathForCell:cell];
    NSLog(@"%ld",(long)indexPath.row);
    indexId=indexPath.row;
    _actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"打开图库",@"拍照",nil];
    [_actionSheet showInView:self.view];
    
}
-(void)delPhotoclick:(UIButton *)sender
{
    FTDCollectionPhotoCell *cell= (FTDCollectionPhotoCell *)[[[sender superview] superview]superview];
    NSIndexPath *indexPath=[collectionPhoto indexPathForCell:cell];
    NSLog(@"%ld",(long)indexPath.row);
    [arrayPhoto removeObjectAtIndex:indexPath.row];
    set_sp(@"FTDPhoto",arrayPhoto);
    indexId=10000;
    [collectionPhoto reloadData];
}

-(void)editDescclick:(UIButton *)sender
{
    FTDCollectionPhotoCell *cell= (FTDCollectionPhotoCell *)[[[sender superview] superview]superview];
    NSIndexPath *indexPath=[collectionPhoto indexPathForCell:cell];
    NSLog(@"%ld",(long)indexPath.row);
    cell.textDesc.enabled=YES;
    [cell.textDesc becomeFirstResponder];
    
}





-(void)textchange:(UITextField *)textfield
{

    [arrayDesc replaceObjectAtIndex:indexId withObject:textfield.text];
    set_sp(@"FTDDesc",arrayDesc);
    
    
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

- (IBAction)backclick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
