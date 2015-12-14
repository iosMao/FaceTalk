//
//  FTDRevenueTrialDetailViewController.m
//  FaceTalk
//
//  Created by Mao-MacPro on 15/11/18.
//  Copyright © 2015年 wen. All rights reserved.
//

#import "FTDRevenueTrialDetailViewController.h"
#import "TFWHelpResultMenuView.h"
#import "FTDChangePrice.h"
#import "FTDCustomCalculationViewController.h"
#define  price1 3000
#define  price2 8000
#define  price3 15225
@interface FTDRevenueTrialDetailViewController ()
@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblRMB1;
@property (strong, nonatomic) IBOutlet UILabel *lblRMB2;
@property (strong, nonatomic) IBOutlet UILabel *lblRMB3;
@property (strong, nonatomic) IBOutlet UILabel *lblRMB4;
@property (strong, nonatomic) IBOutlet UILabel *lblRMB5;
@property (strong, nonatomic) IBOutlet UILabel *lblRMB6;
@property (strong, nonatomic) IBOutlet UILabel *lblRMB7;
@property (strong, nonatomic) IBOutlet UILabel *lblRMB8;
@property (strong, nonatomic) IBOutlet UILabel *lblRMB9;
@property (strong, nonatomic) IBOutlet UILabel *lblRMB10;

@property (assign, nonatomic)int price;

@property (strong, nonatomic) IBOutlet UILabel *lblbeizhu;
@property (strong, nonatomic) TFWHelpResultMenuView *leftMenu;
- (IBAction)backAction:(id)sender;
@property (strong, nonatomic) IBOutlet UISegmentedControl *btnSegmentCol;
- (IBAction)segmentAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *imgChart;
@property (strong, nonatomic) IBOutlet UILabel *lblPrice;
@property (strong, nonatomic) IBOutlet UIButton *btnSlider;
@property (strong, nonatomic) IBOutlet UILabel *lbl1;
@property (strong, nonatomic) IBOutlet UILabel *lbl2;
@property (strong, nonatomic) IBOutlet UILabel *lbl3;
@property (strong, nonatomic) IBOutlet UIView *viewZuzhiInfo;
@property (strong, nonatomic) IBOutlet UIView *viewRed;
- (IBAction)IWantAction:(id)sender;
 
@end

@implementation FTDRevenueTrialDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildLeftMenu];
    
    
    [self changeTitle];
    self.price = 0;
    [self changeLblText:self.price];
    
    [self.lblPrice.layer setCornerRadius:3];
    [self.lblPrice.layer setMasksToBounds:YES];
    [self.btnSlider  addTarget:self action:@selector(AdragMoving:withEvent: ) forControlEvents:UIControlEventTouchDragInside];
    [self.btnSlider addTarget:self action:@selector(AdragEnded:withEvent: )forControlEvents: UIControlEventTouchUpInside |
     UIControlEventTouchUpOutside];
    self.viewZuzhiInfo.hidden = YES;
    [self segmentAction:self.btnSegmentCol];
    // Do any additional setup after loading the view from its nib.
}
- (void)buildLeftMenu
{
    _leftMenu = [TFWHelpResultMenuView  createMenuwithArray:@[@"菁英标准", @"金领标准", @"MDRT标准"] andBottom:CGPointMake(76, 745) andHightBtnIndex:self.indexID];
    
    __weak FTDRevenueTrialDetailViewController *weakSelf = self;
    [_leftMenu setResultMenuTapBlock:^(NSInteger index){
        [weakSelf menuClickAction:index];
    }];
    [self.view addSubview:_leftMenu];
}


-(void)changeTitle
{
    switch (self.indexID) {
        case 0:
            self.lblTitle.text = @"菁英标准";
            break;
        case 1:
            self.lblTitle.text = @"金领标准";
            break;
        case 2:
            self.lblTitle.text = @"MDRT标准";
            break;
            
        default:
            break;
    }
}

