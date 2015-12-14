//
//  FTJsonManager.m
//  test
//
//  Created by wen on 15/8/23.
//  Copyright (c) 2015年 wen. All rights reserved.
//

#import "FTJsonManager.h"
#import "FTDDataPacketManager.h"
#define remove_sp(a) [[NSUserDefaults standardUserDefaults] removeObjectForKey:a]
#define get_sp(a) [[NSUserDefaults standardUserDefaults] objectForKey:a]
#define get_Dsp(a) [[NSUserDefaults standardUserDefaults]dictionaryForKey:a]
#define set_sp(a,b) [[NSUserDefaults standardUserDefaults] setObject:b forKey:a]

static FTJsonManager *shareManager;

@interface FTJsonManager ()

@property (nonatomic,strong) NSDictionary *jsonDic;
@property (nonatomic,readonly) NSArray *excellence;

@end

@implementation FTJsonManager

+(FTJsonManager *)shareManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager = [[FTJsonManager alloc] init];
        [shareManager initData];
    });
    
    return shareManager;
}

-(void)initData
{
    NSString *file1=[[FTDDataPacketManager sharedInstance]unzipDestinationPath];
    
    file1 =[file1 stringByAppendingPathComponent:@"uploads"];
    file1 =[file1 stringByAppendingPathComponent:@"data.json"];
    
    
    
     //NSString *file = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
    
    NSData *data=[NSData dataWithContentsOfFile:file1];
    _jsonDic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    //_jsonDic = [string objectFromJSONString];
    
    _lastUpdatePicDate = [_jsonDic objectForKey:@"version"];
    
    
    _ten_objective_elements = [_jsonDic objectForKey:@"ten_objective_elements"];
    _ten_aia_elements       = [_jsonDic objectForKey:@"ten_aia_elements"];
    _index_background       = [_jsonDic objectForKey:@"index_background"];
    _guide_page             = [_jsonDic objectForKey:@"guide_page"];
    _excellence             = [_jsonDic objectForKey:@"excellence"];
    
    //[self setAIAElements];
    [self setTenObjectiveElements];
    [self setbackGround];
    [self setGuidePage];
    [self setExcellence];
    
    NSLog(@"%@",shareManager);
}

-(void)setAIAElements
{
    NSArray *array = _ten_aia_elements;
    NSMutableArray *mutArray = [NSMutableArray new];
    for (NSDictionary *dict in array) {
        FTJsonElementModel *model = [FTJsonElementModel new];
        model.name = [dict objectForKey:@"name"];
        model.content = [NSString stringWithFormat:@"%@%@",[self basePath],[dict objectForKey:@"content"]];
        [mutArray addObject:model];
    }
    
    _ten_aia_elements = [NSArray arrayWithArray:mutArray];
}

-(void)setTenObjectiveElements
{
    NSArray *array = _ten_objective_elements;
    NSMutableArray *mutArray = [NSMutableArray new];
    for (NSString *str in array) {
        [mutArray addObject: [NSString stringWithFormat:@"%@%@",[self basePath],str]];
    }
    
    _ten_objective_elements = [NSArray arrayWithArray:mutArray];
}

-(void)setbackGround
{
    _index_background = [NSString stringWithFormat:@"%@%@",[self basePath],_index_background];
}

-(void)setGuidePage
{
    NSArray *array = _guide_page;
    NSMutableArray *mutArray = [NSMutableArray new];
    for (NSString *str in array) {
        [mutArray addObject: [NSString stringWithFormat:@"%@%@",[self basePath],str]];
    }
    
    _guide_page = [NSArray arrayWithArray:mutArray];
}

-(void)setExcellence
{
    NSArray *array = _excellence;
    NSMutableArray *mutArray = [NSMutableArray new];
    
    for (NSDictionary *dict in array) {
        FTJsonExcellentModel *model = [FTJsonExcellentModel new];
        model.name = [dict objectForKey:@"name"];
        model.index = [NSString stringWithFormat:@"%@%@",[self basePath],[[dict objectForKey:@"index"] objectForKey:@"video"]];
        model.subClassArray = [dict objectForKey:@"sub_class"];
        [mutArray addObject:model];
    }
    _excellence_count = (int)_excellence.count;
    _excellence = [NSArray arrayWithArray:mutArray];
}

-(FTJsonExcellentModel *)getElementItemAtIndex:(int)index
{
    
    if (index >= _excellence_count) {
        return nil;
    }
    _excellence_index = index;
    return [_excellence objectAtIndex:index];
}

-(NSString *)basePath
{
    NSString *file1=[[FTDDataPacketManager sharedInstance]basePath];
    return file1;
}

@end
