//
//  FTDCustomCalculationViewController.m
//  FaceTalk
//
//  Created by Mao-MacPro on 15/11/19.
//  Copyright © 2015年 wen. All rights reserved.
//

#import "FTDCustomCalculationViewController.h"
#import "FTDChangePrice.h"
@interface FTDCustomCalculationViewController ()
- (IBAction)backAction:(id)sender;
- (IBAction)segmentAction:(id)sender;
- (IBAction)calculationAction:(id)sender;

@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentCol;
@property (strong, nonatomic) IBOutlet UILabel *lblPrice;
@property (strong, nonatomic) IBOutlet UIButton *btnSlider;
@property (strong, nonatomic) IBOutlet UIView *viewZuzhi;
@property (strong, nonatomic) IBOutlet UITextField *textKehu;
@property (strong, nonatomic) IBOutlet UILabel *lblAdviceBookNum;
@property (strong, nonatomic) IBOutlet UILabel *lblPolicyNum;
@property (strong, nonatomic) IBOutlet UIView *viewRed;
@end

@implementation FTDCustomCalculationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.lblPrice.layer setCornerRadius:3];
    [self.lblPrice.layer setMasksToBounds:YES];
    [self.btnSlider  addTarget:self action:@selector(AdragMoving:withEvent: ) forControlEvents:UIControlEventTouchDragInside];
    [self.btnSlider addTarget:self action:@selector(AdragEnded:withEvent: )forControlEvents: UIControlEventTouchUpInside |
     UIControlEventTouchUpOutside];
    self.viewZuzhi.hidden = YES;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) AdragMoving: (UIControl *) c withEvent:ev
{
    
    CGPoint point=[[[ev allTouches] anyObject] locationInView:self.viewRed];
    point.y = 52;
    if (point.x < 134 || point.x > 314) {
        return;
    }
    
    
    c.center =point;
    
    int price ;
    
    price = (point.x  - 134) / 179 * 20000;
    if (price > 20000) {
        price = 20000;
    }
    
    self.lblPrice.center =CGPointMake(point.x, 26);
    self.lblPrice.text = [FTDChangePrice changePriceFromint:price];
    //[self changeLblText:price];
    //view.center=CGPointMake(point.x, 400-140);
    
}
- (void) AdragEnded: (UIControl *) c withEvent:ev
{
    
    CGPoint point=[[[ev allTouches] anyObject] locationInView:self.viewRed];
    point.y = 52;
    if (point.x < 135 || point.x > 313) {
        return;
    }
    c.center =point;
    
    
    
    //view.center=CGPointMake(point.x, 400-140);
    
}

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)segmentAction:(UISegmentedControl *)sender {
    NSInteger i = sender.selectedSegmentIndex;
    //[self chartValue:i];
    if (i == 0) {
        //self.imgChart.image = [UIImage imageNamed:@"ftd_xiaoshoupic.png"];
        self.viewZuzhi.hidden = YES;
        self.segmentCol.tintColor = [UIColor colorWithRed:0.82 green:0.07 blue:0.27 alpha:1];
    }
    else{
        //self.imgChart.image = [UIImage imageNamed:@"ftd_zuzhipic.png"];
        self.segmentCol.tintColor = [UIColor colorWithRed:0.05 green:0.25 blue:0.49 alpha:1];
        self.viewZuzhi.hidden = NO;
    }

    
}

- (IBAction)calculationAction:(id)sender {
    float kehu = [self.textKehu.text floatValue];
    float book = kehu * 22 / 10;
    float policy = book * 3 / 4;
    
    self.lblAdviceBookNum.text = [NSString stringWithFormat:@"%d",(int)(book + 1)];
    self.lblPolicyNum.text = [NSString stringWithFormat:@"%d",(int)(policy + 1)];
    
    
    
}
@end