-(void)chartValue:(NSInteger)segmentid
{
    if (self.indexID == 0) {
        self.lblbeizhu.text = @"备注：以上收入演示，个人销售收入基于达成菁英级别最高新人津贴FYC条件，组织收入基于每年如期晋级且达成标准组绩效。该收入数据不做保证，仅供演示参考。";
        if (segmentid == 0) {
            self.imgChart.image = [UIImage imageNamed:@"ftdjy1.png"];
            _lblRMB1.text = @"RMB 89,940";
            _lblRMB2.text = @"RMB 66,294";
            _lblRMB3.text = @"RMB 79,643";
            _lblRMB4.text = @"RMB 94,328";
            _lblRMB5.text = @"RMB 110,481";
            _lblRMB6.text = @"RMB 121,529";
            _lblRMB7.text = @"RMB 138,592";
            _lblRMB8.text = @"RMB 152,451";
            _lblRMB9.text = @"RMB 174,487";
            _lblRMB10.text = @"RMB 193,804";
            
            _lblRMB1.frame = CGRectMake(139, 338, 70, 38);
            _lblRMB2.frame = CGRectMake(224, 328, 70, 38);
            _lblRMB3.frame = CGRectMake(311, 317, 70, 38);
            _lblRMB4.frame = CGRectMake(392, 307, 70, 38);
            _lblRMB5.frame = CGRectMake(473, 296, 70, 38);
            _lblRMB6.frame = CGRectMake(559, 286, 70, 38);
            _lblRMB7.frame = CGRectMake(640, 267, 70, 38);
            _lblRMB8.frame = CGRectMake(718, 227, 70, 38);
            _lblRMB9.frame = CGRectMake(795, 190, 70, 38);
            _lblRMB10.frame = CGRectMake(873, 105, 70, 38);
            
            
        }
        else{
            self.imgChart.image = [UIImage imageNamed:@"ftdjy2.png"];
            _lblRMB1.text = @"RMB 89,940";
            _lblRMB2.text = @"RMB 338,897";
            _lblRMB3.text = @"RMB 409,197";
            _lblRMB4.text = @"RMB 566,764";
            _lblRMB5.text = @"RMB 603,952";
            _lblRMB6.text = @"RMB 606,471";
            _lblRMB7.text = @"RMB 877,051";
            _lblRMB8.text = @"RMB 976,123";
            _lblRMB9.text = @"RMB 1,174,677";
            _lblRMB10.text = @"RMB 1,461,188";
            
            _lblRMB1.frame = CGRectMake(139, 338, 70, 38);
            _lblRMB2.frame = CGRectMake(224, 328, 70, 38);
            _lblRMB3.frame = CGRectMake(311, 317, 70, 38);
            _lblRMB4.frame = CGRectMake(392, 296, 70, 38);
            _lblRMB5.frame = CGRectMake(474, 280, 70, 38);
            _lblRMB6.frame = CGRectMake(559, 259, 70, 38);
            _lblRMB7.frame = CGRectMake(640, 221, 70, 38);
            _lblRMB8.frame = CGRectMake(718, 161, 70, 38);
            _lblRMB9.frame = CGRectMake(795, 126, 70, 38);
            _lblRMB10.frame = CGRectMake(873, 80, 70, 38);
            
            
            
            
        }
        
    }
    else if (self.indexID == 1)
    {
         self.lblbeizhu.text = @"备注：以上收入演示，个人销售收入基于达成金领级别最高新人津贴FYC条件，组织收入基于每年如期晋级且达成标准组绩效。该收入数据不做保证，仅供演示参考。";
        if (segmentid == 0) {
            self.imgChart.image = [UIImage imageNamed:@"ftdjl1.png"];
            _lblRMB1.text = @"RMB 233,904";
            _lblRMB2.text = @"RMB 246,854";
            _lblRMB3.text = @"RMB 236,660";
            _lblRMB4.text = @"RMB 278,246";
            _lblRMB5.text = @"RMB 323,990";
            _lblRMB6.text = @"RMB 363,192";
            _lblRMB7.text = @"RMB 401,382";
            _lblRMB8.text = @"RMB 443,578";
            _lblRMB9.text = @"RMB 487,936";
            _lblRMB10.text = @"RMB 546,690";
            
            _lblRMB1.frame = CGRectMake(139, 338, 70, 38);
            _lblRMB2.frame = CGRectMake(224, 328, 70, 38);
            _lblRMB3.frame = CGRectMake(311, 317, 70, 38);
            _lblRMB4.frame = CGRectMake(392, 307, 70, 38);
            _lblRMB5.frame = CGRectMake(473, 296, 70, 38);
            _lblRMB6.frame = CGRectMake(559, 286, 70, 38);
            _lblRMB7.frame = CGRectMake(640, 267, 70, 38);
            _lblRMB8.frame = CGRectMake(718, 227, 70, 38);
            _lblRMB9.frame = CGRectMake(795, 190, 70, 38);
            _lblRMB10.frame = CGRectMake(873, 105, 70, 38);
        }
        else{
            self.imgChart.image = [UIImage imageNamed:@"ftdjl2.png"];
            _lblRMB1.text = @"RMB 219,120";
            _lblRMB2.text = @"RMB 514,115";
            _lblRMB3.text = @"RMB 561,337";
            _lblRMB4.text = @"RMB 746,318";
            _lblRMB5.text = @"RMB 813,662";
            _lblRMB6.text = @"RMB 837,151";
            _lblRMB7.text = @"RMB 1,135,223";
            _lblRMB8.text = @"RMB 1,287,535";
            _lblRMB9.text = @"RMB 1,502,174";
            _lblRMB10.text = @"RMB 1,822,849";
            
            _lblRMB1.frame = CGRectMake(139, 338, 70, 38);
            _lblRMB2.frame = CGRectMake(224, 328, 70, 38);
            _lblRMB3.frame = CGRectMake(311, 317, 70, 38);
            _lblRMB4.frame = CGRectMake(392, 296, 70, 38);
            _lblRMB5.frame = CGRectMake(474, 280, 70, 38);
            _lblRMB6.frame = CGRectMake(559, 259, 70, 38);
            _lblRMB7.frame = CGRectMake(640, 221, 70, 38);
            _lblRMB8.frame = CGRectMake(718, 161, 70, 38);
            _lblRMB9.frame = CGRectMake(795, 126, 70, 38);
            _lblRMB10.frame = CGRectMake(873, 80, 70, 38);
        }
    }
    else if (self.indexID == 2)
    {
        self.lblbeizhu.text = @"备注：以上收入演示，个人销售收入基于达成MDRT年度FYC条件，组织收入基于每年如期晋级且达成标准组绩效。该收入数据不做保证，仅供演示参考。";
        if (segmentid == 0) {
            self.imgChart.image = [UIImage imageNamed:@"ftdmdrt1.png"];
            _lblRMB1.text = @"RMB 359,059";
            _lblRMB2.text = @"RMB 437,498";
            _lblRMB3.text = @"RMB 464,984";
            _lblRMB4.text = @"RMB 556,286";
            _lblRMB5.text = @"RMB 646,018";
            _lblRMB6.text = @"RMB 710,620";
            _lblRMB7.text = @"RMB 792,363";
            _lblRMB8.text = @"RMB 875,516";
            _lblRMB9.text = @"RMB 963,067";
            _lblRMB10.text = @"RMB 1,059,374";
            
            _lblRMB1.frame = CGRectMake(139, 338, 70, 38);
            _lblRMB2.frame = CGRectMake(224, 328, 70, 38);
            _lblRMB3.frame = CGRectMake(311, 317, 70, 38);
            _lblRMB4.frame = CGRectMake(392, 307, 70, 38);
            _lblRMB5.frame = CGRectMake(473, 296, 70, 38);
            _lblRMB6.frame = CGRectMake(559, 286, 70, 38);
            _lblRMB7.frame = CGRectMake(640, 267, 70, 38);
            _lblRMB8.frame = CGRectMake(718, 227, 70, 38);
            _lblRMB9.frame = CGRectMake(795, 190, 70, 38);
            _lblRMB10.frame = CGRectMake(873, 105, 70, 38);
        }
        else{
            self.imgChart.image = [UIImage imageNamed:@"ftdmdrt2.png"];
            _lblRMB1.text = @"RMB 324,894";
            _lblRMB2.text = @"RMB 710,875";
            _lblRMB3.text = @"RMB 795,403";
            _lblRMB4.text = @"RMB 1,021,419";
            _lblRMB5.text = @"RMB 1,113,902";
            _lblRMB6.text = @"RMB 1,189,415";
            _lblRMB7.text = @"RMB 1,526,707";
            _lblRMB8.text = @"RMB 1,708,101";
            _lblRMB9.text = @"RMB 1,966,486";
            _lblRMB10.text = @"RMB 2,335,637";
            
            _lblRMB1.frame = CGRectMake(139, 338, 70, 38);
            _lblRMB2.frame = CGRectMake(224, 328, 70, 38);
            _lblRMB3.frame = CGRectMake(311, 317, 70, 38);
            _lblRMB4.frame = CGRectMake(392, 296, 70, 38);
            _lblRMB5.frame = CGRectMake(474, 280, 70, 38);
            _lblRMB6.frame = CGRectMake(559, 259, 70, 38);
            _lblRMB7.frame = CGRectMake(640, 221, 70, 38);
            _lblRMB8.frame = CGRectMake(718, 161, 70, 38);
            _lblRMB9.frame = CGRectMake(795, 126, 70, 38);
            _lblRMB10.frame = CGRectMake(873, 80, 70, 38);
            
        }
    }
  
    
    
}





