//
//  FTDDataProvider.m
//  FaceTalk
//
//  Created by Mao-MacPro on 15/10/14.
//  Copyright © 2015年 wen. All rights reserved.
//

#import "FTDDataProvider.h"
#import <AFNetworking/AFHTTPRequestOperation.h>
#import <AFNetworking/AFHTTPRequestOperationManager.h>
#define FTD_BASE_URL @"http://imo.tohours.com/attract/isp?"
@implementation FTDDataProvider

-(void)userLogin:(NSDictionary *)infoDic
{
    
    
    
     NSString *urlString = [NSString stringWithFormat:@"%@account=%@&co=%@&password=%@",FTD_BASE_URL,[infoDic objectForKey:@"account"],[infoDic objectForKey:@"co"],[infoDic objectForKey:@"password"]];
     //NSURL *url = [NSURL URLWithString:urlString];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:FTD_BASE_URL parameters:infoDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
       self.resultDict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
        self.finishBlock(self.resultDict);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        self.failedBlock([NSString stringWithFormat:@"%@",error]);
    }];
    
    
    
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSString *html = operation.responseString;
//        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
//        self.resultDict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
//        self.finishBlock(self.resultDict);
//        
//    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        self.failedBlock([NSString stringWithFormat:@"%@",error]);
//        NSLog(@"发生错误！%@",error);
//    }];
//    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//    [queue addOperation:operation];
}




- (void)requestData:(NSURL *)url
{
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        self.resultDict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
        self.finishBlock(self.resultDict);
        NSLog(@"获取到的数据为：%@",self.resultDict);
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        self.failedBlock(@"fail");
        NSLog(@"发生错误！%@",error);
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
}

- (void)dealloc
{
    self.resultDict = nil;
    self.finishBlock = nil;
    self.failedBlock = nil;
}
@end
