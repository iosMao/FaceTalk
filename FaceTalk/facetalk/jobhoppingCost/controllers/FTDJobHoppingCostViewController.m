//
//  FTDJobHoppingCostViewController.m
//  FaceTalk
//
//  Created by Mao-MacPro on 15/10/16.
//  Copyright © 2015年 wen. All rights reserved.
//

#import "FTDJobHoppingCostViewController.h"
#import "RingCircle.h"
#import "RingModel.h"
#import "TFDNavViewController.h"
@interface FTDJobHoppingCostViewController ()
{
    NSMutableArray *arrayModel;
    
}
- (IBAction)backclick:(id)sender;

@property (strong, nonatomic)RingCircle *viewCircle;

@property (strong, nonatomic) IBOutlet UIView *view1;
@property (strong, nonatomic) IBOutlet UIView *view2;
@property (strong, nonatomic) IBOutlet UIView *view3;
@property (strong, nonatomic) IBOutlet UIView *view4;
@property (strong, nonatomic) IBOutlet UIView *view5;
@property (strong, nonatomic) IBOutlet UIView *view6;
@property (strong, nonatomic) IBOutlet UIView *view7;
@property (strong, nonatomic) IBOutlet UIView *view8;
@property (strong, nonatomic) IBOutlet UIView *view9;

@property (strong, nonatomic) IBOutlet UITextField *textPublicCareer;
@property (strong, nonatomic) IBOutlet UITextField *textRant;
@property (strong, nonatomic) IBOutlet UITextField *textCarTraffic;
@property (strong, nonatomic) IBOutlet UITextField *textPlay;
@property (strong, nonatomic) IBOutlet UITextField *textClothes;
@property (strong, nonatomic) IBOutlet UITextField *textEatDrink;
@property (strong, nonatomic) IBOutlet UITextField *textParents;
@property (strong, nonatomic) IBOutlet UITextField *textChildrenLearm;
@property (strong, nonatomic) IBOutlet UITextField *textOtherPay;
@end

@implementation FTDJobHoppingCostViewController
@synthesize textCarTraffic,textChildrenLearm,textClothes,textEatDrink,textOtherPay,textParents,textPlay,textPublicCareer,textRant;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildViewRound];
    
    [textPublicCareer addTarget:self action:@selector(textPublicCareerchange:) forControlEvents:UIControlEventEditingChanged];
    [textRant addTarget:self action:@selector(textRantchange:) forControlEvents:UIControlEventEditingChanged];
    [textCarTraffic addTarget:self action:@selector(textCarTrafficchange:) forControlEvents:UIControlEventEditingChanged];
    [textPlay addTarget:self action:@selector(textPlaychange:) forControlEvents:UIControlEventEditingChanged];
    [textClothes addTarget:self action:@selector(textClotheschange:) forControlEvents:UIControlEventEditingChanged];
    [textEatDrink addTarget:self action:@selector(textEatDrinkchange:) forControlEvents:UIControlEventEditingChanged];
    [textParents addTarget:self action:@selector(textParentschange:) forControlEvents:UIControlEventEditingChanged];
    [textChildrenLearm addTarget:self action:@selector(textChildrenLearmchange:) forControlEvents:UIControlEventEditingChanged];
    [textOtherPay addTarget:self action:@selector(textOtherPaychange:) forControlEvents:UIControlEventEditingChanged];
    
    
    
     _viewCircle = [RingCircle createRingWithCenter:CGPointMake(1024/2+300, 768/2) radius:100 width:30];
    [self.view addSubview:_viewCircle];
    [self creatModel];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    TFDNavViewController *nav = (TFDNavViewController *)self.navigationController;
    nav.btnSlider.hidden = NO;
    nav.btnRightMenu.hidden = YES;
    
}
-(void)buildViewRound
{
    [_view1.layer setMasksToBounds:YES];
    [_view1.layer setCornerRadius:3];
    
    [_view2.layer setMasksToBounds:YES];
    [_view2.layer setCornerRadius:3];
    
    [_view3.layer setMasksToBounds:YES];
    [_view3.layer setCornerRadius:3];
    
    [_view4.layer setMasksToBounds:YES];
    [_view4.layer setCornerRadius:3];
    
    [_view5.layer setMasksToBounds:YES];
    [_view5.layer setCornerRadius:3];
    
    [_view6.layer setMasksToBounds:YES];
    [_view6.layer setCornerRadius:3];
    
    [_view7.layer setMasksToBounds:YES];
    [_view7.layer setCornerRadius:3];
    
    [_view8.layer setMasksToBounds:YES];
    [_view8.layer setCornerRadius:3];
    
    [_view9.layer setMasksToBounds:YES];
    [_view9.layer setCornerRadius:3];
}
-(void)creatModel
{
    arrayModel = [[NSMutableArray alloc] init];
    
    RingModel *model1 =[[RingModel alloc]init];
    model1.color = [UIColor colorWithRed:0.27 green:0.83 blue:0.74 alpha:1];
    model1.title = @"";
    model1.score = 0;
    [arrayModel addObject:model1];
    
    RingModel *model2 = [[RingModel alloc]init] ;
    model2.color = [UIColor colorWithRed:0.09 green:0.55 blue:0.79 alpha:1];
    model2.title = @"";
    model2.score = 0;
    [arrayModel addObject:model2];
    
    RingModel *model3 = [[RingModel alloc]init] ;
    model3.color = [UIColor colorWithRed:0.13 green:0.66 blue:0.85 alpha:1];
    model3.title = @"";
    model3.score = 0;
    [arrayModel addObject:model3];
    
    RingModel *model4 = [[RingModel alloc]init] ;
    model4.color = [UIColor colorWithRed:0.6 green:0.38 blue:0.82 alpha:1];
    model4.title = @"";
    model4.score = 0;
    [arrayModel addObject:model4];
    
    RingModel *model5 = [[RingModel alloc]init] ;
    model5.color = [UIColor colorWithRed:0.95 green:0.39 blue:0.54 alpha:1];
    model5.title = @"";
    model5.score = 0;
    [arrayModel addObject:model5];
    
    RingModel *model6 = [[RingModel alloc]init] ;
    model6.color = [UIColor colorWithRed:0.98 green:0.75 blue:0.34 alpha:1];
    model6.title = @"";
    model6.score = 0;
    [arrayModel addObject:model6];
    
    RingModel *model7 = [[RingModel alloc]init] ;
    model7.color = [UIColor colorWithRed:0.59 green:0.79 blue:0.36 alpha:1];
    model7.title = @"";
    model7.score = 0;
    [arrayModel addObject:model7];
    
    RingModel *model8 = [[RingModel alloc]init] ;
    model8.color = [UIColor colorWithRed:0.34 green:0.9 blue:0.9 alpha:1];
    model8.title = @"";
    model8.score = 0;
    [arrayModel addObject:model8];
    
    RingModel *model9 = [[RingModel alloc]init] ;
    model9.color = [UIColor colorWithRed:0.96 green:0.97 blue:0.98 alpha:1];
    model9.title = @"";
    model9.score = 0;
    [arrayModel addObject:model9];
}