-(void)menuClickAction:(NSInteger)index
{
    self.indexID = index;
    [self segmentAction:self.btnSegmentCol];
    [self changeTitle];
//    self.btnSlider.center = CGPointMake(135, 66);
//    self.lblPrice.center = CGPointMake(135.5, 40);
//    self.lblPrice.text = @"0";
//    self.price = 0;
     [self changeLblText:[FTDChangePrice priceToInt:self.price]];
    //    NSLog(@"index : %ld",(long)index);
}

- (void) AdragMoving: (UIControl *) c withEvent:ev
{
    
    CGPoint point=[[[ev allTouches] anyObject] locationInView:self.viewRed];
    point.y = 66;
    if (point.x < 134 || point.x > 314) {
        return;
    }
    
    c.center =point;
    self.price = (point.x  - 134) / 179 * 20000;
    if (self.price > 20000) {
        self.price = 20000;
    }
    
    self.lblPrice.center =CGPointMake(point.x, 40);
    self.lblPrice.text = [NSString stringWithFormat:@"%d",[FTDChangePrice priceToInt:self.price]];
    [self changeLblText:[FTDChangePrice priceToInt:self.price]];
    //view.center=CGPointMake(point.x, 400-140);
    
}





- (void) AdragEnded: (UIControl *) c withEvent:ev
{
    
    CGPoint point=[[[ev allTouches] anyObject] locationInView:self.viewRed];
    point.y = 66;
    if (point.x < 134 || point.x > 314) {
        return;
    }
    c.center =point;
    int price ;
    
    self.price = (point.x  - 134) / 179 * 20000;
    if (self.price > 20000) {
        self.price = 20000;
    }
    
    self.lblPrice.center =CGPointMake(point.x, 40);
    self.lblPrice.center =CGPointMake(point.x, 40);
    
    //view.center=CGPointMake(point.x, 400-140);
    
}

