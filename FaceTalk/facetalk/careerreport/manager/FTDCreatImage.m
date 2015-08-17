//
//  FTDCreatImage.m
//  FaceTalk
//
//  Created by Mao-MacPro on 15/8/11.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "FTDCreatImage.h"

@implementation FTDCreatImage
+(UIImage *)getImage:(UITableView *)tableview {
    UIImage* viewImage = nil;
    UITableView *scrollView =tableview;
    UIGraphicsBeginImageContextWithOptions(scrollView.contentSize, scrollView.opaque, 0.0);
    {
        CGPoint savedContentOffset = scrollView.contentOffset;
        CGRect savedFrame = scrollView.frame;
        
        scrollView.contentOffset = CGPointZero;
        scrollView.frame = CGRectMake(0, 0, scrollView.contentSize.width, scrollView.contentSize.height);
        
        [scrollView.layer renderInContext: UIGraphicsGetCurrentContext()];
        viewImage = UIGraphicsGetImageFromCurrentImageContext();
        
        scrollView.contentOffset = savedContentOffset;
        scrollView.frame = savedFrame;
    }
    UIGraphicsEndImageContext();
    
    return viewImage;
}

@end