-(void)textPublicCareerchange:(UITextField *)textfild
{
    RingModel *model = [arrayModel objectAtIndex:0];
    model.score= [textfild.text floatValue];
    if (textfild.text.length > 0) {
        model.title = @"公共事业";
    }
    else{
        model.title = @"";
    }
    
    [arrayModel replaceObjectAtIndex:0 withObject:model];
    
    [_viewCircle setDataArray:arrayModel];
    
}

-(void)textRantchange:(UITextField *)textfild
{
    RingModel *model = [arrayModel objectAtIndex:1];
    model.score= [textfild.text floatValue];
    if (textfild.text.length > 0) {
        model.title = @"房租或按揭";
    }
    else{
        model.title = @"";
    }
    
    [arrayModel replaceObjectAtIndex:1 withObject:model];
    
    [_viewCircle setDataArray:arrayModel];
    
}

-(void)textCarTrafficchange:(UITextField *)textfild
{
    RingModel *model = [arrayModel objectAtIndex:2];
    model.score= [textfild.text floatValue];
    if (textfild.text.length > 0) {
        model.title = @"行车交通";
    }
    else{
        model.title = @"";
    }
    
    [arrayModel replaceObjectAtIndex:2 withObject:model];
    
    [_viewCircle setDataArray:arrayModel];
    
}
-(void)textPlaychange:(UITextField *)textfild
{
    RingModel *model = [arrayModel objectAtIndex:3];
    model.score= [textfild.text floatValue];
    if (textfild.text.length > 0) {
        model.title = @"休闲娱乐";
    }
    else{
        model.title = @"";
    }
    
    [arrayModel replaceObjectAtIndex:3 withObject:model];
    
    [_viewCircle setDataArray:arrayModel];
    
}
-(void)textClotheschange:(UITextField *)textfild
{
    RingModel *model = [arrayModel objectAtIndex:4];
    model.score= [textfild.text floatValue];
    if (textfild.text.length > 0) {
        model.title = @"衣服饰品";
    }
    else{
        model.title = @"";
    }
    
    [arrayModel replaceObjectAtIndex:4 withObject:model];
    
    [_viewCircle setDataArray:arrayModel];
    
}
-(void)textEatDrinkchange:(UITextField *)textfild
{
    RingModel *model = [arrayModel objectAtIndex:5];
    model.score= [textfild.text floatValue];
    if (textfild.text.length > 0) {
        model.title = @"食品酒水";
    }
    else{
        model.title = @"";
    }
    
    [arrayModel replaceObjectAtIndex:5 withObject:model];
    
    [_viewCircle setDataArray:arrayModel];
    
}
-(void)textParentschange:(UITextField *)textfild
{
    RingModel *model = [arrayModel objectAtIndex:6];
    model.score= [textfild.text floatValue];
    if (textfild.text.length > 0) {
        model.title = @"孝敬家长";
    }
    else{
        model.title = @"";
    }
    
    [arrayModel replaceObjectAtIndex:6 withObject:model];
    
    [_viewCircle setDataArray:arrayModel];
    
}
-(void)textChildrenLearmchange:(UITextField *)textfild
{
    RingModel *model = [arrayModel objectAtIndex:7];
    model.score= [textfild.text floatValue];
    if (textfild.text.length > 0) {
         model.title = @"子女教育";
    }
    else{
        model.title = @"";
    }
   
    [arrayModel replaceObjectAtIndex:7 withObject:model];
    
    [_viewCircle setDataArray:arrayModel];
    
}
-(void)textOtherPaychange:(UITextField *)textfild
{
    RingModel *model = [arrayModel objectAtIndex:8];
    model.score= [textfild.text floatValue];
    if (textfild.text.length > 0) {
        model.title = @"其他开支";
    }
    else{
        model.title = @"";
    }
    
    [arrayModel replaceObjectAtIndex:8 withObject:model];
    
    [_viewCircle setDataArray:arrayModel];
    
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
    [self.navigationController popViewControllerAnimated:YES];
}
@end