-(void)changeLblText:(int)price
{
    int firstPrice;
    switch (self.indexID) {
        case 0:
            firstPrice = price1;
            break;
        case 1:
            firstPrice = price2;
            break;
        case 2:
            firstPrice = price3;
            break;
        default:
            break;
    }
    
    float lbl1 = firstPrice / 0.3 / price;
    float lbl2 = lbl1 * 3 / 4;
    float lbl3 = lbl1 * 10 / 22;
    if (price == 0) {
        [self lblresultNum1:0 andNum2:0 andNum3:0];
    }
    else{
        [self lblresultNum1:(int)(lbl3+1) andNum2:(int)(lbl2 + 1) andNum3:(int)(lbl1 + 1)];
    }
//    if (price == 0) {
//        self.lbl1.text = @"";
//        self.lbl2.text = @"";
//        
//        self.lbl3.text = @"";
//    }else{
//        self.lbl1.text = [NSString stringWithFormat:@"每日拜访%d位客户",(int)(lbl3 + 1)];
//        self.lbl2.text = [NSString stringWithFormat:@"每周送出%d份产品建议书",(int)(lbl2 + 1)];
//        
//        self.lbl3.text = [NSString stringWithFormat:@"每月成交%d张保单",(int)(lbl1 + 1)];
//    }
    
}
-(void)lblresultNum1:(int)num1 andNum2:(int)num2 andNum3:(int)num3
{
    NSMutableAttributedString *attribute1 = [[NSMutableAttributedString alloc] init];
    NSAttributedString *lblt1 = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"每日拜访"] attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:15], NSForegroundColorAttributeName : [UIColor whiteColor]}];
    NSAttributedString *number1;
    if (num1 == 0) {
        number1 = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"   "] attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:20], NSForegroundColorAttributeName : [UIColor whiteColor]}];
    }
    else{
        number1 = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" %d ",num1] attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:20], NSForegroundColorAttributeName : [UIColor whiteColor]}];
    }
    
    NSAttributedString *lblw1 = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"位客户"] attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:15], NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    [attribute1 appendAttributedString:lblt1];
    [attribute1 appendAttributedString:number1];
    [attribute1 appendAttributedString:lblw1];
    self.lbl1.attributedText = attribute1;
    
    NSMutableAttributedString *attribute2 = [[NSMutableAttributedString alloc] init];
    NSAttributedString *lblt2 = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"每周送出"] attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15], NSForegroundColorAttributeName : [UIColor whiteColor]}];
    NSAttributedString *number2;
    if (num2 == 0) {
        number2 = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"   "] attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:20], NSForegroundColorAttributeName : [UIColor whiteColor]}];
    }
    else{
        number2 = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" %d ",num2] attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:20], NSForegroundColorAttributeName : [UIColor whiteColor]}];
    }
    NSAttributedString *lblw2 = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"份产品建议书"] attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15], NSForegroundColorAttributeName : [UIColor whiteColor]}];
     
    [attribute2 appendAttributedString:lblt2];
    [attribute2 appendAttributedString:number2];
    [attribute2 appendAttributedString:lblw2];
    self.lbl2.attributedText = attribute2;
    
    NSMutableAttributedString *attribute3 = [[NSMutableAttributedString alloc] init];
    NSAttributedString *lblt3 = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"每月成交"] attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15], NSForegroundColorAttributeName : [UIColor whiteColor]}];
        NSAttributedString *number3;
        if (num3 == 0) {
            number3 = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"   "] attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:20], NSForegroundColorAttributeName : [UIColor whiteColor]}];
        }
        else{
            number3 = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" %d ",num3] attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:20], NSForegroundColorAttributeName : [UIColor whiteColor]}];
        }
    NSAttributedString *lblw3 = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"张保单"] attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15], NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    [attribute3 appendAttributedString:lblt3];
    [attribute3 appendAttributedString:number3];
    [attribute3 appendAttributedString:lblw3];
    self.lbl3.attributedText = attribute3;
    
}




- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)segmentAction:(UISegmentedControl *)sender {
    NSInteger i = sender.selectedSegmentIndex;
    [self chartValue:i];
    if (i == 0) {
        //self.imgChart.image = [UIImage imageNamed:@"ftd_xiaoshoupic.png"];
         self.viewZuzhiInfo.hidden = YES;
        self.btnSegmentCol.tintColor = [UIColor colorWithRed:0.82 green:0.07 blue:0.27 alpha:1];
    }
    else{
        //self.imgChart.image = [UIImage imageNamed:@"ftd_zuzhipic.png"];
        self.btnSegmentCol.tintColor = [UIColor colorWithRed:0.05 green:0.25 blue:0.49 alpha:1];
        self.viewZuzhiInfo.hidden = NO;
    }
    
    
    
    
    
    
}
- (IBAction)IWantAction:(id)sender {
    //[self changeLblText:self.price];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
