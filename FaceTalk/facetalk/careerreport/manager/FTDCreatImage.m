//
//  FTDCreatImage.m
//  FaceTalk
//
//  Created by Mao-MacPro on 15/8/11.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "FTDCreatImage.h"
#import "WaterFullView.h"
@implementation FTDCreatImage
+(UIImage *)getImage:(WaterFullView *)tableview {
    UIImage* viewImage = nil;
    UIScrollView *scrollView =tableview.scrollView;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(scrollView.contentSize.width, scrollView.contentSize.height), scrollView.opaque=NO, 0.0);
    {
        CGPoint savedContentOffset = scrollView.contentOffset;
        CGRect savedFrame = scrollView.frame;
        
        scrollView.contentOffset = CGPointZero;
        scrollView.frame = CGRectMake(0,300, scrollView.contentSize.width, scrollView.contentSize.height);
        
        [scrollView.layer renderInContext: UIGraphicsGetCurrentContext()];
        viewImage = UIGraphicsGetImageFromCurrentImageContext();
        
        scrollView.contentOffset = savedContentOffset;
        scrollView.frame = savedFrame;
    }
    UIGraphicsEndImageContext();
    
    return viewImage;
}
+(UIImage *)getImage1:(UIView *)theView
{
    CGRect rect = theView.frame;
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [theView.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}


@end
